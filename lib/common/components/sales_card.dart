import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nerosoft_app/features/home/models/sales_model.dart';

class SalesTile extends ConsumerWidget {
  final SalesModel salesmodel;

  const SalesTile({super.key, required this.salesmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: Colors.blue.shade300,
      leading: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(
          salesmodel.state == '' ? Icons.cases : Icons.note,
          color: Colors.green,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            salesmodel.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            salesmodel.partnerId[1],
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.yMMMMEEEEd().format(
              DateTime.parse(salesmodel.createDate),
            ),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
