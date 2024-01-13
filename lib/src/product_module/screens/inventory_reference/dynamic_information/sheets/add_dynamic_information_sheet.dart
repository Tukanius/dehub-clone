import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
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
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<InventoryProvider>(context, listen: false).sectionClear();
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      final source = Provider.of<InventoryProvider>(context, listen: false);
      if (controller.text != '') {
        await InventoryApi().sectionCreate(
          InventoryGoods(
            sectionFields: source.product.sections,
            name: controller.text,
          ),
        );
        showCustomDialog(context, "Динамик мэдээлэл амжилттай нэмлээ", true,
            onPressed: () {
          Navigator.of(context).pop();
        });
      } else {
        showCustomDialog(context, "Нэр оруулна уу", false);
      }
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
                    onTap: () {
                      if (isSubmit == false) {
                        onSubmit();
                      }
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
                                                index: source.product.sections!
                                                    .indexOf(data),
                                                data: data,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                )
                              : SizedBox(),
                          source.product.sections != null &&
                                  source.product.sections?.length != 0
                              ? SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/information-square.svg',
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Талбарын мэдээлэл оруулаагүй байна. Нэмнэ үү.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: grey3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                source.section(
                                  InventoryGoods(name: controller.text),
                                  false,
                                );
                                setState(() {
                                  controller.text = '';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: productColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '+Талбар',
                                  style: TextStyle(color: productColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
