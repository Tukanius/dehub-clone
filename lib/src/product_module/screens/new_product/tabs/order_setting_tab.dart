import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/components/additional_unit_card.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/additional_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/number_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/option_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/return_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/set_additional_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/supplier_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_space_labels.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class OrderSettingTab extends StatefulWidget {
  final String? id;
  const OrderSettingTab({
    super.key,
    this.id,
  });

  @override
  State<OrderSettingTab> createState() => _OrderSettingTabState();
}

class _OrderSettingTabState extends State<OrderSettingTab> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  onSubmit(bool isCompleted) async {
    InventoryGoods data =
        Provider.of<InventoryProvider>(context, listen: false).product;
    List<InventoryGoods> additionalUnits = [];
    if (data.supplierTypeName != null) {
      if (fbKey.currentState!.saveAndValidate()) {
        InventoryGoods form =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        form.supplierType = data.supplierType;
        form.baseUnitId = data.unitId;
        form.weightLabel = data.unitWeightLabelId;
        form.spaceLabel = data.unitSpaceLabelId;
        form.returnAllow = data.returnAllow ?? false;
        if (form.returnAllow == true) {
          form.returnType = data.returnTypeId;
        }
        form.isCompleted = isCompleted;
        if (data.additionalUnits != null && data.additionalUnits?.length != 0) {
          for (var i = 0; i < data.additionalUnits!.length; i++) {
            additionalUnits.add(
              InventoryGoods(
                unitId: data.additionalUnits?[i].id,
                convertType: data.additionalUnits?[i].convertType,
                convertValue: data.additionalUnits?[i].convertValue,
                floatValue: data.additionalUnits?[i].floatValue,
                isForLoad: data.additionalUnits?[i].isForLoad,
                spaceLabel: data.additionalUnits?[i].spaceLabel,
                height: data.additionalUnits?[i].height,
                width: data.additionalUnits?[i].width,
                length: data.additionalUnits?[i].length,
                weightLabel: data.additionalUnits?[i].weightLabel,
                weight: data.additionalUnits?[i].weight,
              ),
            );
          }
        }
        form.additionalUnits = additionalUnits;
        form.hasAdditionalUnit = additionalUnits.length != 0 ? true : false;
        int index = additionalUnits
            .indexWhere((element) => element.convertType == null);
        if (index < 0) {
          await InventoryApi()
              .updateVariant(form, widget.id != null ? widget.id! : data.id!);
          showCustomDialog(
            context,
            "Амжилттай",
            true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } else {
          CustomScaffoldMessenger(
            context,
            color: productColor,
            labelText: 'Нэмэлт хэмжих нэгжүүд тохируулна уу!',
          );
        }
      }
    } else {
      CustomScaffoldMessenger(
        context,
        color: productColor,
        labelText: 'Ханган нийлүүлэгч сонгоно уу!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return SingleChildScrollView(
      child: FormBuilder(
        key: fbKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Ханган нийлүүлэгч',
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
                'Захиалгын хэмжих нэгж',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: 'Үндсэн нэгж',
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
            source.product.unitWeightLabel != null
                ? FormTextField(
                    initialValue: source.product.skuCode,
                    textColor: productColor,
                    textAlign: TextAlign.end,
                    name: 'weight',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: white,
                      filled: true,
                      hintText: 'Энд оруулна уу',
                      hintStyle: TextStyle(
                        color: productColor,
                      ),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Жин',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Заавал оруулна',
                      ),
                    ]),
                  )
                : SizedBox(),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: 'Эзэлхүүн нэгж',
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
            source.product.unitSpaceLabel != null
                ? Column(
                    children: [
                      FormTextField(
                        initialValue: source.product.skuCode,
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'length',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Урт',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      FormTextField(
                        initialValue: source.product.skuCode,
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'height',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Өндөн',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      FormTextField(
                        initialValue: source.product.skuCode,
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'width',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Өргөн',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                    ],
                  )
                : SizedBox(),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: 'Хувилбар нэмэх',
              secondText: '',
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Нэмэлт хэмжих нэгж',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  builder: (context) => AdditionalUnitSheet(),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Нэмэлт хэмжих нэгж нэмэх'),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: productColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
            source.product.additionalUnits != null &&
                    source.product.additionalUnits?.length != 0
                ? Column(
                    children: source.product.additionalUnits!
                        .map(
                          (item) => AdditionalUnitCard(
                            onClick: () {
                              showModalBottomSheet(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => SetAdditionalUnitSheet(
                                  data: item,
                                ),
                              );
                            },
                            closeClick: () {
                              source.removeAdditinoalUnit(source
                                  .product.additionalUnits!
                                  .indexOf(item));
                            },
                            data: item,
                          ),
                        )
                        .toList(),
                  )
                : SizedBox(),
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
                      onSubmit(false);
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
                      onSubmit(true);
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
      ),
    );
  }
}
