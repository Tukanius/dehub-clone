import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class OrderSettingTab extends StatefulWidget {
  final InventoryGoods data;
  const OrderSettingTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderSettingTab> createState() => _OrderSettingTabState();
}

class _OrderSettingTabState extends State<OrderSettingTab>
    with AfterLayoutMixin {
  bool isVisible = false;
  bool isLoading = true;
  General general = General();
  InventoryGoods itemUnits = InventoryGoods();
  InventoryGoods inventory = InventoryGoods();

  @override
  afterFirstLayout(BuildContext context) async {
    if (widget.data.itemUnits?.length != 0) {
      itemUnits = widget.data.itemUnits!.firstWhere(
        (element) => element.isBase == true,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  returnType() {
    switch (inventory.returnType) {
      case 'BY_INVOICE':
        return 'Нэхэмжлэлээр';
      case 'BY_ITEM':
        return 'Бараагаар';
      case 'BY_RECEIVABLES':
        return 'Авлагаас';
      default:
    }
  }

  weightLabel() {
    String? res = '';
    if (itemUnits.weightLabel != null) {
      res = general.unitWeightLabels!
          .firstWhere((element) => element.code == itemUnits.weightLabel)
          .name;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return SingleChildScrollView(
      child: isLoading == true
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Хэмжих нэгж',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Үндсэн хэмжих нэгж',
                  labelTextColor: grey2,
                  secondText: itemUnits.name,
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Жин',
                  labelTextColor: grey2,
                  secondText: itemUnits.weight != null
                      ? '${itemUnits.weight.toString() + weightLabel()}'
                      : '-',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Өндөр',
                  labelTextColor: grey2,
                  secondText: itemUnits.height != null
                      ? '${itemUnits.height?.toInt()} ${itemUnits.spaceLabel != null ? itemUnits.spaceLabel : ""}'
                      : '-',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Өргөн',
                  labelTextColor: grey2,
                  secondText: itemUnits.width != null
                      ? '${itemUnits.width?.toInt()} ${itemUnits.spaceLabel != null ? itemUnits.spaceLabel : ""}'
                      : '-',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Урт',
                  labelTextColor: grey2,
                  secondText: itemUnits.length != null
                      ? '${itemUnits.length?.toInt()} ${itemUnits.spaceLabel != null ? itemUnits.spaceLabel : ""}'
                      : '-',
                  secondTextColor: productColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'Нэмэлт хэмжих нэгж',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '1. Хэмжих нэгж нэр',
                                  style: TextStyle(color: grey2),
                                ),
                                isVisible == false
                                    ? Icon(
                                        Icons.arrow_forward_ios,
                                        color: grey2,
                                        size: 14,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: grey2,
                                        size: 22,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isVisible,
                          child: visiblityWidget,
                        ),
                      ],
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2. Хэмжих нэгж нэр',
                            style: TextStyle(color: grey2),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: grey2,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Түгээлт, хүргэлт',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Харъяалах нэгж',
                  labelTextColor: grey2,
                  secondText: 'Нэгжийн нэр',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Дэд нэгж',
                  labelTextColor: grey2,
                  secondText: 'Дэд нэгж',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Хүргэлтийн нөхцөл',
                  labelTextColor: grey2,
                  secondText: inventory.deliveryType?.name,
                  secondTextColor: productColor,
                ),
                Container(
                  color: white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Буцаалт зөвшөөрөх эсэх',
                        style: TextStyle(color: grey2),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: productColor,
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Буцаалтын төрөл',
                  labelTextColor: grey2,
                  secondText: returnType().toString(),
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Сав баглаа боодол',
                  labelTextColor: grey2,
                  secondText: 'Хайрцаг',
                  secondTextColor: productColor,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Түгээлт, хүргэлт',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Минимум үлдэгдэл',
                  labelTextColor: grey2,
                  secondText: inventory.minBalance != null
                      ? '${Utils().formatCurrency(inventory.minBalance.toString())}'
                      : '-',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Максимум үлдэгдэл',
                  labelTextColor: grey2,
                  secondText: inventory.maxBalance != null
                      ? '${Utils().formatCurrency(inventory.maxBalance.toString())}'
                      : '-',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Минимум захиалга',
                  labelTextColor: grey2,
                  secondText: '${inventory.minOrderNum?.toInt()}',
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Дахин захиалах эсэх',
                  labelTextColor: grey2,
                  secondText: inventory.reOrder.toString(),
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Дахин захиалах тоо',
                  labelTextColor: grey2,
                  secondText: "${inventory.reOrderNum}",
                  secondTextColor: productColor,
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: 'Татан авах мин тоо',
                  labelTextColor: grey2,
                  secondText: '${inventory.reOrderMinNum}',
                  secondTextColor: productColor,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
  }

  Widget visiblityWidget = Column(
    children: [
      FieldCard(
        paddingHorizontal: 15,
        paddingVertical: 10,
        color: white,
        labelText: 'Дугаар',
        labelTextColor: grey2,
        secondText: '1',
        secondTextColor: productColor,
      ),
      FieldCard(
        paddingHorizontal: 15,
        paddingVertical: 10,
        color: white,
        labelText: 'Хэмжих нэгжийн нэр',
        labelTextColor: grey2,
        secondText: 'хайрцаг',
        secondTextColor: productColor,
      ),
      FieldCard(
        paddingHorizontal: 15,
        paddingVertical: 10,
        color: white,
        labelText: 'Хөрвөх арга',
        labelTextColor: grey2,
        secondText: 'Арга',
        secondTextColor: productColor,
      ),
      FieldCard(
        paddingHorizontal: 15,
        paddingVertical: 10,
        color: white,
        labelText: 'Хөрвүүлэх тоо',
        labelTextColor: grey2,
        secondText: 'Тоо',
        secondTextColor: productColor,
      ),
      Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Худалдан авалт',
              style: TextStyle(
                color: grey2,
              ),
            ),
            CustomSwitch(),
          ],
        ),
      ),
    ],
  );
}
