import 'package:get_it/get_it.dart';
import 'package:vibematch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vibematch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vibematch/features/auth/domain/repositories/auth_repository.dart';
import 'package:vibematch/features/auth/domain/usecases/login_use_case.dart';
import 'package:vibematch/features/auth/domain/usecases/register_use_case.dart';
import 'package:vibematch/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:vibematch/features/chat/data/repositories/message_repository_impl.dart';
import 'package:vibematch/features/chat/domain/repositories/message_repository.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_daily_question_use_case.dart';
import 'package:vibematch/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:vibematch/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:vibematch/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:vibematch/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:vibematch/features/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:vibematch/features/contacts/domain/usecases/fetch_recent_contacts_use_case.dart';
import 'package:vibematch/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:vibematch/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:vibematch/features/conversation/domain/repositories/conversations_repository.dart';
import 'package:vibematch/features/conversation/domain/usecases/check_or_create_conversations_use_case.dart';
import 'package:vibematch/features/conversation/domain/usecases/fetch_conversations_use_case.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  const String baseUrl = "http://192.168.102.140:3000/";

  // data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ConversationRemoteDataSource>(
      () => ConversationRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ContactsRemoteDataSource>(
      () => ContactsRemoteDataSource(baseUrl: baseUrl));

  // repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<ConversationsRepository>(
      () => ConversationRepositoryImpl(conversationRemoteDataSource: sl()));
  sl.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(messagesRemoteDataSource: sl()));
  sl.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(contactsRemoteDataSource: sl()));

  // use cases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton<FetchConversationsUseCase>(
      () => FetchConversationsUseCase(repository: sl()));
  sl.registerLazySingleton<FetchMessagesUseCase>(
      () => FetchMessagesUseCase(messageRepository: sl()));
  sl.registerLazySingleton<FetchDailyQuestionUseCase>(
      () => FetchDailyQuestionUseCase(messageRepository: sl()));
  sl.registerLazySingleton<FetchContactsUseCase>(
      () => FetchContactsUseCase(contactsRepository: sl()));
  sl.registerLazySingleton<AddContactUseCase>(
      () => AddContactUseCase(contactsRepository: sl()));
  sl.registerLazySingleton<CheckOrCreateConversationsUseCase>(
      () => CheckOrCreateConversationsUseCase(conversationsRepository: sl()));
  sl.registerLazySingleton<FetchRecentContactsUseCase>(
      () => FetchRecentContactsUseCase(contactsRepository: sl()));
}
