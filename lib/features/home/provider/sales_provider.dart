import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nerosoft_app/features/home/models/sales_model.dart';
import 'package:nerosoft_app/features/home/service/home_service.dart';

class SalesProvider extends AutoDisposeAsyncNotifier<List<SalesModel>> {
  @override
  FutureOr<List<SalesModel>> build() {
    // TODO: implement build
    final data = getData();
    return data;
  }

  Future<List<SalesModel>> getData() async {
    final data = await ref.read(homeServiceProvider.notifier).getSalesData();
    return data;
  }
}

final salesResponseProvider =
    AutoDisposeAsyncNotifierProvider<SalesProvider, List<SalesModel>>(() {
  return SalesProvider();
});
