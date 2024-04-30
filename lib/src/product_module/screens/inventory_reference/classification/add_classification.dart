import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
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
  final InventoryGoods? data;
  final ListenController listenController;
  const AddClassification({
    super.key,
    this.data,
    required this.listenController,
    required this.type,
  });

  @override
  State<AddClassification> createState() => _AddClassificationState();
}

class _AddClassificationState extends State<AddClassification> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  List<InventoryGoods> dynamics = [];
  General general = General();
  InventoryGoods product = InventoryGoods();

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
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        if (widget.data == null) {
          data.itemTypeId = source.product.itemTypeId;
          data.parentId = widget.type == "SUB_CLASSIFICATION"
              ? source.product.classificationId
              : widget.type == "CATEGORY"
                  ? source.product.subClassificationId
                  : widget.type == "SUB_CATEGORY"
                      ? source.product.categoryId
                      : null;
        }
        if (widget.type != 'SUB_CATEGORY') {
          loading.loading(true);
          if (widget.data == null) {
            data.type = widget.type;
            await InventoryApi().categoryCreate(data);
          } else {
            await InventoryApi().categoryUpdate(widget.data!.id!, data);
          }
          widget.listenController.changeVariable('classification');
          loading.loading(false);
        } else {
          loading.loading(true);
          if (widget.data == null) {
            data.categoryFields = dynamics;
            await InventoryApi().subCategoryCreate(data);
          } else {
            await InventoryApi().categoryUpdate(widget.data!.id!, data);
          }
          widget.listenController.changeVariable('classification');
          loading.loading(false);
        }
        showCustomDialog(context, "Амжилттай нэмлээ", true, onPressed: () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    product = Provider.of<InventoryProvider>(context, listen: true).product;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
                  Expanded(
                    child: widget.type == "CLASSIFICATION"
                        ? const Text(
                            'Ангилал',
                            style: TextStyle(
                              color: productColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : widget.type == "SUB_CLASSIFICATION"
                            ? const Text(
                                'Дэд ангилал',
                                style: TextStyle(
                                  color: productColor,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : widget.type == "CATEGORY"
                                ? const Text(
                                    'Категори',
                                    style: TextStyle(
                                      color: productColor,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : const Text(
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
                child: FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text('Энд бичээд "Хадгалах" сонгоно уу'),
                      ),
                      if (widget.data == null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              color: white,
                              labelText: 'Нэр төрөл',
                              secondText: product.itemTypeName ?? 'Сонгох',
                              onClick: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) => const ItemTypeSheet(),
                                );
                              },
                              arrowColor: productColor,
                              secondTextColor: productColor,
                            ),
                            if (type() < 4)
                              FieldCard(
                                paddingHorizontal: 15,
                                paddingVertical: 10,
                                color: white,
                                labelText: 'Ангилал',
                                secondText:
                                    product.classificationName ?? 'Сонгох',
                                onClick: product.itemTypeName != null
                                    ? () {
                                        showModalBottomSheet(
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) =>
                                              const CategorySheet(
                                            type: "CLASSIFICATION",
                                            labelText: "Ангилал сонгоно уу",
                                          ),
                                        );
                                      }
                                    : () {},
                                arrowColor: productColor,
                                secondTextColor: productColor,
                              ),
                            if (type() < 3)
                              FieldCard(
                                paddingHorizontal: 15,
                                paddingVertical: 10,
                                color: white,
                                labelText: 'Дэд ангилал',
                                secondText:
                                    product.subClassificationName ?? 'Сонгох',
                                onClick: product.classificationName != null
                                    ? () {
                                        showModalBottomSheet(
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) =>
                                              const CategorySheet(
                                            type: "SUB_CLASSIFICATION",
                                            labelText: "Дэд ангилал сонгоно уу",
                                          ),
                                        );
                                      }
                                    : () {},
                                arrowColor: productColor,
                                secondTextColor: productColor,
                              ),
                            if (type() < 2)
                              FieldCard(
                                paddingHorizontal: 15,
                                paddingVertical: 10,
                                color: white,
                                labelText: 'Категори',
                                secondText: product.categoryName ?? 'Сонгох',
                                onClick: () {
                                  if (product.subClassificationName != null) {
                                    showModalBottomSheet(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => const CategorySheet(
                                        type: "CATEGORY",
                                        labelText: "Категори сонгоно уу",
                                      ),
                                    );
                                  }
                                },
                                arrowColor: productColor,
                                secondTextColor: productColor,
                              ),
                          ],
                        ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'name',
                        initialValue: widget.data?.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд бичнэ үү',
                          hintStyle: const TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              widget.type == "CLASSIFICATION"
                                  ? const Text('Ангилалын нэр')
                                  : widget.type == "SUB_CLASSIFICATION"
                                      ? const Text('Дэд ангиллын нэр')
                                      : widget.type == "CATEGORY"
                                          ? const Text('Категори нэр')
                                          : const Text('Дэд категори нэр')
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      if (widget.type == "SUB_CATEGORY")
                        const SizedBox(
                          height: 15,
                        ),
                      if (widget.type == "SUB_CATEGORY" && widget.data == null)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: const Text('Динамик талбарууд'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dynamics.add(
                                        InventoryGoods(
                                          type: "TEXT",
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: productColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: const Text(
                                      '+ Шинэ талбар',
                                      style: TextStyle(
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: dynamics
                                  .map(
                                    (data) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                dynamics.removeAt(
                                                    dynamics.indexOf(data));
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5, right: 15),
                                              color: transparent,
                                              child: SvgPicture.asset(
                                                'assets/svg/square-x.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  black,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        FormTextField(
                                          name: "${dynamics.indexOf(data)}",
                                          onChanged: (value) {
                                            data.name = value;
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                            filled: true,
                                            fillColor: white,
                                            hintText: 'Динамик талбарын нэр',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(
                                                errorText: 'Заавал оруулна'),
                                          ]),
                                        ),
                                        FieldCard(
                                          paddingHorizontal: 15,
                                          paddingVertical: 10,
                                          labelText: 'Өгөгдлийн төрөл',
                                          color: white,
                                          secondText: data.type,
                                          onClick: () {
                                            select(data);
                                          },
                                        ),
                                        if (data.type == "NUMBER")
                                          FormTextField(
                                            name: "${dynamics.indexOf(data)}n",
                                            inputType: TextInputType.number,
                                            onChanged: (value) {
                                              data.numberUnit = value;
                                            },
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              filled: true,
                                              fillColor: white,
                                              hintText: 'Нэгж',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                  errorText: 'Заавал оруулна'),
                                            ]),
                                          ),
                                        if (data.type == "SELECT")
                                          Column(
                                            children: [
                                              FormTextField(
                                                name:
                                                    "${dynamics.indexOf(data)}s",
                                                inputType: TextInputType.number,
                                                onChanged: (value) {
                                                  data.numberUnit = value;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 10),
                                                  filled: true,
                                                  fillColor: white,
                                                  hintText: 'Сонголтот утга',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(
                                                          errorText:
                                                              'Заавал оруулна'),
                                                ]),
                                              ),
                                              FieldCard(
                                                paddingHorizontal: 15,
                                                paddingVertical: 10,
                                                labelText: 'Default утга',
                                                color: white,
                                                secondText: data.type,
                                                onClick: () {
                                                  select(data);
                                                },
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
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
                          textAlign: TextAlign.left,
                          name: 'description',
                          maxLines: 5,
                          initialValue: widget.data?.description,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: grey),
                            ),
                            fillColor: white,
                            filled: true,
                            hintText: 'Энд оруулна уу',
                            hintStyle: TextStyle(
                              color: grey2,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Заавал оруулна'),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  select(InventoryGoods data) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: general.fieldTypes!
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        data.type = e;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Text(e),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
