import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateSubCategory extends StatefulWidget {
  static const routeName = '/CreateSubCategory';
  const CreateSubCategory({
    super.key,
  });

  @override
  State<CreateSubCategory> createState() => _CreateSubCategoryState();
}

class _CreateSubCategoryState extends State<CreateSubCategory> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSubmit = false;

  create() async {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        InventoryGoods create =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        create.itemTypeId = source.product.itemTypeId;
        create.parentId = source.product.categoryId;
        await InventoryApi().subCategoryCreate(create);
        showCustomDialog(
          context,
          "Дэд категори амжилттай нэмлээ",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Дэд категори нэмэх',
          style: TextStyle(
            color: productColor,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Энгийн болон динамик талбартай дэд категори нэмэх',
                style: TextStyle(
                  color: grey3,
                  fontSize: 12,
                ),
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Нэр төрөл',
              secondText: source.product.itemTypeName,
              secondTextColor: grey3,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Ангилал',
              secondText: source.product.classificationName,
              secondTextColor: grey3,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Дэд ангилал',
              secondText: source.product.subClassificationName,
              secondTextColor: grey3,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              color: white,
              labelText: 'Категори',
              secondText: source.product.categoryName,
              secondTextColor: grey3,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Дэд категори',
                style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
              ),
            ),
            FormBuilder(
              key: fbKey,
              child: Column(
                children: [
                  FormTextField(
                    textColor: productColor,
                    textAlign: TextAlign.end,
                    name: 'name',
                    onChanged: (value) {
                      source.product.standardPrice =
                          double.tryParse(value) ?? 0;
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: white,
                      filled: true,
                      hintText: 'Оруулна уу',
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
                          Text(
                            'Дэд категори нэр',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: const Text(
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
                    child: const FormTextField(
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
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Динамик талбар',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: productColor.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '+Шинэ талбар',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: CustomButton(
                    isLoading: isSubmit,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    labelText: 'Буцах',
                    borderColor: productColor,
                    labelColor: white,
                    textColor: productColor,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    isLoading: isSubmit,
                    onClick: () {
                      create();
                    },
                    labelText: 'Хадгалах',
                    labelColor: productColor,
                    textColor: white,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
