import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/features/auth/provider/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authResponse = ref.watch(authResponseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nerosoft Home'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          child: authResponse.when(
            data: (value) {
              return Column(
                children: [
                  Text('body of home'),
                  Text(value.auth!.uid.toString()),
                ],
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
