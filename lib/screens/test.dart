import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with AfterLayoutMixin {
  Map<DateTime, List<Invoice>> groupedItems = {};
  Result result = Result(rows: [], count: 0);
  int page = 1;
  int limit = 10;
  bool isloading = true;
  List<Invoice> invoice = [];

  @override
  afterFirstLayout(BuildContext context) async {
    // for (var item in itemList) {
    //   DateTime asdf = item.date;

    //   if (groupedItems.containsKey(asdf)) {
    //     groupedItems[asdf]!.add(item);
    //     print('----------');
    //   } else {
    //     groupedItems[asdf] = [item];
    //     print('=========');
    //   }
    // }
    // groupedItems.forEach((date, items) {
    //   print("Date: $date");
    //   for (var item in items) {
    //     print("Name: ${item.name}");
    //   }
    // });
    await list(page, limit);
  }

  makeGroup() {
    if (result.rows?.length != 0) {
      for (var data in result.rows!) {
        DateTime date =
            DateTime.parse(DateFormat("yyyy-MM-dd").format(data.createdAt));
        if (groupedItems.containsKey(date)) {
          groupedItems[date]!.add(data);
        } else {
          groupedItems[date] = [data];
        }
      }
      groupedItems.forEach((key, value) {
        invoice.add(
          Invoice(
            header: key,
            values: value,
          ),
        );
      });
    }
  }

  list(page, limit) async {
    Filter filter = Filter(query: '');
    Offset offset = Offset(page: page, limit: limit);
    var res = await InvoiceApi()
        .list(ResultArguments(offset: offset, filter: filter));
    setState(() {
      result = res;
      isloading = false;
    });
    makeGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Column(
            //   children: invoice
            //       .map(
            //         (data) => Column(
            //           children: [
            //             Text('${data.header}'),
            //             Column(
            //               children: data.values!
            //                   .map(
            //                     (item) => InvoiceCard(
            //                       data: item,
            //                     ),
            //                   )
            //                   .toList(),
            //             )
            //           ],
            //         ),
            //       )
            //       .toList(),
            // )
          ],
        ),
      ),
    );
  }
}
