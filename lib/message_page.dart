import 'package:chugli/core/theme.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
                _buildRecentContact(context, "Kumar"),
              ],
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
              child: ListView(
                children: [
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                  _buildMessageTile("Kumar", "Hii", "16:30"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageTile(String name, String message, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage("https://placehold.co/400"),
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
        time,
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
            backgroundImage: NetworkImage('https://placehold.co/400'),
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
