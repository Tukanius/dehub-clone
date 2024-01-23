import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/set_price/sheets/quantity_sheet.dart';
import 'package:dehub/src/product_module/screens/set_price/sheets/set_price_sheet.dart';
import 'package:dehub/src/product_module/screens/set_price/sheets/tax_sheet.dart';
import 'package:dehub/src/product_module/screens/set_price/sheets/vat_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SetPriceArguments {
  InventoryGoods data;
  ListenController listenController;
  SetPriceArguments({
    required this.data,
    required this.listenController,
  });
}

class SetPrice extends StatefulWidget {
  static const routeName = '/SetPrice';
  final InventoryGoods data;
  final ListenController listenController;
  const SetPrice({
    super.key,
    required this.listenController,
    required this.data,
  });

  @override
  State<SetPrice> createState() => _SetPriceState();
}

class _SetPriceState extends State<SetPrice> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  General general = General();
  List<InventoryGoods> tiers = [];
  bool isLoading = true;
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) async {
    await Provider.of<GeneralProvider>(context, listen: false)
        .inventoryInit(false);
    Provider.of<InventoryProvider>(context, listen: false).clearData();
    tiers = general.tiers!.where((element) => element.isSet == true).toList();
    setState(() {
      isLoading = false;
    });
  }

  onSubmit(bool confirm) async {
    final res = Provider.of<InventoryProvider>(context, listen: false);
    List<InventoryGoods> tierPrices = [];
    List<InventoryGoods> quantityPrices = [];
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        data.variantId = widget.data.variantId;
        data.vatType = res.product.vatType;
        if (res.product.vatType == "STANDARD_RATED") {
          data.vatPercent = res.product.vatValue?.toInt();
        }
        data.currency = "MNT";
        data.hasTax = res.product.hasTax ?? false;
        if (data.hasTax == true) {
          data.taxPercent = res.product.taxPercent;
        }
        for (var i = 0; i < tiers.length; i++) {
          tierPrices.add(
            InventoryGoods(
              tierNo: tiers[i].tierNo,
              price: tiers[i].customPrice,
              startDate: tiers[i].startDate,
              endDate: tiers[i].endDate,
            ),
          );
        }
        data.tierPrices = tierPrices;
        if (res.product.quantityPrices!.isNotEmpty &&
            res.product.quantityPrices != null) {
          for (var i = 0; i < res.product.quantityPrices!.length; i++) {
            quantityPrices.add(
              InventoryGoods(
                minQuantity: res.product.quantityPrices?[i].minQuantity,
                hasMaxLimit: res.product.quantityPrices?[i].hasMaxLimit,
                maxQuantity: res.product.quantityPrices?[i].maxQuantity,
                salesPrice: res.product.quantityPrices?[i].salesPrice,
                startDate: res.product.quantityPrices?[i].startDate,
                endDate: res.product.quantityPrices?[i].endDate,
              ),
            );
          }
        }
        data.confirm = confirm;
        data.quantityPrices = quantityPrices;
        await InventoryApi().price(data);
        widget.listenController.changeVariable('setPrice');
        showCustomDialog(
          context,
          'Амжилттай үнэ тохирууллаа',
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

  vatType() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    final res = general.vatTypes!
        .firstWhere((element) => element.code == source.product.vatType)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: white,
        elevation: 0,
        backgroundColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Барааны үнэ тохиргоо',
          style: TextStyle(color: productColor, fontSize: 16),
        ),
      ),
      body: isLoading == true
          ? const SizedBox()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Ерөнхий мэдээлэл",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    Container(
                      color: white,
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: grey,
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      color: grey,
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${widget.data.image}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Нэр: "),
                                      Text(
                                        '${widget.data.nameMon}',
                                        style: const TextStyle(
                                            color: productColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("DeHUB код: "),
                                      Text(
                                        '${widget.data.refCode}',
                                        style: const TextStyle(
                                            color: productColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("SKU код: "),
                                      Text(
                                        '${widget.data.skuCode}',
                                        style: const TextStyle(
                                            color: productColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Bar код: "),
                                      Text(
                                        '${widget.data.barCode}',
                                        style: const TextStyle(
                                            color: productColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const FieldCard(
                            paddingHorizontal: 0,
                            paddingVertical: 10,
                            labelText: 'Үнэ тохируулах тоо',
                            secondText: '1',
                            secondTextColor: grey2,
                            secondTextFontWeight: FontWeight.w600,
                          ),
                          const FieldCard(
                            paddingHorizontal: 0,
                            paddingVertical: 10,
                            labelText: 'Үндсэн нэгж',
                            secondText: 'ширхэг',
                            secondTextColor: grey2,
                          ),
                          const FieldCard(
                            paddingHorizontal: 0,
                            paddingVertical: 10,
                            labelText: 'Үнэ тооцох валют',
                            secondText: 'төгрөг',
                            secondTextColor: grey2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Татварын төрөл",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 10,
                      color: white,
                      labelText: 'НӨАТ-тай эсэх',
                      secondText:
                          source.product.vatType != null ? vatType() : "Сонгох",
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          builder: (context) => VatSheet(
                            data: InventoryGoods(
                              vatPercent: source.product.vatValue?.toInt(),
                              vatType: source.product.vatType,
                            ),
                          ),
                        );
                      },
                      arrowColor: productColor,
                      secondTextColor: productColor,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 10,
                      color: white,
                      labelText: 'НХАТ-тэй эсэх',
                      secondText:
                          source.product.hasTax == true ? "Тийм" : "Үгүй",
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          builder: (context) => const TaxSheet(),
                        );
                      },
                      arrowColor: productColor,
                      secondTextColor: productColor,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Борлуулах нэгж стандарт үнэ",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    FormBuilder(
                      key: fbKey,
                      child: FormTextField(
                        inputType: TextInputType.number,
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'standardPrice',
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
                                'Үнэ (НӨАТ-гүй)',
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Үнийн бүлэг",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Үнийн бүлэг нэмсний дараа энэ жагсаалтад орж ирэхийг анхаарна уу. ",
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Column(
                      children: tiers
                          .map(
                            (data) => FieldCard(
                              color: white,
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: '${data.name}',
                              secondText: data.customPrice == null
                                  ? "Тохируулаагүй"
                                  : 'Тохируулсан',
                              onClick: () {
                                if (fbKey.currentState!.saveAndValidate()) {
                                  showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => SetPriceSheet(
                                      data: data,
                                    ),
                                  );
                                }
                              },
                              arrowColor: productColor,
                              secondTextColor: productColor,
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Тооноос хамаарах үнэ",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    if (source.product.quantityPrices!.isNotEmpty &&
                        source.product.quantityPrices != null)
                      Column(
                        children: source.product.quantityPrices!
                            .map(
                              (data) => FieldCard(
                                paddingHorizontal: 15,
                                paddingVertical: 10,
                                labelText: 'Тооны бүлэг',
                                color: white,
                                secondText: data.hasMaxLimit != false
                                    ? "${data.minQuantity} - ${data.maxQuantity}"
                                    : "> ${data.minQuantity}",
                                secondTextColor: productColor,
                                onClick: () {
                                  showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => QuantitySheet(
                                      data: data,
                                    ),
                                  );
                                },
                                arrowColor: productColor,
                              ),
                            )
                            .toList(),
                      ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: const Text(
                        "Тооноос хамаарах үнийг энд тохируулна уу.",
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    CustomButton(
                      onClick: () {
                        if (fbKey.currentState!.saveAndValidate()) {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            builder: (context) => const QuantitySheet(),
                          );
                        }
                      },
                      labelColor: const Color(0xffE9E9EA),
                      borderColor: grey2.withOpacity(0.5),
                      textColor: productColor,
                      labelText: 'Тооны интервал нэмэх',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: const Text(
                        "Нэмэлт хэмжих нэгж",
                        style: TextStyle(color: productColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        "Таны сонгосон бараанд нэмэлт хэмжих нэгж байхгүй байна",
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
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
                              int index = tiers.indexWhere(
                                  (element) => element.customPrice == null);
                              if (index > -1) {
                                customScaffoldMessenger(
                                  context,
                                  color: productColor,
                                  labelText:
                                      'Борлуулах нэгжийн стандарт үнэ тохируулна уу',
                                );
                              } else {
                                onSubmit(false);
                              }
                            },
                            borderColor: productColor,
                            labelColor: white,
                            labelText: "Хадгалах",
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
                              int index = tiers.indexWhere(
                                  (element) => element.customPrice == null);
                              if (index > -1) {
                                customScaffoldMessenger(
                                  context,
                                  color: productColor,
                                  labelText:
                                      'Борлуулах нэгжийн стандарт үнэ тохируулна уу',
                                );
                              } else {
                                onSubmit(true);
                              }
                            },
                            labelColor: productColor,
                            labelText: "Батлах",
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
            ),
    );
  }
}
