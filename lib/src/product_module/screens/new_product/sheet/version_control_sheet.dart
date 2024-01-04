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
  bool isLoading = true;
  List<List<InventoryGoods>> options = [];
  List<List<InventoryGoods>> selectedOptions = [];

  generateValues() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    generate(int index, List<InventoryGoods> combination) {
      if (index == source.product.values?.length) {
        options.add(List.from(combination));
        return;
      }
      for (var element in source.product.values![index].values!) {
        combination.add(element);
        generate(index + 1, combination);
        combination.removeLast();
      }
    }

    generate(0, []);
    return options;
  }

  onSubmit() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    source.optionValue(selectedOptions);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    generateValues();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    onSubmit();
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
            child: isLoading == true
                ? SizedBox()
                : SingleChildScrollView(
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
                          onTap: () {
                            setState(() {
                              selectedOptions = List.from(options);
                            });
                          },
                          child: Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Бүх хувилбарыг сонгох'),
                                selectedOptions.length == options.length
                                    ? SvgPicture.asset(
                                        'assets/svg/circle_check.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/circle_minus.svg',
                                      )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: options
                              .map(
                                (data) => GestureDetector(
                                  onTap: () {
                                    if (selectedOptions.contains(data)) {
                                      setState(() {
                                        selectedOptions.removeWhere(
                                            (element) => element == data);
                                      });
                                    } else {
                                      setState(() {
                                        selectedOptions.add(data);
                                      });
                                    }
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/menu_plus.svg',
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: data
                                                      .map(
                                                        (item) => Container(
                                                          margin: EdgeInsets.only(
                                                              right: item.id ==
                                                                      data.last
                                                                          .id
                                                                  ? 0
                                                                  : 5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 3),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: productColor
                                                                .withOpacity(
                                                                    0.05),
                                                          ),
                                                          child: Text(
                                                            '${item.name}',
                                                            style: TextStyle(
                                                              color: grey2,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        selectedOptions.contains(data)
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
                        SizedBox(
                          height: 40,
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
