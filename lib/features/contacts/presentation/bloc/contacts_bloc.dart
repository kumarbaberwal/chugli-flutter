import 'package:vibematch/features/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:vibematch/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationsUseCase checkOrCreateConversationsUseCase;
  ContactsBloc({
    required this.fetchContactsUseCase,
    required this.addContactUseCase,
    required this.checkOrCreateConversationsUseCase,
  }) : super(ContactsInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
    on<AddContactEvent>(_onAddContact);
    on<CheckOrCreateConversationsEvent>(_onCheckOrCreateConversations);
  }

  Future<void> _onAddContact(
      AddContactEvent event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      await addContactUseCase(email: event.email);
      emit(ContactAdded());
      add(FetchContactsEvent());
    } catch (e) {
      emit(ContactsError(error: e.toString()));
    }
  }

  Future<void> _onCheckOrCreateConversations(
      CheckOrCreateConversationsEvent event,
      Emitter<ContactsState> emit) async {
    try {
      emit(ContactsLoading());
      final conversationId =
          await checkOrCreateConversationsUseCase(contactId: event.contactId);
      emit(ConversationsReady(
          conversationId: conversationId, contactName: event.contactName));
    } catch (e) {
      emit(ContactsError(error: 'Failed to start conversations'));
    }
  }

  Future<void> _onFetchContacts(
      FetchContactsEvent event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUseCase();
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError(error: 'Failed to fetch contacts'));
    }
  }
}
