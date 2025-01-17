import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibematch/core/socket_service.dart';
import 'package:vibematch/core/theme.dart';
import 'package:vibematch/di_container.dart';
import 'package:vibematch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vibematch/features/auth/presentation/pages/login_page.dart';
import 'package:vibematch/features/auth/presentation/pages/register_page.dart';
import 'package:vibematch/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:vibematch/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:vibematch/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:vibematch/features/conversation/presentation/pages/conversation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();
  setupDependencies();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            registerUseCase: sl(),
            loginUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ConversationsBloc(
            fetchConversationsUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ChatBloc(
            fetchMessagesUseCase: sl(),
            fetchDailyQuestionUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ContactsBloc(
            fetchContactsUseCase: sl(),
            addContactUseCase: sl(),
            checkOrCreateConversationsUseCase: sl(),
            fetchRecentContactsUseCase: sl(),
          ),
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
