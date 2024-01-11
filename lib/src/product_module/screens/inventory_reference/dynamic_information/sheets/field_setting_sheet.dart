import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/sheets/select_type_sheet.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/sheets/select_values_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FieldSettingSheet extends StatefulWidget {
  final InventoryGoods data;
  final int index;
  const FieldSettingSheet({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  State<FieldSettingSheet> createState() => _FieldSettingSheetState();
}

class _FieldSettingSheetState extends State<FieldSettingSheet> {
  bool isSubmit = false;
  InventoryGoods defaultValue = InventoryGoods();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  color: transparent,
                  child: SvgPicture.asset('assets/svg/square-x.svg'),
                ),
              ),
              Expanded(
                child: Text(
                  'Талбарын тохиргоо',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                  ),
                  child: Text(
                    'Хадгалах',
                    style: TextStyle(
                      color: productColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSubmit = true;
                      });
                      source.removeSection(widget.index);
                      Navigator.of(context).pop();
                      setState(() {
                        isSubmit = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: transparent,
                      child: Row(
                        children: [
                          Text(
                            'Талбараас хасах бол энд дарна уу.    ',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                          SvgPicture.asset('assets/svg/trash_can.svg'),
                        ],
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Талбарын нэр',
                    secondText: widget.data.name,
                    secondTextColor: productColor,
                  ),
                  FormTextField(
                    textColor: productColor,
                    textAlign: TextAlign.end,
                    name: 'name',
                    inputType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: white,
                      filled: true,
                      isDense: true,
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
                          Text('Эрэмбэ'),
                        ],
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Өгөгдлийн төрөл',
                    secondText: source.product.sections?[widget.index].type ==
                            null
                        ? "Сонгох"
                        : source.product.sections?[widget.index].type ==
                                "CHECKBOX"
                            ? 'Checkbox'
                            : source.product.sections?[widget.index].type ==
                                    "SELECT"
                                ? "Сонголтот утга"
                                : source.product.sections?[widget.index].type ==
                                        "NUMBER"
                                    ? 'Тоон утга'
                                    : 'Текст утга',
                    secondTextColor: productColor,
                    arrowColor: productColor,
                    onClick: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        builder: (context) => SelectTypeSheet(
                          index: widget.index,
                        ),
                      );
                    },
                  ),
                  source.product.sections?[widget.index].type == "SELECT"
                      ? Column(
                          children: [
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              color: white,
                              labelText: "Сонголтот утгууд",
                              secondText: 'Нэмэх',
                              secondTextColor: productColor,
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) => SelectValuesSheet(
                                    index: widget.index,
                                  ),
                                );
                              },
                              arrowColor: productColor,
                            ),
                            source.product.sections?[widget.index].values !=
                                    null
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 50,
                                    child: ListView(
                                      shrinkWrap: false,
                                      padding: const EdgeInsets.only(left: 15),
                                      scrollDirection: Axis.horizontal,
                                      children: source.product
                                          .sections![widget.index].values!
                                          .map(
                                            (data) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  defaultValue = data;
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 15),
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: data.name ==
                                                            defaultValue.name
                                                        ? grey2
                                                        : transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: productColor
                                                      .withOpacity(.05),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 3),
                                                child: Text(
                                                  '${data.name}',
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                : SizedBox(),
                            defaultValue.name != null
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Default утга'),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color:
                                                productColor.withOpacity(0.1),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 3),
                                          child: Text(
                                            '${defaultValue.name}',
                                            style: TextStyle(
                                              color: grey2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        )
                      : SizedBox(),
                  FormTextField(
                    textColor: productColor,
                    textAlign: TextAlign.end,
                    name: 'numberUnit',
                    inputType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: white,
                      filled: true,
                      isDense: true,
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
                          Text('Нэгж'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
