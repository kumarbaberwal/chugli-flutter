import 'package:chugli/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:chugli/features/conversation/domain/entities/conversation_entity.dart';
import 'package:chugli/features/conversation/domain/repositories/conversations_repository.dart';

class ConversationRepositoryImpl implements ConversationsRepository {
  final ConversationRemoteDataSource conversationRemoteDataSource;

  ConversationRepositoryImpl({required this.conversationRemoteDataSource});
  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await conversationRemoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversations({required String contactId}) async {
    return await conversationRemoteDataSource.checkOrCreateConversations(
        contactId: contactId);
  }
}
