import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/sheets/select_type_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FieldSettingSheet extends StatefulWidget {
  final InventoryGoods data;
  const FieldSettingSheet({
    super.key,
    required this.data,
  });

  @override
  State<FieldSettingSheet> createState() => _FieldSettingSheetState();
}

class _FieldSettingSheetState extends State<FieldSettingSheet> {
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Талбараас хасах бол энд дарна уу.   ',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                        SvgPicture.asset('assets/svg/trash_can.svg'),
                      ],
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Талбарын нэр',
                    secondText: widget.data.name,
                    secondTextColor: productColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Эрэмбэ',
                    secondText: '3',
                    secondTextColor: productColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Өгөгдлийн төрөл',
                    secondText: 'Сонголтот утга',
                    secondTextColor: productColor,
                    arrowColor: productColor,
                    onClick: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        builder: (context) => SelectTypeSheet(),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Сонголтот утга'),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: productColor.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                '25 хэм',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: productColor.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                '10 хэм',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Default утга'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: productColor.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Text(
                            '10 хэм',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Нэгж'),
                      ],
                    ),
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
