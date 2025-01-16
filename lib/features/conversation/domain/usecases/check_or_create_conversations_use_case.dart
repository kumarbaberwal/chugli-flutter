import 'package:vibematch/features/conversation/domain/repositories/conversations_repository.dart';

class CheckOrCreateConversationsUseCase {
  final ConversationsRepository conversationsRepository;

  CheckOrCreateConversationsUseCase({required this.conversationsRepository});

  Future<String> call({required String contactId}) async {
    return await conversationsRepository.checkOrCreateConversations(
        contactId: contactId);
  }
}
