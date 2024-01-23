import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateOptionSheet extends StatefulWidget {
  final InventoryGoods data;
  const UpdateOptionSheet({
    required this.data,
    super.key,
  });

  @override
  State<UpdateOptionSheet> createState() => _UpdateOptionSheetState();
}

class _UpdateOptionSheetState extends State<UpdateOptionSheet> {
  bool isSubmit = false;
  List<String> values = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < widget.data.values!.length; i++) {
      values.add(widget.data.values![i].name!);
    }
    super.initState();
  }

  onSubmit() async {
    await InventoryApi().optionUpdate(
      widget.data.id!,
      InventoryGoods(
        name: widget.data.name,
        isGoods: widget.data.isGoods,
        isService: widget.data.isService,
        selections: values,
      ),
    );
    showCustomDialog(context, "Амжилттай", true, onPressed: () {
      Navigator.of(context).pop();
    });
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
                      colorFilter: const ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Хувилбарын сонголт',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: isSubmit == false
                      ? () {
                          onSubmit();
                        }
                      : () {},
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Сонголт нэмэх боломжтой',
                      style: TextStyle(color: grey2),
                    ),
                  ),
                  Column(
                    children: values
                        .map(
                          (data) => Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/menu_plus.svg'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: productColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 15),
                                      child: Text(
                                        data.toUpperCase(),
                                        style: const TextStyle(
                                          color: grey2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      values.removeWhere(
                                          (element) => element == data);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    color: transparent,
                                    child: SvgPicture.asset(
                                        'assets/svg/remove.svg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  FormTextField(
                    textColor: networkColor,
                    name: "name",
                    onChanged: (p0) {
                      setState(() {
                        controller.text = p0;
                      });
                    },
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Энд оруулна уу',
                      hintStyle: TextStyle(color: networkColor),
                      fillColor: white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                      onClick: controller.text == ""
                          ? () {}
                          : () {
                              setState(() {
                                values.add(controller.text);
                                controller.text = '';
                              });
                            },
                      labelText: 'Нэмэх',
                      textColor: productColor,
                      labelColor: white,
                      borderColor: productColor,
                    ),
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
