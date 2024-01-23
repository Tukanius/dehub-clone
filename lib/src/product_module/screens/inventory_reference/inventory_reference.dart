import 'package:dehub/components/inventory_reference_card/inventory_reference_card.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/adjustment_note/adjustment_note.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/brand/brand.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/classification/inventory_classification.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/delivery_type/delivery_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/distributor/distributor.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/dynamic_information.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inactive_types/inactive_types.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/item_type/inventory_item_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/manufacturer/manufacturer.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/options/options.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/package_type/package_type.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/price_tiers/price_tiers.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/tag/tag.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/unit/unit.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InventoryReferencePage extends StatefulWidget {
  static const routeName = '/InventoryReferencePage';
  const InventoryReferencePage({super.key});

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
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
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
              child: const Text(
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
                Navigator.of(context).pushNamed(
                  InventoryClassification.routeName,
                  arguments:
                      InventoryClassificationArguments(type: "CLASSIFICATION"),
                );
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100003',
              labelText: 'Дэд ангилал',
              onClick: () {
                Navigator.of(context).pushNamed(
                  InventoryClassification.routeName,
                  arguments: InventoryClassificationArguments(
                      type: "SUB_CLASSIFICATION"),
                );
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100004',
              labelText: 'Категори',
              onClick: () {
                Navigator.of(context).pushNamed(
                  InventoryClassification.routeName,
                  arguments: InventoryClassificationArguments(type: "CATEGORY"),
                );
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100005',
              labelText: 'Дэд категори',
              onClick: () {
                Navigator.of(context).pushNamed(
                  InventoryClassification.routeName,
                  arguments:
                      InventoryClassificationArguments(type: "SUB_CATEGORY"),
                );
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100006',
              labelText: 'Дистрибютор',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryDistributor.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100007',
              labelText: 'Үйлдвэрлэгч',
              onClick: () {
                Navigator.of(context)
                    .pushNamed(InventoryManufacturer.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100008',
              labelText: 'Tag',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryTag.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100009',
              labelText: 'Хэмжих нэгж',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryUnit.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100010',
              labelText: 'Барааны динамик мэдээлэл',
              onClick: () {
                Navigator.of(context).pushNamed(DynamicInformation.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100011',
              labelText: 'Сав баглаа боодол',
              onClick: () {
                Navigator.of(context).pushNamed(PackageType.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100012',
              labelText: 'Хүргэлтийн нөхцөл',
              onClick: () {
                Navigator.of(context)
                    .pushNamed(InventoryDeliveryType.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100013',
              labelText: 'Хувилбарын төрөл',
              onClick: () {
                Navigator.of(context).pushNamed(Options.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100014',
              labelText: 'Үнийн бүлэг',
              onClick: () {
                Navigator.of(context).pushNamed(InventoryPriceTiers.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100015',
              labelText: 'Идэвхгүй болгох шалтгаан',
              onClick: () {
                Navigator.of(context).pushNamed(InActiveTypes.routeName);
              },
            ),
            InventoryReferenceCard(
              refCode: 'REF-100016',
              labelText: 'Нөөцийн хөдөлгөөн тайлбар',
              onClick: () {
                Navigator.of(context).pushNamed(AdjustmentNote.routeName);
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
