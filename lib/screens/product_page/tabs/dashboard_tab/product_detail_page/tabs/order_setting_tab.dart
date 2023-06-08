import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class OrderSettingTab extends StatefulWidget {
  final String id;
  const OrderSettingTab({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<OrderSettingTab> createState() => _OrderSettingTabState();
}

class _OrderSettingTabState extends State<OrderSettingTab>
    with AfterLayoutMixin {
  bool value = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool isVisible = false;
  bool? visibleValue = false;
  bool isLoading = false;

  InventoryGoods inventory = InventoryGoods();

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    inventory = await InventoryApi().goodsGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  Widget visiblityWidget = Column(
    children: [
      Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Дугаар',
              style: TextStyle(
                color: grey2,
              ),
            ),
            Text(
              '1',
              style: TextStyle(color: productColor),
            )
          ],
        ),
      ),
      Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Хэмжих нэгжийн нэр',
              style: TextStyle(
                color: grey2,
              ),
            ),
            Text(
              'хайрцаг',
              style: TextStyle(color: productColor),
            )
          ],
        ),
      ),
      Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Хөрвөх арга',
              style: TextStyle(
                color: grey2,
              ),
            ),
            Text(
              'Арга',
              style: TextStyle(color: productColor),
            )
          ],
        ),
      ),
      Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Хөрвүүлэх тоо',
              style: TextStyle(
                color: grey2,
              ),
            ),
            Text(
              'Тоо',
              style: TextStyle(color: productColor),
            )
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
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
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Үндсэн хэмжих нэгж',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Ширхэг',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Жин',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.weight!.toInt()} ${inventory.weightLabel}',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Өндөр',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '30 см',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Өргөн',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '30 см',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Урт',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '30 см',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    InkWell(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Харъяалах нэгж',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Нэгжийн нэр',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дэд нэгж',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Дэд нэгж',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Хүргэлтийн нөхцөл',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Хүргэлт нөхцөл',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
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
                          value: value,
                          onChanged: (value) {
                            setState(() {
                              this.value = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Буцаалтийн төрөл',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Буцаалт төрөл',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Сав баглаа боодол',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Савалгаатай',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
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
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Минимум үлдэгдэл',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Min_Uldegdel',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Максимум үлдэгдэл',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Max_Uldegdel',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Минимум захиалга',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Min_Order',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дахин захиалах эсэх',
                        style: TextStyle(color: grey2),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: productColor,
                          value: value1,
                          onChanged: (value) {
                            setState(() {
                              this.value1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дахин захиалах тоо',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'ReOrder_Too',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Татан авах мин тоо',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Min_Order',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
  }
}
