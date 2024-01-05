import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/category_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/item_type_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddClassification extends StatefulWidget {
  final String type;
  const AddClassification({
    super.key,
    required this.type,
  });

  @override
  State<AddClassification> createState() => _AddClassificationState();
}

class _AddClassificationState extends State<AddClassification> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  type() {
    switch (widget.type) {
      case "CLASSIFICATION":
        return 4;
      case "SUB_CLASSIFICATION":
        return 3;
      case "CATEGORY":
        return 2;
      case "SUB_CATEGORY":
        return 1;
      default:
    }
  }

  onSubmit() async {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods data = InventoryGoods.fromJson(fbKey.currentState!.value);
      data.itemTypeId = source.product.itemTypeId;
      data.parentId = widget.type == "SUB_CLASSIFICATION"
          ? source.product.classificationId
          : widget.type == "CATEGORY"
              ? source.product.subClassificationId
              : widget.type == "SUB_CATEGORY"
                  ? source.product.categoryId
                  : null;
      if (widget.type != 'SUB_CATEGORY') {
        data.type = widget.type;
        await InventoryApi().categoryCreate(data);
      } else {
        await InventoryApi().subCategoryCreate(data);
      }
      showCustomDialog(context, "Амжилттай нэмлээ", true, onPressed: () {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    InventoryGoods product =
        Provider.of<InventoryProvider>(context, listen: true).product;
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
                  child: widget.type == "CLASSIFICATION"
                      ? Text(
                          'Ангилал',
                          style: TextStyle(
                            color: productColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : widget.type == "SUB_CLASSIFICATION"
                          ? Text(
                              'Дэд ангилал',
                              style: TextStyle(
                                color: productColor,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : widget.type == "CATEGORY"
                              ? Text(
                                  'Категори',
                                  style: TextStyle(
                                    color: productColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  'Дэд категори',
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
              child: FormBuilder(
                key: fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text('Энд бичээд "Хадгалах" сонгоно уу'),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 10,
                      color: white,
                      labelText: 'Нэр төрөл',
                      secondText: product.itemTypeName != null
                          ? product.itemTypeName
                          : 'Сонгох',
                      onClick: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          builder: (context) => ItemTypeSheet(),
                        );
                      },
                      arrowColor: productColor,
                      secondTextColor: productColor,
                    ),
                    type() < 4
                        ? FieldCard(
                            paddingHorizontal: 15,
                            paddingVertical: 10,
                            color: white,
                            labelText: 'Ангилал',
                            secondText: product.classificationName != null
                                ? product.classificationName
                                : 'Сонгох',
                            onClick: product.itemTypeName != null
                                ? () {
                                    showModalBottomSheet(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => CategorySheet(
                                        type: "CLASSIFICATION",
                                        labelText: "Ангилал сонгоно уу",
                                      ),
                                    );
                                  }
                                : () {},
                            arrowColor: productColor,
                            secondTextColor: productColor,
                          )
                        : SizedBox(),
                    type() < 3
                        ? FieldCard(
                            paddingHorizontal: 15,
                            paddingVertical: 10,
                            color: white,
                            labelText: 'Дэд ангилал',
                            secondText: product.subClassificationName != null
                                ? product.subClassificationName
                                : 'Сонгох',
                            onClick: product.classificationName != null
                                ? () {
                                    showModalBottomSheet(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => CategorySheet(
                                        type: "SUB_CLASSIFICATION",
                                        labelText: "Дэд ангилал сонгоно уу",
                                      ),
                                    );
                                  }
                                : () {},
                            arrowColor: productColor,
                            secondTextColor: productColor,
                          )
                        : SizedBox(),
                    type() < 2
                        ? FieldCard(
                            paddingHorizontal: 15,
                            paddingVertical: 10,
                            color: white,
                            labelText: 'Категори',
                            secondText: product.categoryName != null
                                ? product.categoryName
                                : 'Сонгох',
                            onClick: product.subClassificationName != null
                                ? () {
                                    showModalBottomSheet(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => CategorySheet(
                                        type: "CATEGORY",
                                        labelText: "Категори сонгоно уу",
                                      ),
                                    );
                                  }
                                : () {},
                            arrowColor: productColor,
                            secondTextColor: productColor,
                          )
                        : SizedBox(),
                    FormTextField(
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'name',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: white,
                        filled: true,
                        hintText: 'Энд бичнэ үү',
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
                            widget.type == "CLASSIFICATION"
                                ? Text('Ангилалын нэр')
                                : widget.type == "SUB_CLASSIFICATION"
                                    ? Text('Дэд ангиллын нэр')
                                    : widget.type == "CATEGORY"
                                        ? Text('Категори нэр')
                                        : Text('Дэд категори нэр')
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Заавал оруулна',
                        ),
                      ]),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Text(
                        'Тайлбар',
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.all(15),
                      child: FormTextField(
                        textAlign: TextAlign.left,
                        name: 'description',
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: grey),
                          ),
                          fillColor: white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
