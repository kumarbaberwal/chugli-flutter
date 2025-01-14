import 'package:chugli/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:chugli/features/contacts/domain/entities/contact_entity.dart';
import 'package:chugli/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl({required this.contactsRemoteDataSource});
  @override
  Future<void> addContact({required String email}) async {
    return await contactsRemoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    return await contactsRemoteDataSource.fetchContacts();
  }
}
