import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/brand_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/supplier_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  onSubmit() {
    if (fbKey.currentState!.saveAndValidate()) {}
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Барааны үндсэн мэдээллийг оруулна уу',
              style: TextStyle(
                color: grey3,
                fontSize: 12,
              ),
            ),
          ),
          ExpansionTile(
            shape: BeveledRectangleBorder(side: BorderSide.none),
            collapsedShape: BeveledRectangleBorder(side: BorderSide.none),
            backgroundColor: white,
            tilePadding:
                const EdgeInsets.symmetric(vertical: -5, horizontal: 15),
            collapsedBackgroundColor: white,
            iconColor: productColor,
            collapsedIconColor: productColor,
            title: Text(
              'Бүртгэлийн мэдээлэл',
              style: TextStyle(
                color: productColor,
                fontSize: 14,
              ),
            ),
            children: [
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "DeHUB код",
                color: white,
                labelTextColor: dark,
                secondTextColor: grey3,
                secondText: 'Авто гарна',
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Бүртгэлийн статус',
                      style: TextStyle(
                        color: dark,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: grey3.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        'Түр төлөв',
                        style: TextStyle(fontSize: 12, color: grey3),
                      ),
                    ),
                  ],
                ),
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Бүртгэсэн ажилтан",
                color: white,
                labelTextColor: dark,
                secondTextColor: grey3,
                secondText: 'Авто гарна',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            shape: BeveledRectangleBorder(side: BorderSide.none),
            collapsedShape: BeveledRectangleBorder(side: BorderSide.none),
            backgroundColor: white,
            tilePadding:
                const EdgeInsets.symmetric(vertical: -5, horizontal: 15),
            collapsedBackgroundColor: white,
            iconColor: productColor,
            collapsedIconColor: productColor,
            title: Text(
              'Барааны нэр, код',
              style: TextStyle(
                color: productColor,
                fontSize: 14,
              ),
            ),
            children: [
              FormBuilder(
                key: fbKey,
                child: Column(
                  children: [
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.skuCode = value;
                        });
                      },
                      initialValue: source.skuCode,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'skuCode',
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
                              'SKU код',
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
                          errorText: 'SKU код оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.barCode = value;
                        });
                      },
                      initialValue: source.barCode,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'barCode',
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
                              'Бар код',
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
                          errorText: 'Бар код оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.erpCode = value;
                        });
                      },
                      initialValue: source.erpCode,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'erpCode',
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
                              'ERP код',
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
                          errorText: 'ERP код оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.nameMon = value;
                        });
                      },
                      initialValue: source.nameMon,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'nameMon',
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
                              'Барааны нэр (Монгол)',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        (value) {
                          return validateCryllic(value.toString(), context);
                        }
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.name = value;
                        });
                      },
                      initialValue: source.name,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'name',
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
                              'Англи/Латин нэр',
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
                          errorText: 'Нэр оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.padName = value;
                        });
                      },
                      initialValue: source.padName,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'asdf',
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
                              'Падааны нэр',
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
                          errorText: 'Падааны нэр оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.appName = value;
                        });
                      },
                      initialValue: source.appName,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'nameApp',
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
                              'Апп-д гарах нэр',
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
                          errorText: 'Нэр оруулна уу',
                        ),
                      ]),
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          source.webName = value;
                        });
                      },
                      initialValue: source.webName,
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'nameWeb',
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
                              'Веб-д гарах нэр',
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
                          errorText: 'Нэр оруулна уу',
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            shape: BeveledRectangleBorder(side: BorderSide.none),
            collapsedShape: BeveledRectangleBorder(side: BorderSide.none),
            backgroundColor: white,
            tilePadding:
                const EdgeInsets.symmetric(vertical: -5, horizontal: 15),
            collapsedBackgroundColor: white,
            iconColor: productColor,
            collapsedIconColor: productColor,
            title: Text(
              'Брэнд, нийлүүлэгч',
              style: TextStyle(
                color: productColor,
                fontSize: 14,
              ),
            ),
            children: [
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Брэндийн нэр",
                secondText: source.brandName,
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return brandSheet();
                    },
                  );
                },
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Нийлүүлэгч",
                secondText: source.supplierName,
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return supplierSheet();
                    },
                  );
                },
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Үйлдвэрлэгч",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Үйлдвэрлэгч улс",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Импортлогч улс",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Дистрибютер",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            shape: BeveledRectangleBorder(side: BorderSide.none),
            collapsedShape: BeveledRectangleBorder(side: BorderSide.none),
            backgroundColor: white,
            tilePadding:
                const EdgeInsets.symmetric(vertical: -5, horizontal: 15),
            collapsedBackgroundColor: white,
            iconColor: productColor,
            collapsedIconColor: productColor,
            title: Text(
              'Бараа хамаарах бүлэг',
              style: TextStyle(
                color: productColor,
                fontSize: 14,
              ),
            ),
            children: [
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Нэр төрөл",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Ангилал",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Дэд ангилал",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Категори",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Дэд категори",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Таг",
                secondText: "Сонгох",
                secondTextColor: productColor,
                arrowColor: productColor,
                onClick: () {},
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          CustomButton(
            onClick: () {
              onSubmit();
            },
            labelColor: productColor,
            labelText: "Үргэлжлүүлэх",
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget brandSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, scrollController) => BrandSheet(),
    );
  }

  Widget supplierSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, scrollController) => SupplierSheet(),
    );
  }
}

String? validateCryllic(String value, context) {
  String pattern = r'(^[а-яА-ЯӨөҮүЁёӨө -]+$)';
  RegExp isValidName = RegExp(pattern);
  if (value.isEmpty) {
    return "Заавал оруулна";
  } else {
    if (!isValidName.hasMatch(value)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}
