import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShipmentDistributionCard extends StatefulWidget {
  final List<Order> lines;
  final Order data;
  final String deliveryNoteId;
  const ShipmentDistributionCard({
    super.key,
    required this.deliveryNoteId,
    required this.data,
    required this.lines,
  });

  @override
  State<ShipmentDistributionCard> createState() =>
      _ShipmentDistributionCardState();
}

class _ShipmentDistributionCardState extends State<ShipmentDistributionCard> {
  DateTime? date;
  bool dateValidate = false;

  onSubmit() async {
    Order data = Order();
    data.warehouseId = widget.data.id;
    data.loadingDate = date.toString();
    data.deliveryNoteId = widget.deliveryNoteId;
    await OrderApi().pullSheetCreate(data);
    showCustomDialog(
      context,
      "Амжилттай хүргэлт хуваариллаа",
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    const Text(
                      'Агуулах:',
                      style: TextStyle(
                        color: grey3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' ${widget.data.name}',
                        style: const TextStyle(
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
                children: widget.lines
                    .map(
                      (item) => Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${widget.lines.indexOf(item) + 1}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: grey,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${item.image}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 36,
                                    width: 36,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${item.name}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'RefCode: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.refCode}',
                                        style: const TextStyle(
                                            fontSize: 12, color: orderColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Хэмжих нэгж: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.unit?.toLowerCase()}',
                                        style: const TextStyle(
                                            fontSize: 12, color: orderColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'SkuCode: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${item.skuCode}',
                                        style: const TextStyle(
                                            fontSize: 12, color: orderColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Тоо ширхэг: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        ' ${item.quantity} ',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: orderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              if (widget.lines.last.id == item.id)
                                const Divider(
                                  thickness: 1,
                                ),
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
                      const Text(
                        'Нярав:',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        ' ${widget.data.warehouseUser?.firstName}',
                        style: const TextStyle(
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
                      setState(() {
                        if (date == null) {
                          date = DateTime.now();
                          setState(() {
                            dateValidate = false;
                          });
                        }
                      });
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
                                  child: const Text(
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
                        border: Border.all(color: dateValidate ? red : grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        date != null
                            ? DateFormat("yyyy-MM-dd").format(date!)
                            : "Өдөр сонгох",
                        style: TextStyle(
                            fontSize: 12, color: dateValidate ? red : grey2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (date == null) {
                setState(() {
                  dateValidate = true;
                  showCustomDialog(context, 'Өдөр сонгоно уу', false);
                });
              } else {
                onSubmit();
              }
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 15, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: orderColor),
                color: white,
              ),
              child: const Row(
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
    );
  }
}
