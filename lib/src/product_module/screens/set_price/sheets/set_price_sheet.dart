import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
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

class SetPriceSheet extends StatefulWidget {
  final InventoryGoods data;
  const SetPriceSheet({
    super.key,
    required this.data,
  });

  @override
  State<SetPriceSheet> createState() => _SetPriceSheetState();
}

class _SetPriceSheetState extends State<SetPriceSheet> with AfterLayoutMixin {
  General general = General();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  double customPrice = 0;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    if (widget.data.startDate != null) {
      startDate = DateTime.parse(widget.data.startDate.toString());
      endDate = DateTime.parse(widget.data.endDate.toString());
      customPrice = widget.data.customPrice!;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
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
                    'Бүлгийн үнэ тохируулах',
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
                      setState(() {
                        widget.data.customPrice = customPrice;
                        widget.data.endDate = endDate.toString();
                        widget.data.startDate = startDate.toString();
                      });
                      Navigator.of(context).pop();
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
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "Бүлэг",
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          color: white,
                          labelText: '${widget.data.name}',
                          secondText: 'Тохируулаагүй',
                          secondTextColor: grey2,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          color: white,
                          labelText: 'Тоо ширхэг',
                          secondText: '1',
                          secondTextColor: grey2,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          color: white,
                          labelText: 'Үндсэн нэгж',
                          secondText: 'ширхэг',
                          secondTextColor: grey2,
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
                        FormBuilder(
                          key: fbKey,
                          child: FormTextField(
                            onChanged: (value) {
                              setState(() {
                                customPrice = double.tryParse(value) ?? 0;
                              });
                            },
                            inputType: TextInputType.number,
                            textColor: productColor,
                            textAlign: TextAlign.end,
                            initialValue: widget.data.customPrice != null
                                ? widget.data.customPrice.toString()
                                : null,
                            name: 'price',
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
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                          mode: CupertinoDatePickerMode.date,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                          mode: CupertinoDatePickerMode.date,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              '${Utils().formatCurrency((source.product.standardPrice! - customPrice).toString())}₮',
                          secondTextColor: grey2,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
