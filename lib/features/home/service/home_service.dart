import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nerosoft_app/common/utils/apis.dart';
import 'package:nerosoft_app/features/auth/provider/auth_provider.dart';
import 'package:nerosoft_app/features/home/models/sales_model.dart';

import 'package:xml_rpc/client.dart' as xml_rpc;

class HomeService extends AutoDisposeNotifier<AsyncValue<dynamic>> {
  @override
  AsyncValue build() {
    return AsyncValue.data(null);
  }

  Future<List<SalesModel>> getSalesData() async {
    try {
      final salesUri = Uri.parse(Api.sales);

      final authresponseData = ref.read(authResponseProvider).value;

      if (authresponseData != null) {
        final responseData = await xml_rpc.call(salesUri, 'execute_kw', [
          Api.databaseIns,
          authresponseData.auth!.uid,
          authresponseData.auth!.password,
          'sale.order',
          'search_read',
          [
            [
              [
                'create_date',
                '<',
                DateFormat("yyyyMMdd'T'HH:mm:ss").format(DateTime.now())
              ]
            ]
          ],
          {
            'fields': [
              'name',
              'company_id',
              'access_url',
              'partner_id',
              'date_order',
              'create_date',
              'state'
            ],
            'limit': 10
          }
        ]);

        final output = responseData as List<dynamic>;

        final salesList = output.map((element) {
          final sale = SalesModel.fromJson(element);
          return sale;
        }).toList();

        return salesList;
      }
      return [];
    } on Exception catch (err) {
      print(err);
      throw Exception(err.toString());
    }
  }
}

final homeServiceProvider =
    AutoDisposeNotifierProvider<HomeService, AsyncValue<dynamic>>(() {
  return HomeService();
});
