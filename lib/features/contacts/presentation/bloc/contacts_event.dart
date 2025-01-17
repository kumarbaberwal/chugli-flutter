import 'package:vibematch/features/contacts/domain/entities/contact_entity.dart';

class AddContactEvent extends ContactsEvent {
  final String email;

  AddContactEvent({required this.email});
}

class CheckOrCreateConversationsEvent extends ContactsEvent {
  final String contactId;
  final ContactEntity contactEntity;

  CheckOrCreateConversationsEvent({
    required this.contactId,
    required this.contactEntity,
  });
}

abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}

class FetchRecentContactsEvent extends ContactsEvent {}
