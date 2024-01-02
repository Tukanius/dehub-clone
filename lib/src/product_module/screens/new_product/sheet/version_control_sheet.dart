import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class VersionControlSheet extends StatefulWidget {
  const VersionControlSheet({
    super.key,
  });

  @override
  State<VersionControlSheet> createState() => _VersionControlSheetState();
}

class _VersionControlSheetState extends State<VersionControlSheet>
    with AfterLayoutMixin {
  List<InventoryGoods> values = [];
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    for (var i = 0; i < source.product.values!.length; i++) {
      for (var f = 0; f < source.product.values![i].values!.length; f++) {
        print(source.product.values?[i].values?[f].toJson());
      }
    }
    setState(() {
      isLoading = false;
    });
  }

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
                    'Хувилбар хянах',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
                      'Барааны хувилбарыг дараах байдлаар үүсгэх гэж байна. Хянаад “Болсон” гэдгийг сонгоно уу.',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Бүх хувилбарыг сонгох'),
                          SvgPicture.asset(
                            'assets/svg/circle_minus.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: source.product.values!
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
