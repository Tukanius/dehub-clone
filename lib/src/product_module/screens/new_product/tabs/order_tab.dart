import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/number_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/option_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/return_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_space_labels.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  InventoryGoods data = InventoryGoods();
  bool isSubmit = false;

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      await InventoryApi().goodsCreate(
        InventoryGoods(
          skuCode: data.skuCode,
          barCode: data.barCode,
          erpCode: data.erpCode,
          nameMon: data.nameMon,
          nameEng: data.nameEng,
          nameBill: data.padName,
          nameWeb: data.nameWeb,
          nameApp: data.nameApp,
          brandId: data.brandId,
          supplierId: data.supplierId,
          manufacturerId: data.manufacturerId,
          originCountry: data.manufacturerCountryId,
          importerCountry: data.importerCountry,
          distributorId: data.distributorId,
          itemTypeId: data.itemTypeId,
          classificationId: data.classificationId,
          subClassificationId: data.subClassificationId,
          categoryId: data.categoryId,
          subCategoryId: data.subCategoryId,
          tagId: data.tagId,
          description: data.description,
          coverImages: [
            InventoryGoods(
              isMain: true,
              url: data.url,
            ),
          ],
          detailImages: data.detailImages,
        ),
      );

      showCustomDialog(
        context,
        "Бараа амжилттай нэмлээ",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    data = Provider.of<InventoryProvider>(context, listen: true).product;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Бараа захиалгатай холбоотой мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 12,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Ханган нийлүүлэгч',
            secondText: 'Өөрийн бараа',
            secondTextColor: grey3,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Үндсэн нэгж',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хэмжих нэгж',
            secondText: source.product.unitName != null
                ? source.product.unitName
                : 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return UnitSheet();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Жин',
            secondText: source.product.unitWeightLabel != null
                ? source.product.unitWeightLabel
                : 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return NumberUnitSheet();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Эзэлхүүн',
            secondText: source.product.unitSpaceLabel != null
                ? source.product.unitSpaceLabel
                : 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return UnitSpaceLabelSheet();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Буцаалт',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Буцаалт зөвшөөрөх',
            secondText: 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Буцаалтын төрөл',
            secondText: source.product.returnType != null
                ? source.product.returnType
                : 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return ReturnTypeSheet();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Барааны хувилбар',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хувилбар',
            secondText: source.product.option != null
                ? source.product.option
                : 'Сонгох',
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return OptionSheet();
                },
              );
            },
            arrowColor: productColor,
            color: white,
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: CustomButton(
                  onClick: () {
                    Provider.of<IndexProvider>(context, listen: false)
                        .newProductIndexChange(1);
                  },
                  labelText: 'Өмнөх хуудас',
                  labelColor: productColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomButton(
                  onClick: () {
                    onSubmit();
                  },
                  isLoading: isSubmit,
                  labelText: 'Бүртгэсэн',
                  labelColor: productColor,
                ),
              ),
              SizedBox(
                width: 25,
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
