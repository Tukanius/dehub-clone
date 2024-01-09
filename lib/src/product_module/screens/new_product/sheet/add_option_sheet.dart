import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';

class AddOptionSheet extends StatefulWidget {
  final bool? isService;
  final bool? isGoods;
  const AddOptionSheet({
    super.key,
    this.isService,
    this.isGoods,
  });

  @override
  State<AddOptionSheet> createState() => _AddOptionSheetState();
}

class _AddOptionSheetState extends State<AddOptionSheet> {
  TextEditingController controller = TextEditingController();
  TextEditingController valueController = TextEditingController();
  List<String> values = [];

  addValue() {
    int index = values.indexWhere((element) => element == valueController.text);
    if (index < 0) {
      values.add(valueController.text);
      valueController.text = '';
    } else {
      showCustomDialog(context, 'Утга давхцаж байна', false);
      valueController.text = '';
    }
  }

  onSubmit() async {
    if (values.length < 2) {
      showCustomDialog(context, 'Сонголтууд дор хаяж 2 байх ёстой', false);
    } else {
      await InventoryApi().optionCreate(
        widget.isService == null
            ? InventoryGoods(
                name: controller.text,
                isGoods: true,
                isService: false,
                selections: values,
              )
            : InventoryGoods(
                name: controller.text,
                isGoods: widget.isGoods,
                isService: widget.isService,
                selections: values,
              ),
      );
      showCustomDialog(
        context,
        'Хувилбар амжилттай нэмлээ',
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  void dispose() {
    valueController.dispose();
    controller.dispose();
    super.dispose();
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
                    'Хувилбар нэмэх',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Мэдээлэл оруулна уу',
                      style: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ),
                  FormTextField(
                    textColor: productColor,
                    controller: controller,
                    textAlign: TextAlign.end,
                    onChanged: (p0) {
                      setState(() {});
                    },
                    name: 'name',
                    decoration: InputDecoration(
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
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Хувилбарын нэр',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  controller.text != ''
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                'Сонголтууд оруулна уу',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ),
                            Column(
                              children: values
                                  .map(
                                    (data) => Container(
                                      color: white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/menu_plus.svg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${data}',
                                                style: TextStyle(color: grey2),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                values.removeAt(
                                                    values.indexOf(data));
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              color: transparent,
                                              child: SvgPicture.asset(
                                                'assets/svg/remove.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            FormTextField(
                              controller: valueController,
                              textColor: productColor,
                              name: 'value',
                              onChanged: (p0) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: white,
                                filled: true,
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(
                                  color: productColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            valueController.text != ''
                                ? CustomButton(
                                    labelColor: white,
                                    textColor: productColor,
                                    borderColor: productColor,
                                    labelText: 'Нэмэх',
                                    onClick: () {
                                      addValue();
                                    },
                                  )
                                : SizedBox(),
                          ],
                        )
                      : SizedBox(),
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
