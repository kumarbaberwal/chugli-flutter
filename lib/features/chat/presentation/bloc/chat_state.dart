import 'package:vibematch/features/chat/domain/entities/daily_question_entity.dart';
import 'package:vibematch/features/chat/domain/entities/message_entity.dart';

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}

class ChatLoadedState extends ChatState {
  final List<MessageEntity> messages;
  ChatLoadedState({required this.messages});
}

class ChatLoadingState extends ChatState {}

abstract class ChatState {}

class DailyQuestionLoadState extends ChatState {
  final DailyQuestionEntity questionEntity;

  DailyQuestionLoadState({required this.questionEntity});
}
