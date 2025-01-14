class AddContactEvent extends ContactsEvent {
  final String email;

  AddContactEvent({required this.email});
}

class CheckOrCreateConversationsEvent extends ContactsEvent {
  final String contactId;
  final String contactName;

  CheckOrCreateConversationsEvent({
    required this.contactId,
    required this.contactName,
  });
}

abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}
