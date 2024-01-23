import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/components/brand_form.dart';
import 'package:dehub/src/product_module/screens/new_product/components/group_form.dart';
import 'package:dehub/src/product_module/screens/new_product/components/picture_form.dart';
import 'package:dehub/src/product_module/screens/new_product/components/product_form.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  InventoryGoods data = InventoryGoods();
  var profileKey = GlobalKey();
  dynamic res;
  bool isSubmit = false;

  validateCheck() {
    if (data.detailImages == null || data.detailImages!.isEmpty) {
      res.banValidate();
      Scrollable.ensureVisible(
        profileKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    if (data.url == null) {
      res.proValidate();
      Scrollable.ensureVisible(
        profileKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
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
        data.tagName != null &&
        res.bannerValidate == false &&
        res.profileValidate == false) {
      onSubmit();
    }
  }

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      var res = await InventoryApi().goodsCreate(
        InventoryGoods(
          skuCode: data.skuCode,
          barCode: data.barCode,
          erpCode: data.erpCode,
          nameMon: data.nameMon,
          nameEng: data.nameEng,
          nameBill: data.nameBill,
          nameWeb: data.nameWeb,
          nameApp: data.nameApp,
          brandId: data.brandId,
          supplierId: data.supplierId,
          manufacturerId: data.manufacturerId,
          originCountry: data.manufacturerCountryId,
          importerCountry: data.importerCountry,
          distributorId: data.distributorId,
          itemTypeId: data.itemTypeId,
          classificationId: data.classificationId,
          subClassificationId: data.subClassificationId,
          categoryId: data.categoryId,
          subCategoryId: data.subCategoryId,
          tagId: data.tagId,
          description: data.description,
          coverImages: [
            InventoryGoods(
              isMain: true,
              url: data.url,
            ),
          ],
          detailImages: data.detailImages,
        ),
      );
      await Provider.of<InventoryProvider>(context, listen: false)
          .id(res.id.toString());
      await Provider.of<IndexProvider>(context, listen: false)
          .newProductIndexChange(1);
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
    data = Provider.of<InventoryProvider>(context, listen: true).product;
    res = Provider.of<InventoryProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: FormBuilder(
          key: fbKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PictureForm(
                profileKey: profileKey,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Бүртгэлийн мэдээлэл',
                  style: TextStyle(
                    color: productColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: productColor,
              ),
              const FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "DeHUB код",
                color: white,
                labelTextColor: dark,
                secondTextColor: grey3,
                secondText: 'Авто гарна',
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Бүртгэлийн статус',
                      style: TextStyle(
                        color: dark,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: grey3.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: const Text(
                        'Түр төлөв',
                        style: TextStyle(fontSize: 14, color: grey3),
                      ),
                    ),
                  ],
                ),
              ),
              const FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 10,
                labelText: "Бүртгэсэн ажилтан",
                color: white,
                labelTextColor: dark,
                secondTextColor: grey3,
                secondText: 'Авто гарна',
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Барааны нэр код',
                  style: TextStyle(
                    color: productColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: productColor,
              ),
              const ProductForm(),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Бүртгэлийн мэдээлэл',
                  style: TextStyle(
                    color: productColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: productColor,
              ),
              BrandForm(
                context: context,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Бараа хамаарах бүлэг',
                  style: TextStyle(
                    color: productColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: productColor,
              ),
              GroupForm(
                context: context,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                child: FormTextField(
                  onChanged: (value) {
                    res.description(value);
                  },
                  initialValue: res.product.description,
                  readOnly: false,
                  textAlign: TextAlign.left,
                  name: 'description',
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: grey3),
                    ),
                    fillColor: white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: grey2,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Тайлбар оруулна уу'),
                  ]),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton(
                onClick: () {
                  validateCheck();
                },
                isLoading: isSubmit,
                labelColor: productColor,
                labelText: "Үргэлжлүүлэх",
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
