import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/number_unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/option_sheet.dart';
// import 'package:dehub/src/product_module/screens/new_product/sheet/option_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/return_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/supplier_type_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/unit_space_labels.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class OrderSettingTab extends StatefulWidget {
  const OrderSettingTab({super.key});

  @override
  State<OrderSettingTab> createState() => _OrderSettingTabState();
}

class _OrderSettingTabState extends State<OrderSettingTab> {
  InventoryGoods data = InventoryGoods();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool hasAdditionalUnit = false;
  bool hasVariant = false;

  onSubmit(bool isCompleted) async {
    InventoryGoods data =
        Provider.of<InventoryProvider>(context, listen: false).product;
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods form = InventoryGoods.fromJson(fbKey.currentState!.value);
      form.supplierType = data.supplierType;
      form.baseUnitId = data.unitId;
      form.weightLabel = data.unitWeightLabelId;
      form.spaceLabel = data.unitSpaceLabelId;
      form.returnAllow = data.returnAllow ?? false;
      if (form.returnAllow == true) {
        form.returnType = data.returnTypeId;
      }
      form.hasVariant = hasVariant;
      form.hasAdditionalUnit = hasAdditionalUnit;
      form.isCompleted = isCompleted;
      await InventoryApi().updateVariant(form, data.id!);
      showCustomDialog(
        context,
        "Амжилттай",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    data = Provider.of<InventoryProvider>(context, listen: true).product;

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
            // Container(
            //   padding: const EdgeInsets.only(left: 15, bottom: 3, top: 3),
            //   color: white,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Хувилбартай эсэх'),
            //       Transform.scale(
            //         scale: 0.7,
            //         child: CupertinoSwitch(
            //           value: hasVariant,
            //           activeColor: productColor,
            //           onChanged: (value) {
            //             setState(() {
            //               hasVariant = value;
            //             });
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
                'Нэмэлт хэмжих нэгжтэй',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 3, top: 3),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Нэмэлт хэмжих нэгжтэй эсэх'),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: hasAdditionalUnit,
                      activeColor: productColor,
                      onChanged: (value) {
                        setState(() {
                          hasAdditionalUnit = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
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
                      onSubmit(false);
                      // Provider.of<IndexProvider>(context, listen: false)
                      //     .newProductIndexChange(1);
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
