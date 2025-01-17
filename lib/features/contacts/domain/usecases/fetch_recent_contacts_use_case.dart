import 'package:vibematch/features/contacts/domain/repositories/contacts_repository.dart';

import '../entities/contact_entity.dart';

class FetchRecentContactsUseCase {
  final ContactsRepository contactsRepository;

  FetchRecentContactsUseCase({required this.contactsRepository});

  Future<List<ContactEntity>> call() async {
    return await contactsRepository.fetchRecentContacts();
  }
}
