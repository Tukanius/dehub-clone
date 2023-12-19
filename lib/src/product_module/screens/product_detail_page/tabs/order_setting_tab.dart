import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

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
  bool value = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool isVisible = false;
  bool? visibleValue = false;
  bool isLoading = false;
  InventoryGoods itemUnits = InventoryGoods();
  InventoryGoods inventory = InventoryGoods();

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
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
                        '${itemUnits.name}',
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
                      itemUnits.weightLabel == "GRAM"
                          ? Text(
                              '${itemUnits.weight?.toInt()} ГР',
                              style: TextStyle(color: productColor),
                            )
                          : Text(
                              '${itemUnits.weight?.toInt()} КГ',
                              style: TextStyle(color: productColor),
                            )
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
                        '${itemUnits.height?.toInt()} ${itemUnits.spaceLabel}',
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
                        '${itemUnits.width?.toInt()} ${itemUnits.spaceLabel}',
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
                        '${itemUnits.length?.toInt()} ${itemUnits.spaceLabel}',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
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
                // Container(
                //   color: white,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Хүргэлтийн нөхцөл',
                //         style: TextStyle(color: grey2),
                //       ),
                //       Text(
                //         '${inventory.deliveryType?.name}',
                //         style: TextStyle(color: productColor),
                //       ),
                //     ],
                //   ),
                // ),
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
                          onChanged: (value) {
                            setState(() {
                              value = value;
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
                        'Буцаалтын төрөл',
                        style: TextStyle(color: grey2),
                      ),
                      inventory.returnType != null
                          ? Text(
                              returnType().toString(),
                              style: TextStyle(color: productColor),
                            )
                          : Text(
                              'Байхгүй',
                              style: TextStyle(color: productColor),
                            )
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
                        'Хайрцаг',
                        style: TextStyle(color: productColor),
                      )
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
                      //       Text(
                      //         '${Utils().formatCurrency(inventory.minBalance.toString())}',
                      //         style: TextStyle(color: productColor),
                      //       ),
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
                      // Text(
                      //   '${Utils().formatCurrency(inventory.maxBalance.toString())}',
                      //   style: TextStyle(color: productColor),
                      // ),
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
                        '${inventory.minOrderNum?.toInt()}',
                        style: TextStyle(color: productColor),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   color: white,
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Дахин захиалах эсэх',
                //         style: TextStyle(color: grey2),
                //       ),
                //       Transform.scale(
                //         scale: 0.7,
                //         child: CupertinoSwitch(
                //           activeColor: productColor,
                //           value: inventory.reOrder as bool,
                //           onChanged: (value) {
                //             setState(() {
                //               value = value;
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   color: white,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Дахин захиалах тоо',
                //         style: TextStyle(color: grey2),
                //       ),
                //       Text(
                //         '${inventory.reOrderNum}',
                //         style: TextStyle(color: productColor),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   color: white,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Татан авах мин тоо',
                //         style: TextStyle(color: grey2),
                //       ),
                //       Text(
                //         '${inventory.reOrderMinNum}',
                //         style: TextStyle(color: productColor),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
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
}
