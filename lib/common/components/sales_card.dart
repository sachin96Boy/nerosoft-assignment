import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:nerosoft_app/features/home/models/sales_model.dart';
import 'package:nerosoft_app/features/home/provider/sales_provider.dart';

class SalesTile extends ConsumerWidget {
  final SalesModel salesmodel;

  const SalesTile({super.key, required this.salesmodel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleConfirm() async {
      await ref
          .read(salesResponseProvider.notifier)
          .handleConfirmAction(salesmodel.id);
    }

    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            handleConfirm();
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.badge,
          label: 'Confirm',
        ),
      ]),
      child: ListTile(
        tileColor: Colors.blue.shade300,
        leading: Container(
          padding: EdgeInsets.all(6),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(
            salesmodel.state == 'draft' ? Icons.cases_outlined : Icons.note,
            color: salesmodel.state == 'draft' ? Colors.red : Colors.green,
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
