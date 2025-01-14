import 'package:chugli/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsRepository {
  Future<void> addContact({required String email});
  Future<List<ContactEntity>> fetchContacts();
}
