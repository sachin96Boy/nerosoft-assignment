import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/features/auth/provider/auth_provider.dart';
import 'package:nerosoft_app/features/auth/views/auth_screen.dart';
import 'package:nerosoft_app/features/home/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authResponse = ref.watch(authResponseProvider);

    return MaterialApp(
      title: 'Nerosoft Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authResponse.when(
        data: (data) {
          return data.auth != null ? HomeScreen() : AuthScreen();
        },
        error: (error, stackTrace) {
          return Scaffold(body: Text(error.toString()));
        },
        loading: () => Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
