// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chugli/core/theme.dart';
import 'package:chugli/features/chat/presentation/bloc/chat_event.dart';
import 'package:chugli/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../bloc/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String mate;
  const ChatPage({
    super.key,
    required this.conversationId,
    required this.mate,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
                scale: 1.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.mate,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatLoadedState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isSentMessage = message.senderId == userId;
                      if (isSentMessage) {
                        return _buildSentMessage(context, message.content);
                      } else {
                        return _buildReceivedMessage(context, message.content);
                      }
                    },
                    padding: EdgeInsets.all(20),
                    itemCount: state.messages.length,
                  );
                } else if (state is ChatErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Center(
                  child: Text('No messages found'),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> fetchUserId() async {
    userId = await _storage.read(key: 'userId') ?? '';
    setState(() {
      userId = userId;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context)
        .add(LoadMessagesEvent(conversationId: widget.conversationId));
    fetchUserId();
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
          color: DefaultColors.sentMessageInput,
          borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  void _sendMessage() {
    final String content = _messageController.text;
    if (content.isNotEmpty) {
      log(widget.conversationId);
      log(content);
      BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(
        conversationId: widget.conversationId,
        content: content,
      ));
      _messageController.clear();
    }
  }
}
