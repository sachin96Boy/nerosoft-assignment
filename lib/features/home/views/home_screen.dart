import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/features/auth/provider/auth_provider.dart';
import 'package:nerosoft_app/features/auth/service/auth_service.dart';
import 'package:nerosoft_app/features/home/service/home_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _handleLogout() async {
    await ref.read(authServiceProvider.notifier).logout();
  }

  void handlefilter() async {
    await ref.read(homeServiceProvider.notifier).getSalesData();
  }

  @override
  Widget build(BuildContext context) {
    final authResponse = ref.watch(authResponseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nerosoft Home'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _handleLogout, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: SizedBox(
          child: authResponse.when(
            data: (value) {
              return Column(
                children: [
                  Text('body of home'),
                  Text(value.auth!.uid.toString()),
                  Text(value.auth!.password),
                  TextButton(onPressed: handlefilter, child: Text('submit'))
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
