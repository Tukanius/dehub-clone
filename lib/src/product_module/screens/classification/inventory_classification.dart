import 'package:dehub/src/product_module/screens/classification/add_classification.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InventoryClassification extends StatefulWidget {
  static const routeName = '/InventoryClassification';
  const InventoryClassification({Key? key}) : super(key: key);

  @override
  State<InventoryClassification> createState() =>
      _InventoryClassificationState();
}

class _InventoryClassificationState extends State<InventoryClassification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
          'Ангилал',
          style: TextStyle(color: productColor, fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            builder: (context) => AddClassification(),
          );
        },
        backgroundColor: productColor,
        child: Icon(
          Icons.add,
          color: white,
        ),
        shape: CircleBorder(),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ангилал',
                        style: TextStyle(color: productColor),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text('Нэр төрөл'),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: productColor,
                    size: 16,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text('Системд тохируулсан'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ангилал',
                        style: TextStyle(color: productColor),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text('Нэр төрөл'),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: productColor,
                    size: 16,
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
