import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/dynamic_information/sheets/field_setting_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class AddDinamycInformation extends StatefulWidget {
  const AddDinamycInformation({super.key});

  @override
  State<AddDinamycInformation> createState() => _AddDinamycInformationState();
}

class _AddDinamycInformationState extends State<AddDinamycInformation>
    with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<InventoryProvider>(context, listen: false).sectionClear();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
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
                      colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Динамик мэдээлэл',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
              child: isLoading == true
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text('Динамик мэдээлэл'),
                        ),
                        FormTextField(
                          textColor: productColor,
                          textAlign: TextAlign.end,
                          controller: controller,
                          onComplete: () {
                            source.section(
                              InventoryGoods(name: controller.text),
                            );
                            setState(() {
                              controller.text = '';
                            });
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
                                Text('Нэр'),
                              ],
                            ),
                          ),
                        ),
                        source.product.sections != null &&
                                source.product.sections?.length != 0
                            ? Column(
                                children: source.product.sections!
                                    .map(
                                      (data) => FieldCard(
                                        paddingHorizontal: 15,
                                        paddingVertical: 10,
                                        color: white,
                                        labelText: data.name,
                                        secondText: data.type,
                                        secondTextColor: productColor,
                                        arrowColor: productColor,
                                        onClick: () {
                                          showModalBottomSheet(
                                            context: context,
                                            useSafeArea: true,
                                            builder: (context) =>
                                                FieldSettingSheet(
                                              data: data,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : SizedBox(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
