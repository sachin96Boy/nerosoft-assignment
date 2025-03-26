import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/common/components/sales_card.dart';
import 'package:nerosoft_app/features/auth/service/auth_service.dart';
import 'package:nerosoft_app/features/home/provider/sales_provider.dart';
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
    final salesItemsProvider = ref.watch(salesResponseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nerosoft Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _handleLogout,
              icon: Icon(Icons.logout),
              style: IconButton.styleFrom(
                  padding: EdgeInsets.all(4),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.red))
        ],
      ),
      body: Center(
        child: SizedBox(
          child: salesItemsProvider.when(
            data: (salesItemList) {
              return salesItemList.isNotEmpty
                  ? ListView.separated(
                      itemCount: salesItemList.length,
                      itemBuilder: (context, index) {
                        return SalesTile(salesmodel: salesItemList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    )
                  : SizedBox(
                      child: Text("Please Insert Data"),
                    );
            },
            error: (error, stackTrace) {
              return SingleChildScrollView(child: Text(error.toString()));
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
