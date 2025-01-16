import 'package:vibematch/features/chat/domain/entities/daily_question_entity.dart';
import 'package:vibematch/features/chat/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<DailyQuestionEntity> fetchDailyQuestion(
      {required String conversationId});
  Future<List<MessageEntity>> fetchMessages(String conversationId);
  Future<void> sendMessage(MessageEntity message);
}
