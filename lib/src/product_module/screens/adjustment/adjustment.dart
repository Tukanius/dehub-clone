import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/src/product_module/components/resource_product_card/product_card.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Adjustment extends StatefulWidget {
  static const routeName = '/Adjustment';
  const Adjustment({super.key});

  @override
  State<Adjustment> createState() => _AdjustmentState();
}

class _AdjustmentState extends State<Adjustment> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  Result adjustmentNote = Result(rows: [], count: 0);
  InventoryGoods selectedVariant = InventoryGoods();
  Result warehouse = Result(rows: [], count: 0);
  Result variants = Result(rows: [], count: 0);
  InventoryGoods select = InventoryGoods();
  TextEditingController controller = TextEditingController();
  bool movementValidate = false;
  bool variantSelected = false;
  General general = General();
  bool noteValidate = false;
  String? movementTypeId;
  bool isLoading = true;
  String? warehouseName;
  String? movementType;
  String? warehouseId;
  String? noteName;
  String? noteId;

  @override
  afterFirstLayout(BuildContext context) async {
    warehouse = await InventoryApi().warehouse();
    adjustmentNote = await InventoryApi().adjustmentNoteSelect();
    setState(() {
      isLoading = false;
    });
  }

  validateCheck() {
    if (noteName == null) {
      setState(() {
        noteValidate = true;
      });
    }
    if (movementType == null) {
      setState(() {
        movementValidate = true;
      });
    }

    if (fbkey.currentState!.saveAndValidate()) {}
    if (movementValidate == false &&
        noteValidate == false &&
        fbkey.currentState!.saveAndValidate()) {
      onSubmit();
    }
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      InventoryGoods data = InventoryGoods.fromJson(fbkey.currentState!.value);
      data.warehouseId = warehouseId;
      data.confirm = true;
      data.variants = [
        InventoryGoods(
          variantId: selectedVariant.id,
          movementType: movementTypeId,
          adjustmentNoteId: noteId,
          quantity: double.parse(controller.text),
        ),
      ];
      await InventoryApi().adjust(data);
      loading.loading(false);
      showCustomDialog(context, "Амжилттай", true, onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: variantSelected == true
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    selectedVariant = select;
                    variantSelected = false;
                  });
                },
                backgroundColor: productColor,
                child: const Text(
                  'Сонгох',
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                  ),
                ),
              )
            : const SizedBox(),
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: productColor),
          title: const Text(
            'Үлдэгдэл шинээр тохируулах',
            style: TextStyle(
              color: productColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: productColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 10,
                      color: white,
                      labelText: 'Агуулах сонгох',
                      secondText: warehouseName ?? 'Сонгох',
                      secondTextColor: productColor,
                      onClick: () {
                        warehouseSelect();
                      },
                    ),
                    selectedVariant.id == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (variants.rows!.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Text(
                                    'Бараа сонгох',
                                    style: TextStyle(
                                        color: grey2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              Column(
                                children: variants.rows!.map(
                                  (e) {
                                    return ProductCard(
                                      onClick: () {
                                        setState(() {
                                          select = e;
                                          variantSelected = true;
                                        });
                                      },
                                      data: e,
                                      border: e == select,
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          )
                        : FormBuilder(
                            key: fbkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Text(
                                    'Сонгосон бараа',
                                    style: TextStyle(
                                        color: grey2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: grey2),
                                  ),
                                  child: Column(
                                    children: [
                                      ProductCard(
                                        data: selectedVariant,
                                        border: false,
                                      ),
                                      FieldCard(
                                        validate: movementValidate,
                                        paddingHorizontal: 10,
                                        paddingVertical: 10,
                                        labelText: 'Өөрчлөлтийн төрөл',
                                        secondText: movementType ?? 'Сонгох',
                                        color: white,
                                        fontSize: 12,
                                        onClick: () {
                                          movementTypeSelect();
                                        },
                                      ),
                                      FieldCard(
                                        validate: noteValidate,
                                        paddingHorizontal: 10,
                                        paddingVertical: 10,
                                        labelText: 'Тайлбар',
                                        secondText: noteName ?? 'Сонгох',
                                        color: white,
                                        fontSize: 12,
                                        onClick: () {
                                          noteSelect();
                                        },
                                      ),
                                      FormTextField(
                                        fontSize: 12,
                                        name: 'asdf',
                                        controller: controller,
                                        inputType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide.none,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(color: red),
                                          ),
                                          hintText: 'Тохируулах дүн',
                                          fillColor: white,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          isDense: true,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: 'Заавал оруулна'),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FormTextField(
                                  name: 'reference',
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Уялдаатай Ref',
                                    fillColor: white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна')
                                  ]),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: const Text(
                                    'Тайлбар',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: grey3,
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
                                      hintText: 'Энд оруулна уу',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: grey2.withOpacity(0.3),
                                        ),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: red),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      fillColor: white,
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: grey2,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        onClick: () {},
                                        labelText: 'Буцах',
                                        borderColor: productColor,
                                        textColor: productColor,
                                        labelColor: backgroundColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        onClick: () {
                                          validateCheck();
                                        },
                                        labelText: 'Батлах',
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
                  ],
                ),
              ),
      ),
    );
  }

  warehouseSelect() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              children: warehouse.rows!
                  .map(
                    (e) => InkWell(
                      onTap: warehouseName != e.name
                          ? () async {
                              setState(() {
                                warehouseName = e.name;
                                warehouseId = e.id;
                                isLoading = true;
                                selectedVariant = InventoryGoods();
                              });
                              Navigator.of(context).pop();
                              variants =
                                  await InventoryApi().variantSelect(e.id);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          : () {
                              Navigator.of(context).pop();
                            },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  movementTypeSelect() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              children: general.stockMovementTypes!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          movementType = e.name;
                          movementTypeId = e.code;
                          movementValidate = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  noteSelect() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              children: adjustmentNote.rows!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          noteName = e.name;
                          noteId = e.id;
                          noteValidate = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
