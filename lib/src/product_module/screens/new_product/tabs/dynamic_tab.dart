import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/components/check_box_field.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/dynamic_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/field_value_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DynamicTab extends StatefulWidget {
  final String? id;
  const DynamicTab({
    super.key,
    this.id,
  });

  @override
  State<DynamicTab> createState() => _DynamicTabState();
}

class _DynamicTabState extends State<DynamicTab> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSubmit = false;

  onSubmit() async {
    final res = Provider.of<InventoryProvider>(context, listen: false);
    List<String> sectionIds = [];
    List<InventoryGoods> itemFieldValues = [];
    try {
      setState(() {
        isSubmit = true;
      });
      if (res.product.sections != null) {
        for (var i = 0; i < res.product.sections!.length; i++) {
          sectionIds.add(res.product.sections![i].id!);
          for (var f = 0; f < res.product.sections![i].fields!.length; f++) {
            itemFieldValues.add(
              res.product.sections?[i].fields?[f].type == "CHECKBOX"
                  ? InventoryGoods(
                      sectionId: sectionIds[i],
                      fieldId: res.product.sections?[i].fields?[f].id,
                      fieldType: res.product.sections?[i].fields?[f].type,
                      checked:
                          res.product.sections?[i].fields?[f].checked ?? false,
                    )
                  : InventoryGoods(
                      sectionId: sectionIds[i],
                      fieldId: res.product.sections?[i].fields?[f].id,
                      fieldType: res.product.sections?[i].fields?[f].type,
                      number: res.product.sections?[i].fields?[f].number,
                      fieldValueId:
                          res.product.sections?[i].fields?[f].fieldValueId,
                      text: res.product.sections?[i].fields?[f].text,
                    ),
            );
          }
        }
        await InventoryApi().additionalInfo(
            InventoryGoods(
              sectionIds: sectionIds,
              itemFieldValues: itemFieldValues,
            ),
            widget.id == null ? res.product.id! : widget.id!);
      }
      Provider.of<IndexProvider>(context, listen: false)
          .newProductIndexChange(2);
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

    return SingleChildScrollView(
      child: FormBuilder(
        key: fbKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Категорийн динамик мэдээлэл',
                style: TextStyle(color: productColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/information-square.svg',
                    colorFilter:
                        const ColorFilter.mode(productColor, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'Дэд категорит хамаарах динамик мэдээлэл тохируулаагүй байна.',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Бүтээгдэхүүний нэмэлт мэдээлэл',
                style: TextStyle(color: productColor),
              ),
            ),
            source.product.sections == null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/information-square.svg',
                          colorFilter: const ColorFilter.mode(
                              productColor, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text(
                            'Бүтээгдэхүүний нэмэлт мэдээлэл тохируулаагүй байна.',
                            style: TextStyle(
                              color: grey3,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: source.product.sections!.map(
                      (data) {
                        int index = source.product.sections!.indexOf(data);
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${data.name}",
                                      style: TextStyle(
                                        color: dark.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      source.removeSection(
                                        source.product.sections!.indexOf(data),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg/square-x.svg',
                                      colorFilter: ColorFilter.mode(
                                        dark.withOpacity(0.5),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: data.fields!.map((item) {
                                int fieldIndex = data.fields!.indexOf(item);
                                return item.type == "SELECT"
                                    ? FieldCard(
                                        validate: source.fieldValidate,
                                        paddingHorizontal: 15,
                                        paddingVertical: 10,
                                        labelText: "${item.name}",
                                        onClick: () {
                                          valueSheet(
                                              item.values!, index, fieldIndex);
                                        },
                                        secondText: source
                                                    .product
                                                    .sections?[index]
                                                    .fields?[fieldIndex]
                                                    .fieldValueName !=
                                                null
                                            ? source
                                                .product
                                                .sections![index]
                                                .fields![fieldIndex]
                                                .fieldValueName
                                            : 'Сонгох',
                                        color: white,
                                        secondTextColor: productColor,
                                        arrowColor: productColor,
                                      )
                                    : item.type == "TEXT"
                                        ? FormTextField(
                                            name: item.id,
                                            textAlign: TextAlign.end,
                                            textColor: productColor,
                                            onChanged: (value) {
                                              source
                                                  .product
                                                  .sections?[index]
                                                  .fields?[fieldIndex]
                                                  .text = value;
                                            },
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                errorText: 'Заавал оруулна уу',
                                              )
                                            ]),
                                            decoration: InputDecoration(
                                              prefixIcon: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text('${item.name}')
                                                ],
                                              ),
                                              hintText: "Энд оруулна уу",
                                              hintStyle: const TextStyle(
                                                  color: productColor),
                                              filled: true,
                                              fillColor: white,
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                            ),
                                          )
                                        : item.type == "NUMBER"
                                            ? FormTextField(
                                                inputType: TextInputType.number,
                                                name: item.id,
                                                textAlign: TextAlign.end,
                                                textColor: productColor,
                                                onChanged: (value) {
                                                  source
                                                          .product
                                                          .sections?[index]
                                                          .fields?[fieldIndex]
                                                          .number =
                                                      int.tryParse(value) ?? 0;
                                                },
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(
                                                    errorText:
                                                        'Заавал оруулна уу',
                                                  )
                                                ]),
                                                decoration: InputDecoration(
                                                  prefixIcon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('${item.name}')
                                                    ],
                                                  ),
                                                  hintText: "Энд оруулна уу",
                                                  hintStyle: const TextStyle(
                                                    color: productColor,
                                                  ),
                                                  filled: true,
                                                  fillColor: white,
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 15,
                                                    vertical: 10,
                                                  ),
                                                ),
                                              )
                                            : CheckboxField(
                                                data: item,
                                                index: index,
                                                fieldIndex: fieldIndex,
                                              );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
            Divider(
              color: productColor.withOpacity(0.5),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 45,
                ),
                Expanded(
                  child: CustomButton(
                    onClick: () {},
                    labelText: '+ Талбар нэмэх',
                    textColor: productColor,
                    labelColor: productColor.withOpacity(0.2),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: CustomButton(
                    onClick: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        context: context,
                        builder: (context) => const DynamicSheet(),
                      );
                    },
                    labelText: 'Сонголт хийх',
                    textColor: productColor,
                    labelColor: productColor.withOpacity(0.2),
                  ),
                ),
                const SizedBox(
                  width: 45,
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
                    onClick: () {},
                    labelText: 'Хадгалах',
                    textColor: productColor,
                    borderColor: productColor,
                    labelColor: white,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CustomButton(
                    isLoading: isSubmit,
                    onClick: () {
                      if (fbKey.currentState!.saveAndValidate() &&
                          source.fieldValidate == false) {
                        onSubmit();
                      }
                    },
                    labelText: 'Үргэлжлүүлэх',
                    labelColor: productColor,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  valueSheet(List<InventoryGoods> data, int index, int fieldIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FieldValueSheet(
        data: data,
        index: index,
        fieldIndex: fieldIndex,
      ),
    );
  }
}
