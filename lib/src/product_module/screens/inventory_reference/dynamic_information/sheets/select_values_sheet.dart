import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SelectValuesSheet extends StatefulWidget {
  final int index;
  const SelectValuesSheet({
    super.key,
    required this.index,
  });

  @override
  State<SelectValuesSheet> createState() => _SelectValuesSheetState();
}

class _SelectValuesSheetState extends State<SelectValuesSheet>
    with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  List<InventoryGoods> fieldValues = [];
  InventoryGoods defaultValue = InventoryGoods();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    Provider.of<InventoryProvider>(context, listen: false)
        .clearSectionValues(widget.index);
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    int index = fieldValues.indexWhere((element) => element.isDefault == true);
    if (index > -1) {
      for (var i = 0; i < fieldValues.length; i++) {
        source.sectionValues(
          widget.index,
          InventoryGoods(
            name: fieldValues[i].name,
            isDefault: defaultValue.name == fieldValues[i].name ? true : false,
          ),
        );
      }
    } else {
      for (var i = 0; i < fieldValues.length; i++) {
        source.sectionValues(
          widget.index,
          InventoryGoods(
            name: fieldValues[i].name,
            isDefault: i == 0 ? true : false,
          ),
        );
      }
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
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
                      colorFilter:
                          const ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Сонголтод утгууд нэмэх',
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: productColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Хадгалах',
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
                ? const SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Нэр бичээд "+Нэмэх" товчийг дарж нэмнэ үү.',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                        FormTextField(
                          textColor: productColor,
                          textAlign: TextAlign.end,
                          controller: controller,
                          name: 'name',
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: white,
                            filled: true,
                            hintText: 'Энд оруулна уу',
                            hintStyle: TextStyle(
                              color: productColor,
                            ),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Нэр'),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (controller.text != '') {
                                setState(() {
                                  fieldValues.add(
                                    InventoryGoods(
                                      name: controller.text,
                                      isDefault: false,
                                    ),
                                  );
                                  controller.text = '';
                                });
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: productColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                '+Нэмэх',
                                style: TextStyle(color: productColor),
                              ),
                            ),
                          ),
                        ),
                        if (fieldValues.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'Сонголтууд',
                              style: TextStyle(
                                color: grey2,
                              ),
                            ),
                          ),
                        Column(
                          children: fieldValues
                              .map(
                                (data) => Container(
                                  color: white,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data.name}',
                                            style: const TextStyle(
                                                color: productColor),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Default эсэх : ',
                                                style: TextStyle(color: grey2),
                                              ),
                                              Transform.scale(
                                                scale: 0.7,
                                                child: CupertinoSwitch(
                                                  activeColor: paymentColor,
                                                  value: defaultValue.name ==
                                                      data.name,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      defaultValue = data;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            fieldValues.removeAt(
                                              fieldValues.indexOf(data),
                                            );
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/svg/close.svg',
                                          height: 20,
                                          width: 20,
                                          colorFilter: const ColorFilter.mode(
                                              productColor, BlendMode.srcIn),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
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
