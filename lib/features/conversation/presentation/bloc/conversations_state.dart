import 'package:chugli/features/conversation/domain/entities/conversation_entity.dart';

class ConversationsError extends ConversationsState {
  final String error;

  ConversationsError({required this.error});
}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoaded extends ConversationsState {
  final List<ConversationEntity> conversations;

  ConversationsLoaded({required this.conversations});
}

class ConversationsLoading extends ConversationsState {}

abstract class ConversationsState {}
