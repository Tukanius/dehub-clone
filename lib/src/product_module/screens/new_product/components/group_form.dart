import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/category_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/item_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/tag_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Container(
      color: white,
      child: Column(
        children: [
          FieldCard(
            validate: source.itemTypeValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Нэр төрөл",
            secondText: source.product.itemTypeName != null
                ? source.product.itemTypeName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return ItemTypeSheet();
                },
              );
            },
          ),
          Container(),
          FieldCard(
            validate: source.classificationValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Ангилал",
            secondText: source.product.classificationName != null
                ? source.product.classificationName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              source.product.itemTypeId == null
                  ? snackBar("Нэр төрөл сонгоно уу")
                  : showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return CategorySheet(
                          labelText: 'Ангилал сонгоно уу',
                          type: 'CLASSIFICATION',
                        );
                      },
                    );
            },
          ),
          FieldCard(
            validate: source.subClassificationValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Дэд ангилал",
            secondText: source.product.subClassificationName != null
                ? source.product.subClassificationName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              source.product.classificationId == null
                  ? snackBar("Ангилал сонгоно уу")
                  : showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return CategorySheet(
                          labelText: 'Дэд ангилал сонгоно уу',
                          type: 'SUB_CLASSIFICATION',
                        );
                      },
                    );
            },
          ),
          FieldCard(
            validate: source.categoryValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Категори",
            secondText: source.product.categoryName != null
                ? source.product.categoryName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              source.product.subClassificationId == null
                  ? snackBar("Дэд ангилал сонгоно уу")
                  : showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return CategorySheet(
                          labelText: 'Категори сонгоно уу',
                          type: 'CATEGORY',
                        );
                      },
                    );
            },
          ),
          FieldCard(
            validate: source.subCategoryValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Дэд категори",
            secondText: source.product.subCategoryName != null
                ? source.product.subCategoryName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              source.product.categoryId == null
                  ? snackBar("Категори сонгоно уу")
                  : showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return CategorySheet(
                          labelText: 'Дэд категори сонгоно уу',
                          type: 'SUB_CATEGORY',
                        );
                      },
                    );
            },
          ),
          FieldCard(
            validate: source.tagValidate,
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Таг",
            secondText: source.product.tagName != null
                ? source.product.tagName
                : "Сонгох",
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return TagSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String labelText) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 150),
        backgroundColor: productColor,
        shape: StadiumBorder(),
        content: Center(
          child: Text('${labelText}'),
        ),
      ),
    );
  }
}
