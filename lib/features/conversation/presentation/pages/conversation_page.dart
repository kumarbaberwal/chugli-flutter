import 'package:cached_network_image/cached_network_image.dart';
import 'package:chugli/core/theme.dart';
import 'package:chugli/features/chat/presentation/pages/chat_page.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contacts/presentation/pages/contacts_page.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Message",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            height: 100,
            child: BlocBuilder<ConversationsBloc, ConversationsState>(
              builder: (context, state) {
                if (state is ConversationsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ConversationsLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final conversations = state.conversations[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                conversationId: conversations.id,
                                mate: conversations.participantName,
                              ),
                            ),
                          );
                        },
                        child: _buildRecentContact(context,
                            conversations.participantName),
                      );
                    },
                    itemCount: state.conversations.length,
                    scrollDirection: Axis.horizontal,
                  );
                }else if (state is ConversationsError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return const Center(
                    child: Text('No Recent Conversations Found'),
                  );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  if (state is ConversationsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ConversationsLoaded) {
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversations = state.conversations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    conversationId: conversations.id,
                                    mate: conversations.participantName),
                              ),
                            );
                          },
                          child: _buildMessageTile(
                            conversations.participantName,
                            conversations.lastMessage,
                            conversations.lastMessageTime
                                .toString()
                                .split('.')[0],
                          ),
                        );
                      },
                    );
                  } else if (state is ConversationsError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return const Center(
                    child: Text('No Conversation Found'),
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactsPage(),
            ),
          );
        },
        backgroundColor: DefaultColors.buttonColor,
        child: Icon(Icons.contacts),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConvesationsEvent());
  }

  Widget _buildMessageTile(String name, String message, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: const CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
          scale: 1.0,
        ),
        radius: 30,
      ),
      title: Text(
        name,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        time.toString(),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildRecentContact(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
              scale: 1.0,
            ),
            radius: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
