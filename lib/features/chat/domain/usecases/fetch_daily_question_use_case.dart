import 'package:vibematch/features/chat/domain/entities/daily_question_entity.dart';
import 'package:vibematch/features/chat/domain/repositories/message_repository.dart';

class FetchDailyQuestionUseCase {
  final MessageRepository messageRepository;
  FetchDailyQuestionUseCase({required this.messageRepository});

  Future<DailyQuestionEntity> call({required String conversationId}) async {
    return await messageRepository.fetchDailyQuestion(
      conversationId: conversationId,
    );
  }
}
