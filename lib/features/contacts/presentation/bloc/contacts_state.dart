import 'package:chugli/features/contacts/domain/entities/contact_entity.dart';

class ContactAdded extends ContactsState {}

class ContactsError extends ContactsState {
  final String error;

  ContactsError({required this.error});
}

class ContactsInitial extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactEntity> contacts;
  ContactsLoaded({required this.contacts});
}

class ContactsLoading extends ContactsState {}

abstract class ContactsState {}

class ConversationsReady extends ContactsState {
  final String conversationId;
  final String contactName;

  ConversationsReady({required this.conversationId, required this.contactName});
}
