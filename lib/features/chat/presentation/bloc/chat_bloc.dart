// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:vibematch/core/socket_service.dart';
import 'package:vibematch/features/chat/domain/entities/message_entity.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_daily_question_use_case.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:vibematch/features/chat/presentation/bloc/chat_event.dart';
import 'package:vibematch/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessagesUseCase fetchMessagesUseCase;
  final FetchDailyQuestionUseCase fetchDailyQuestionUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();
  ChatBloc({
    required this.fetchMessagesUseCase,
    required this.fetchDailyQuestionUseCase,
  }) : super(ChatLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
    on<LoadDailyQuestionEvent>(_onLoadDailyQuestion);
  }

  Future<void> _onLoadDailyQuestion(
      LoadDailyQuestionEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoadingState());
      final dailyQuestion =
          await fetchDailyQuestionUseCase(conversationId: event.conversationId);
      emit(DailyQuestionLoadState(questionEntity: dailyQuestion));
    } catch (e) {
      emit(ChatErrorState(message: e.toString()));
    }
  }

  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      final message = await fetchMessagesUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(message);
      emit(ChatLoadedState(messages: List.from(_messages)));
      _socketService.socket.off('newMessage');
      _socketService.socket.emit('joinConversation', event.conversationId);
      _socketService.socket.on('newMessage', (data) {
        log('Step 1 - receive : $data');
        add(ReceiveMessageEvent(message: data));
      });
    } catch (e) {
      emit(ChatErrorState(message: e.toString()));
    }
  }

  Future<void> _onReceiveMessage(
      ReceiveMessageEvent event, Emitter<ChatState> emit) async {
    log('Step 2 - receive event called : ${event.message}');
    final message = MessageEntity(
      id: event.message['id'],
      conversationId: event.message['conversation_id'],
      senderId: event.message['sender_id'],
      content: event.message['content'],
      createdAt: event.message['created_at'],
    );
    _messages.add(message);
    emit(ChatLoadedState(messages: List.from(_messages)));
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final userId = await _storage.read(key: 'userId');
    log('User id : $userId');
    final newMessage = {
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId,
    };

    log(jsonEncode(newMessage));

    _socketService.socket.emit('sendMessage', newMessage);
  }
}
