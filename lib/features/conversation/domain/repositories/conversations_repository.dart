import 'package:chugli/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<List<ConversationEntity>> fetchConversations();
  Future<String> checkOrCreateConversations({required String contactId});
}
