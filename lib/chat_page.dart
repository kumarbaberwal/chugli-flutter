import 'package:cached_network_image/cached_network_image.dart';
import 'package:chugli/core/theme.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
              "Kumar",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // padding: const EdgeInsets.all(20),
              children: [
                _buildReceivedMessage(context, "Hi.. I am Kumar Here"),
                _buildSentMessage(context, "Hi.. This is Kavya Here..."),
                _buildReceivedMessage(context, "How are you Kavya Roy..?"),
                _buildSentMessage(context, "I am Fine Nitesh"),
                _buildReceivedMessage(context, "So.. What are you doing?"),
                _buildSentMessage(context, "Nothing... Kuch kaam tha kya?"),
                _buildReceivedMessage(
                    context, "Arey Nahi aise hi preshan kr rha hu 😂"),
                _buildSentMessage(context, "Krke to dikha muh tod dungi.. 😁"),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
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
          const Expanded(
            child: TextField(
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
            child: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onTap: () {},
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
}
