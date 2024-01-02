import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';

class QuantitySheet extends StatefulWidget {
  final InventoryGoods? data;
  const QuantitySheet({
    super.key,
    this.data,
  });

  @override
  State<QuantitySheet> createState() => _QuantitySheetState();
}

class _QuantitySheetState extends State<QuantitySheet> with AfterLayoutMixin {
  double? salesPrice;
  bool isSwitched = false;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isLoading = true;
  int? minQuantity;
  int? maxQuantity;

  @override
  afterFirstLayout(BuildContext context) {
    if (widget.data != null) {
      startDate = DateTime.parse(widget.data!.startDate.toString());
      endDate = DateTime.parse(widget.data!.endDate.toString());
      salesPrice = widget.data!.salesPrice!;
      maxQuantity = widget.data?.maxQuantity;
      minQuantity = widget.data!.minQuantity;
      isSwitched = widget.data!.hasMaxLimit!;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: productColor),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(3),
                    color: transparent,
                    child: SvgPicture.asset(
                      'assets/svg/square-x.svg',
                      colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Тоо ширхэг нэмэх',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (fbKey.currentState!.saveAndValidate()) {
                      InventoryGoods data =
                          InventoryGoods.fromJson(fbKey.currentState!.value);
                      if (widget.data == null) {
                        data.hasMaxLimit = isSwitched;
                        data.startDate = startDate.toString();
                        data.endDate = endDate.toString();
                        data.salesPrice = double.parse(
                            fbKey.currentState?.fields['salesPrice']?.value);
                        if (widget.data == null) {
                          source.setQuantityPrice(data);
                        }
                        Navigator.of(context).pop();
                      } else {
                        widget.data?.hasMaxLimit = isSwitched;
                        widget.data?.startDate = startDate.toString();
                        widget.data?.endDate = endDate.toString();
                        widget.data?.salesPrice = double.parse(
                            fbKey.currentState?.fields['salesPrice']?.value);
                        widget.data?.minQuantity = int.parse(
                            fbKey.currentState?.fields['minQuantity']?.value);
                        widget.data?.maxQuantity = int.parse(
                            fbKey.currentState?.fields['maxQuantity']?.value);
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: productColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    child: Center(
                      child: Text(
                        'Болсон',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading == true
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: fbKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                "Мэдээлэл оруулна уу",
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Үндсэн нэгж',
                              secondText: 'ширхэг',
                              secondTextColor: grey2,
                              color: white,
                            ),
                            FormTextField(
                              textColor: productColor,
                              textAlign: TextAlign.end,
                              initialValue: minQuantity != null
                                  ? minQuantity.toString()
                                  : null,
                              inputType: TextInputType.number,
                              name: 'minQuantity',
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: white,
                                filled: true,
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(
                                  color: productColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Минимум тоо',
                                    ),
                                  ],
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Тоо оруулна уу',
                                ),
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 3, bottom: 3),
                              color: white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Мах лимиттэй эсэх'),
                                  Transform.scale(
                                    scale: 0.7,
                                    child: CupertinoSwitch(
                                      value: isSwitched,
                                      activeColor: productColor,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            FormTextField(
                              onChanged: (value) {},
                              textColor: productColor,
                              textAlign: TextAlign.end,
                              readOnly: !isSwitched,
                              initialValue: maxQuantity != null
                                  ? maxQuantity.toString()
                                  : null,
                              inputType: TextInputType.number,
                              name: 'maxQuantity',
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: white,
                                filled: true,
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(
                                  color: productColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Максимум тоо',
                                    ),
                                  ],
                                ),
                              ),
                              validator: isSwitched == true
                                  ? FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Тоо оруулна уу',
                                      )
                                    ])
                                  : null,
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Валют',
                              secondText: 'Төгрөг',
                              secondTextColor: grey2,
                              color: white,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                "Борлуулах үнийн мэдээлэл",
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ),
                            FormTextField(
                              onChanged: (value) {
                                setState(() {
                                  salesPrice = double.tryParse(value) ?? 0;
                                });
                              },
                              inputType: TextInputType.number,
                              textColor: productColor,
                              textAlign: TextAlign.end,
                              initialValue: widget.data?.salesPrice != null
                                  ? widget.data!.salesPrice!.toInt().toString()
                                  : null,
                              name: 'salesPrice',
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: white,
                                filled: true,
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(
                                  color: productColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Үнэ (НӨАТ-гүй)',
                                    ),
                                  ],
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Үнэ оруулна уу',
                                ),
                              ]),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      color: white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              if (startDate
                                                      .difference(endDate)
                                                      .inHours >
                                                  12) {
                                                setState(() {
                                                  endDate = startDate;
                                                });
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Болсон',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: black,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CupertinoDatePicker(
                                              minimumDate: DateTime.now(),
                                              initialDateTime: DateTime.now(),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              use24hFormat: true,
                                              showDayOfWeek: true,
                                              onDateTimeChanged:
                                                  (DateTime newDate) {
                                                setState(() {
                                                  startDate = newDate;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Эхлэх огноо'),
                                    Row(
                                      children: [
                                        Text(
                                          '${DateFormat('yyyy-MM-dd').format(startDate)}',
                                          style: TextStyle(color: productColor),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/dot-calendar.svg',
                                          colorFilter: ColorFilter.mode(
                                            productColor,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      color: white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Болсон',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: black,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CupertinoDatePicker(
                                              minimumDate: startDate,
                                              initialDateTime: startDate,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              use24hFormat: true,
                                              showDayOfWeek: true,
                                              onDateTimeChanged:
                                                  (DateTime newDate) {
                                                setState(() {
                                                  endDate = newDate;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Дуусах огноо'),
                                    Row(
                                      children: [
                                        Text(
                                          '${DateFormat('yyyy-MM-dd').format(endDate)}',
                                          style: TextStyle(color: productColor),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/dot-calendar.svg',
                                          colorFilter: ColorFilter.mode(
                                              productColor, BlendMode.srcIn),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              color: white,
                              labelText: 'Стандарт үнэ',
                              secondText:
                                  '${Utils().formatCurrency(source.product.standardPrice.toString())}₮',
                              secondTextColor: grey2,
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              color: white,
                              labelText: 'Өөрчлөлт',
                              secondText:
                                  '${Utils().formatCurrency((source.product.standardPrice! - (double.tryParse(salesPrice.toString()) ?? 0)).toString())}₮',
                              secondTextColor: grey2,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
