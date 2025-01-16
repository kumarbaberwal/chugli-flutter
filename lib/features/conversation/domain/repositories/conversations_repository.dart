import 'package:vibematch/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<String> checkOrCreateConversations({required String contactId});
  Future<List<ConversationEntity>> fetchConversations();
}
