import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShipmentDistributionCard extends StatefulWidget {
  const ShipmentDistributionCard({super.key});

  @override
  State<ShipmentDistributionCard> createState() =>
      _ShipmentDistributionCardState();
}

class _ShipmentDistributionCardState extends State<ShipmentDistributionCard> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Агуулах:',
                        style: TextStyle(
                          color: grey3,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' Хөргүүртэй агуулах',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [1, 2, 3]
                      .map(
                        (e) => Column(
                          children: [
                            Divider(
                              thickness: 1,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: grey,
                                      ),
                                      height: 36,
                                      width: 36,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'CALVET VARIETALS CINSAULT ROSE VIN DE PAYS 0.75L',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'RefCode: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'GD-100033',
                                          style: TextStyle(
                                              fontSize: 12, color: orderColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Хэмжих нэгж: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'ширхэг',
                                          style: TextStyle(
                                              fontSize: 12, color: orderColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'SkuCode: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '12345678',
                                          style: TextStyle(
                                              fontSize: 12, color: orderColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Тоо ширхэг: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          ' 1 ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: orderColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                e == 3
                                    ? Divider(
                                        thickness: 1,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Нярав:',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          'Эрдэнэбаяр, Туул',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: white,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                      minimumDate: DateTime.now(),
                                      initialDateTime: DateTime.now(),
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      showDayOfWeek: true,
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() {
                                          date = newDate;
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${date != null ? DateFormat("yyyy-MM-dd").format(date!) : "Өдөр сонгох"}',
                          style: TextStyle(fontSize: 12, color: grey2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 150,
                margin: const EdgeInsets.only(right: 15, top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: orderColor),
                  color: white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: orderColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Зөвшөөрөх',
                      style: TextStyle(
                        color: orderColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
