import 'package:chugli/core/socket_service.dart';
import 'package:chugli/core/theme.dart';
import 'package:chugli/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chugli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chugli/features/auth/domain/usecases/login_use_case.dart';
import 'package:chugli/features/auth/domain/usecases/register_use_case.dart';
import 'package:chugli/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chugli/features/auth/presentation/pages/login_page.dart';
import 'package:chugli/features/auth/presentation/pages/register_page.dart';
import 'package:chugli/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:chugli/features/chat/data/repositories/message_repository_impl.dart';
import 'package:chugli/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:chugli/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chugli/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:chugli/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chugli/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chugli/features/conversation/presentation/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(
      authRepositoryImpl: authRepository,
      conversationRepositoryImpl: conversationRepository,
      messageRepositoryImpl: messageRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationRepositoryImpl conversationRepositoryImpl;
  final MessageRepositoryImpl messageRepositoryImpl;

  const MyApp({
    super.key,
    required this.authRepositoryImpl,
    required this.conversationRepositoryImpl,
    required this.messageRepositoryImpl,
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
          ),
        )
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
