import 'dart:developer';

import 'package:chugli/core/socket_service.dart';
import 'package:chugli/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();
  ConversationsBloc({required this.fetchConversationsUseCase})
      : super(ConversationsInitial()) {
    on<FetchConvesationsEvent>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _conversationUpdated(data) {
    add(FetchConvesationsEvent());
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdated', _conversationUpdated);
    } catch (e) {
      log('Error initializing socket listener: $e');
    }
  }

  Future<void> _onFetchConversations(
      FetchConvesationsEvent event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());

    try {
      final conversations = await fetchConversationsUseCase();

      emit(ConversationsLoaded(conversations: conversations));
    } catch (e) {
      emit(ConversationsError(error: 'Failed to load conversations'));
    }
  }
}
