import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibematch/core/socket_service.dart';
import 'package:vibematch/core/theme.dart';
import 'package:vibematch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vibematch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vibematch/features/auth/domain/usecases/login_use_case.dart';
import 'package:vibematch/features/auth/domain/usecases/register_use_case.dart';
import 'package:vibematch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vibematch/features/auth/presentation/pages/login_page.dart';
import 'package:vibematch/features/auth/presentation/pages/register_page.dart';
import 'package:vibematch/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:vibematch/features/chat/data/repositories/message_repository_impl.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_daily_question_use_case.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:vibematch/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:vibematch/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:vibematch/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:vibematch/features/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:vibematch/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:vibematch/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:vibematch/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:vibematch/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:vibematch/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:vibematch/features/conversation/presentation/pages/conversation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  final conversationRepository = ConversationRepositoryImpl(
    conversationRemoteDataSource: ConversationRemoteDataSource(),
  );
  final messageRepository = MessageRepositoryImpl(
    messagesRemoteDataSource: MessagesRemoteDataSource(),
  );
  final contactsRepository = ContactsRepositoryImpl(
    contactsRemoteDataSource: ContactsRemoteDataSource(),
  );
  runApp(
    MyApp(
      authRepositoryImpl: authRepository,
      conversationRepositoryImpl: conversationRepository,
      messageRepositoryImpl: messageRepository,
      contactsRepositoryImpl: contactsRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationRepositoryImpl conversationRepositoryImpl;
  final MessageRepositoryImpl messageRepositoryImpl;
  final ContactsRepositoryImpl contactsRepositoryImpl;

  const MyApp({
    super.key,
    required this.authRepositoryImpl,
    required this.conversationRepositoryImpl,
    required this.messageRepositoryImpl,
    required this.contactsRepositoryImpl,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepositoryImpl),
            loginUseCase: LoginUseCase(repository: authRepositoryImpl),
          ),
        ),
        BlocProvider(
          create: (context) => ConversationsBloc(
            fetchConversationsUseCase: FetchConversationsUseCase(
                repository: conversationRepositoryImpl),
          ),
        ),
        BlocProvider(
          create: (context) => ChatBloc(
            fetchMessagesUseCase:
                FetchMessagesUseCase(messageRepository: messageRepositoryImpl),
            fetchDailyQuestionUseCase: FetchDailyQuestionUseCase(
                messageRepository: messageRepositoryImpl),
          ),
        ),
        BlocProvider(
          create: (context) => ContactsBloc(
              fetchContactsUseCase: FetchContactsUseCase(
                  contactsRepository: contactsRepositoryImpl),
              addContactUseCase:
                  AddContactUseCase(contactsRepository: contactsRepositoryImpl),
              checkOrCreateConversationsUseCase:
                  CheckOrCreateConversationsUseCase(
                      conversationsRepository: conversationRepositoryImpl)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const LoginPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/conversationPage': (_) => const ConversationPage(),
        },
      ),
    );
  }
}
