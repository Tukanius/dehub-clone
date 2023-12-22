import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/number_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/option_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/return_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/supplier_type_sheet.dart';
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

  onSubmit() async {
    await InventoryApi().updateVariant(
      InventoryGoods(),
      '8a0c39a9-49f7-44d3-97e5-68139cd45938',
    );
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
              'Ханган нийлүүлэгч',
              style: TextStyle(
                color: grey3,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Ханган нийлүүлэгч',
            secondText: source.product.supplierTypeName != null
                ? source.product.supplierTypeName
                : 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) => SupplierTypeSheet(),
              );
            },
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Үндсэн нэгж',
              style: TextStyle(
                color: grey3,
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
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Буцаалт зөвшөөрөх',
            secondText: source.product.returnAllow == true ? "Тийм" : "Үгүй",
            secondTextColor: productColor,
            onClick: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                backgroundColor: backgroundColor,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 30, top: 15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              source.returnAllow(true);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: transparent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text('Тийм'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              source.returnAllow(false);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Text('Үгүй'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
                  borderColor: productColor,
                  onClick: () {
                    Provider.of<IndexProvider>(context, listen: false)
                        .newProductIndexChange(1);
                  },
                  labelText: 'Хадгалах',
                  textColor: productColor,
                  labelColor: white,
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
                  isLoading: false,
                  labelText: 'Бүртгэл дуусгах',
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
