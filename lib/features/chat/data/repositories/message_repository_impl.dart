import 'package:chugli/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:chugli/features/chat/domain/entities/message_entity.dart';
import 'package:chugli/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;

  MessageRepositoryImpl({
    required this.messagesRemoteDataSource,
  });
  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    return await messagesRemoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {}
}
