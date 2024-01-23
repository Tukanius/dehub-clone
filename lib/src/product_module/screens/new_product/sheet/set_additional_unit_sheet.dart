import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SetAdditionalUnitSheet extends StatefulWidget {
  final InventoryGoods data;
  final int index;
  const SetAdditionalUnitSheet({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  State<SetAdditionalUnitSheet> createState() => _SetAdditionalUnitSheetState();
}

class _SetAdditionalUnitSheetState extends State<SetAdditionalUnitSheet> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSwitched = false;
  General general = General();
  String? weightlabelCode;
  String? spaceLabelCode;
  String? convertTypeCode;
  double? convertValue;
  double? floatValue;
  double? height;
  double? width;
  double? length;
  double? weight;

  onSubmit() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods data = InventoryGoods();
      data.convertValue = convertValue;
      data.floatValue = floatValue;
      data.height = height;
      data.width = width;
      data.length = length;
      data.weight = weight;
      data.isForLoad = isSwitched;
      data.spaceLabel = spaceLabelCode;
      data.weightLabel = weightlabelCode;
      data.convertType = convertTypeCode;
      source.setAdditionalUnit(data, widget.index);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.data.convertType != null) {
      setState(() {
        convertValue = widget.data.convertValue;
        floatValue = widget.data.floatValue;
        height = widget.data.height;
        width = widget.data.width;
        length = widget.data.length;
        weight = widget.data.weight;
        isSwitched = widget.data.isForLoad as bool;
        spaceLabelCode = widget.data.spaceLabel;
        weightlabelCode = widget.data.weightLabel;
        convertTypeCode = widget.data.convertType;
      });
    }
    super.initState();
  }

  unitWeightLabel() {
    final res = general.unitWeightLabels!
        .firstWhere((element) => element.code == weightlabelCode)
        .name;
    return res;
  }

  unitSpaceLabel() {
    final res = general.unitSpaceLabels!
        .firstWhere((element) => element.code == spaceLabelCode)
        .name;
    return res;
  }

  unitConvertType() {
    final res = general.unitConvertTypes!
        .firstWhere((element) => element.code == convertTypeCode)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
          ),
          color: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
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
                        colorFilter:
                            const ColorFilter.mode(grey2, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Татан авалтын мэдээлэл',
                      style: TextStyle(
                        color: productColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onSubmit();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        color: productColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      height: 50,
                      child: const Center(
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
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          'Тохиргоо хийх',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'Нэгжийн нэр',
                        secondText: '${widget.data.name}',
                        secondTextColor: grey2,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'Хөрвөх арга',
                        secondText: convertTypeCode == null
                            ? 'Сонгох'
                            : unitConvertType(),
                        secondTextColor: productColor,
                        arrowColor: productColor,
                        onClick: () {
                          convertType();
                        },
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        readOnly: convertTypeCode == null,
                        initialValue:
                            "${convertValue != null ? convertValue?.toInt() : ''}",
                        onChanged: (value) {
                          setState(() {
                            convertValue = double.tryParse(value);
                          });
                        },
                        name: 'convertValue',
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Хөрвүүлэх тоо'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        initialValue:
                            "${floatValue != null ? floatValue?.toInt() : ''}",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        readOnly: convertTypeCode == null,
                        name: 'floatValue',
                        onChanged: (value) {
                          setState(() {
                            floatValue = double.tryParse(value);
                          });
                        },
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Бутархай орон'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, bottom: 2, top: 2),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ачилт'),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: paymentColor,
                                value: isSwitched,
                                onChanged: (bool value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'Эзэлхүүн нэгж',
                        secondText: spaceLabelCode == null
                            ? 'Сонгох'
                            : unitSpaceLabel(),
                        secondTextColor: productColor,
                        arrowColor: productColor,
                        onClick: () {
                          spaceLabel();
                        },
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        readOnly: spaceLabelCode == null,
                        name: 'length',
                        initialValue:
                            "${length != null ? length?.toInt() : ''}",
                        onChanged: (value) {
                          length = double.tryParse(value);
                        },
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Урт'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        initialValue:
                            "${height != null ? height?.toInt() : ''}",
                        readOnly: spaceLabelCode == null,
                        name: 'height',
                        onChanged: (value) {
                          height = double.tryParse(value);
                        },
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Өндөр'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        readOnly: spaceLabelCode == null,
                        initialValue: "${width != null ? width?.toInt() : ''}",
                        name: 'width',
                        onChanged: (value) {
                          width = double.tryParse(value);
                        },
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Өргөн'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'Жингийн нэгж',
                        secondText: weightlabelCode == null
                            ? 'Сонгох'
                            : unitWeightLabel(),
                        secondTextColor: productColor,
                        arrowColor: productColor,
                        onClick: () {
                          weightLabel();
                        },
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        readOnly: weightlabelCode == null,
                        name: 'weight',
                        initialValue:
                            "${weight != null ? weight?.toInt() : ''}",
                        onChanged: (value) {
                          weight = double.tryParse(value);
                        },
                        decoration: const InputDecoration(
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
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Жин'),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна уу'),
                        ]),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  spaceLabel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: general.unitSpaceLabels!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        spaceLabelCode = e.code;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: transparent,
                      child: Text(
                        '${e.name}',
                        style: const TextStyle(color: dark),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  convertType() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: general.unitConvertTypes!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        convertTypeCode = e.code;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: transparent,
                      child: Text(
                        '${e.name}',
                        style: const TextStyle(color: dark),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  weightLabel() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: general.unitWeightLabels!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        weightlabelCode = e.code;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: transparent,
                      child: Text(
                        '${e.name}',
                        style: const TextStyle(color: dark),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
