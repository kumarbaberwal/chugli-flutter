import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibematch/features/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_recent_contacts_use_case.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:vibematch/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationsUseCase checkOrCreateConversationsUseCase;
  final FetchRecentContactsUseCase fetchRecentContactsUseCase;
  ContactsBloc({
    required this.fetchContactsUseCase,
    required this.addContactUseCase,
    required this.checkOrCreateConversationsUseCase,
    required this.fetchRecentContactsUseCase,
  }) : super(ContactsInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
    on<AddContactEvent>(_onAddContact);
    on<CheckOrCreateConversationsEvent>(_onCheckOrCreateConversations);
    on<FetchRecentContactsEvent>(_onFetchRecentContacts);
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
        conversationId: conversationId,
        contactEntity: event.contactEntity,
      ));
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

  Future<void> _onFetchRecentContacts(
      FetchRecentContactsEvent event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());

    try {
      final recentContacts = await fetchRecentContactsUseCase();

      emit(RecentContactsLoaded(recentContacts: recentContacts));
    } catch (e) {
      emit(ContactsError(error: 'Failed to load recent contacts'));
    }
  }
}
