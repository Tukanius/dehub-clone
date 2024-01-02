import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OptionSelectSheet extends StatefulWidget {
  final InventoryGoods data;
  const OptionSelectSheet({
    super.key,
    required this.data,
  });

  @override
  State<OptionSelectSheet> createState() => _OptionSelectSheetState();
}

class _OptionSelectSheetState extends State<OptionSelectSheet> {
  List<InventoryGoods> values = [];

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
                    '${widget.data.name} сонголт',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    source.select(
                      InventoryGoods(
                        name: widget.data.name,
                        values: values,
                      ),
                    );
                    Navigator.of(context).pop();
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Сонголт хийнэ үү',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      for (var i = 0; i < widget.data.values!.length; i++) {
                        int index = values.indexWhere((element) =>
                            element.id == widget.data.values![i].id);
                        if (index < 0) {
                          setState(() {
                            values.add(widget.data.values![i]);
                          });
                        }
                      }
                    },
                    child: Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Бүх хувилбарыг сонгох'),
                          widget.data.values!.length == values.length
                              ? SvgPicture.asset(
                                  'assets/svg/circle_check.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/svg/circle_minus.svg',
                                ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: widget.data.values!
                        .map(
                          (data) => GestureDetector(
                            onTap: () {
                              if (values.contains(data)) {
                                setState(() {
                                  values.removeWhere(
                                      (element) => element == data);
                                });
                              } else {
                                setState(() {
                                  values.add(data);
                                });
                              }
                            },
                            child: Container(
                              color: white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/menu_plus.svg',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: productColor.withOpacity(0.05),
                                        ),
                                        child: Text('${data.name}'),
                                      ),
                                    ],
                                  ),
                                  values.contains(data)
                                      ? SvgPicture.asset(
                                          'assets/svg/circle_check.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/svg/circle_minus.svg',
                                        ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
