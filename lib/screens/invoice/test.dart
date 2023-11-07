import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with AfterLayoutMixin {
  Map<DateTime, List<Item>> groupedItems = {};

  @override
  afterFirstLayout(BuildContext context) {
    for (var item in itemList) {
      DateTime date = item.date;

      if (groupedItems.containsKey(date)) {
        groupedItems[date]!.add(item);
      } else {
        groupedItems[date] = [item];
      }
    }
    print(groupedItems);
    groupedItems.forEach((date, items) {
      print("Date: $date");
      for (var item in items) {
        print("  ${item.name}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // groupedItems.forEach((key, value) {
            //   Text('${key}');
            //   for (var item in value) {
            //     Text('${item}');
            //   }
            // }),
          ],
        ),
      ),
    );
  }
}

class Item {
  String name;
  DateTime date;

  Item({required this.name, required this.date});
}

List<Item> itemList = [
  Item(name: "Item 1", date: DateTime(2023, 10, 15)),
  Item(name: "Item 2", date: DateTime(2023, 10, 14)),
  Item(name: "Item 3", date: DateTime(2023, 10, 15)),
  Item(name: "Item 4", date: DateTime(2023, 10, 16)),
  Item(name: "Item 5", date: DateTime(2023, 10, 14)),
];
