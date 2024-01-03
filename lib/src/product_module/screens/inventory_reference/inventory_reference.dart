import 'package:dehub/components/inventory_reference_card/inventory_reference_card.dart';
import 'package:dehub/src/product_module/screens/brand/brand.dart';
import 'package:dehub/src/product_module/screens/classification/inventory_classification.dart';
import 'package:dehub/src/product_module/screens/item_type/inventory_item_type.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InventoryReferencePage extends StatefulWidget {
  static const routeName = '/InventoryReferencePage';
  const InventoryReferencePage({Key? key}) : super(key: key);

  @override
  State<InventoryReferencePage> createState() => InventoryReferencePageState();
}

class InventoryReferencePageState extends State<InventoryReferencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: white,
        backgroundColor: white,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
          'Лавлах жагсаалт',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Лавлах мэдээллийг сонгоно уу',
              ),
            ),
            InventoryReferenceCard(
              refCode: 'REF-100000',
              labelText: 'Брэнд',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryBrand.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100001',
              labelText: 'Нэр төрөл',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryItemType.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100002',
              labelText: 'Ангилал',
              onClick: () {
                Navigator.of(context)
                    .pushNamed(InventoryClassification.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100003',
              labelText: 'Дэд ангилал',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100004',
              labelText: 'Категори',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100005',
              labelText: 'Дэд категори',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100006',
              labelText: 'Дистрибютор',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100007',
              labelText: 'Үйлдвэрлэгч',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100008',
              labelText: 'Tag',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100009',
              labelText: 'Хэмжих нэгж',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100010',
              labelText: 'Барааны динамик мэдээлэл',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100011',
              labelText: 'Сав баглаа боодол',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100012',
              labelText: 'Хүргэлтийн нөхцөл',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100013',
              labelText: 'Хувилбарын төрөл',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100014',
              labelText: 'Үнийн бүлэг',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100015',
              labelText: 'Идэвхгүй болгох шалтгаан',
              onClick: () {},
            ),
            InventoryReferenceCard(
              refCode: 'REF-100016',
              labelText: 'Нөөцийн хөдөлгөөн тайлбар',
              onClick: () {},
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
