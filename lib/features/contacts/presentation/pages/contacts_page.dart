import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibematch/core/theme.dart';
import 'package:vibematch/features/chat/presentation/pages/chat_page.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_state.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 70,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) async {
          final contactsBloc = BlocProvider.of<ContactsBloc>(context);
          if (state is ConversationsReady) {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  conversationId: state.conversationId,
                  mate: state.contactEntity.username,
                  image: state.contactEntity.contactImage,
                ),
              ),
            );
            if (res == null) {
              contactsBloc.add(FetchContactsEvent());
            }
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        contact.contactImage,
                        scale: 1.0,
                      ),
                      radius: 30,
                    ),
                    title: Text(
                      contact.username,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      contact.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      BlocProvider.of<ContactsBloc>(context).add(
                        CheckOrCreateConversationsEvent(
                          contactId: contact.id,
                          contactEntity: contact,
                        ),
                      );
                    },
                  );
                },
                itemCount: state.contacts.length,
              );
            } else if (state is ContactsError) {
              return Center(
                child: Text(state.error),
              );
            }
            return Center(
              child: Text('No Contacts Found'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<ContactsBloc>(context).add(FetchContactsEvent());
    super.initState();
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add contact',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter Contact Email',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              log(email);
              if (email.isNotEmpty) {
                BlocProvider.of<ContactsBloc>(context)
                    .add(AddContactEvent(email: email));
                Navigator.pop(context);
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(DefaultColors.buttonColor)),
            child: Text(
              'Add',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
