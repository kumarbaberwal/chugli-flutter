abstract class ChatEvent {}

class LoadDailyQuestionEvent extends ChatEvent {
  final String conversationId;
  LoadDailyQuestionEvent({required this.conversationId});
}

class LoadMessagesEvent extends ChatEvent {
  final String conversationId;
  LoadMessagesEvent({required this.conversationId});
}

class ReceiveMessageEvent extends ChatEvent {
  final Map<String, dynamic> message;
  ReceiveMessageEvent({required this.message});
}

class SendMessageEvent extends ChatEvent {
  final String conversationId;
  final String content;
  SendMessageEvent({required this.conversationId, required this.content});
}
