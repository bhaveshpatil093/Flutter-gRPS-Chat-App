import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_grpc_chat/core/theme/app_theme.dart';
import 'package:flutter_grpc_chat/core/di/injection.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_grpc_chat/features/chat/presentation/bloc/chat_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize AWS Amplify
  await _configureAmplify();
  
  // Initialize dependency injection
  await configureDependencies();
  
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins(
      authPlugins: [AmplifyAuthCognito()],
      storagePlugins: [AmplifyStorageS3()],
      dataStorePlugins: [AmplifyDataStorePlugin()],
    );
    await Amplify.configure('amplifyconfiguration.json');
  } catch (e) {
    debugPrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<AuthBloc>()),
        BlocProvider(create: (context) => GetIt.I<ChatBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter gRPC Chat',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
} 