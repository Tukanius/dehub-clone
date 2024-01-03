import 'package:dehub/src/product_module/screens/item_type/add_item_type.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventoryItemType extends StatefulWidget {
  static const routeName = '/InventoryItemType';
  const InventoryItemType({Key? key}) : super(key: key);

  @override
  State<InventoryItemType> createState() => _InventoryItemTypeState();
}

class _InventoryItemTypeState extends State<InventoryItemType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: productColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text(
          'Нэр төрөл',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddItemType(),
          );
        },
        shape: CircleBorder(),
        backgroundColor: productColor,
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text('Бүртгэсэн ажилтан'),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Нэр төрөл',
                    style: TextStyle(color: dark),
                  ),
                  SvgPicture.asset(
                    'assets/svg/edit_rounded.svg',
                    colorFilter:
                        ColorFilter.mode(productColor, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text('Системд тохируулсан'),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Нэр төрөл',
                    style: TextStyle(color: dark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
