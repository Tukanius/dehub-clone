import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/components/brand_form.dart';
import 'package:dehub/src/product_module/screens/new_product/components/group_form.dart';
import 'package:dehub/src/product_module/screens/new_product/components/product_form.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  InventoryGoods data = InventoryGoods();
  var res;

  validateCheck() {
    if (data.itemTypeName == null) {
      res.itValidate();
    }
    if (data.classificationName == null) {
      res.classValidate();
    }
    if (data.subClassificationName == null) {
      res.subClassValidate();
    }
    if (data.categoryName == null) {
      res.catValidate();
    }
    if (data.subCategoryName == null) {
      res.subCatValidate();
    }
    if (data.tagName == null) {
      res.tValidate();
    }
    if (fbKey.currentState!.saveAndValidate() &&
        data.itemTypeName != null &&
        data.classificationName != null &&
        data.subClassificationName != null &&
        data.categoryName != null &&
        data.subCategoryName != null &&
        data.tagName != null) {
      Provider.of<IndexProvider>(context, listen: false)
          .newProductIndexChange(1);
    }
  }

  onSubmit() {
    if (fbKey.currentState!.saveAndValidate()) {
      Provider.of<IndexProvider>(context, listen: false)
          .newProductIndexChange(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    data = Provider.of<InventoryProvider>(context, listen: true).product;
    res = Provider.of<InventoryProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Бүртгэлийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: productColor,
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "DeHUB код",
              color: white,
              labelTextColor: dark,
              secondTextColor: grey3,
              secondText: 'Авто гарна',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүртгэлийн статус',
                    style: TextStyle(
                      color: dark,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: grey3.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey3),
                    ),
                    child: Text(
                      'Түр төлөв',
                      style: TextStyle(fontSize: 12, color: grey3),
                    ),
                  ),
                ],
              ),
            ),
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Бүртгэсэн ажилтан",
              color: white,
              labelTextColor: dark,
              secondTextColor: grey3,
              secondText: 'Авто гарна',
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Барааны нэр код',
                style: TextStyle(
                  color: grey3,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: productColor,
            ),
            FormBuilder(
              key: fbKey,
              child: ProductForm(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Бүртгэлийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: productColor,
            ),
            BrandForm(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Бараа хамаарах бүлэг',
                style: TextStyle(
                  color: grey3,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: productColor,
            ),
            GroupForm(),
            SizedBox(
              height: 100,
            ),
            CustomButton(
              onClick: () {
                // onSubmit();
                validateCheck();
              },
              labelColor: productColor,
              labelText: "Үргэлжлүүлэх",
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
