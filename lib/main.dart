import 'package:chugli/chat_page.dart';
import 'package:chugli/core/theme.dart';
import 'package:chugli/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chugli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chugli/features/auth/domain/usecases/login_use_case.dart';
import 'package:chugli/features/auth/domain/usecases/register_use_case.dart';
import 'package:chugli/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chugli/features/auth/presentation/pages/login_page.dart';
import 'package:chugli/features/auth/presentation/pages/register_page.dart';
import 'package:chugli/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:chugli/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:chugli/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chugli/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:chugli/features/conversation/presentation/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    authRepositoryImpl: AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSource(),
    ),
    conversationRepositoryImpl: ConversationRepositoryImpl(
      conversationRemoteDataSource: ConversationRemoteDataSource(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationRepositoryImpl conversationRepositoryImpl;

  const MyApp(
      {super.key,
      required this.authRepositoryImpl,
      required this.conversationRepositoryImpl});

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const LoginPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/chatPage': (_) => const ChatPage(),
          '/conversationPage': (_) => const ConversationPage(),
        },
      ),
    );
  }
}
