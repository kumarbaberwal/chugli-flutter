import 'package:vibematch/features/conversation/domain/entities/conversation_entity.dart';
import 'package:vibematch/features/conversation/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;
  FetchConversationsUseCase({
    required this.repository,
  });

  Future<List<ConversationEntity>> call() async {
    return await repository.fetchConversations();
  }
}
