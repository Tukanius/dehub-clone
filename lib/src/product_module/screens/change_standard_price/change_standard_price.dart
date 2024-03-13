import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/product_module/screens/change_standard_price/components/select_variant_sheet.dart';
import 'package:dehub/src/product_module/components/standard_price_card/standard_price_card.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ChangeStandardPriceArguments {
  String type;
  ChangeStandardPriceArguments({
    required this.type,
  });
}

class ChangeStandardPrice extends StatefulWidget {
  static const routeName = '/ChangeStandardPrice';
  final String type;
  const ChangeStandardPrice({
    super.key,
    required this.type,
  });

  @override
  State<ChangeStandardPrice> createState() => _ChangeStandardPriceState();
}

class _ChangeStandardPriceState extends State<ChangeStandardPrice>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  TextEditingController controller = TextEditingController();
  ListenController listenController = ListenController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  Result variants = Result(count: 0, rows: []);
  List<InventoryGoods> selectedVariants = [];
  General general = General();
  bool isLoading = true;
  String perType = "PERCENTAGE";
  String priceType = "DECREASE";

  @override
  afterFirstLayout(BuildContext context) async {
    variants = await InventoryApi().priceGroupVariant(widget.type);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  onSubmit(bool confirm) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    List<InventoryGoods> variant = [];
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        data.type = widget.type;
        data.startDate = startDate.toString();
        data.endDate = endDate.toString();
        for (var i = 0; i < selectedVariants.length; i++) {
          variant.add(
            InventoryGoods(
              variantId: selectedVariants[i].id,
              standardPrice: selectedVariants[i].standardPrice,
              tier1Price: selectedVariants[i].tier1Price,
              tier2Price: selectedVariants[i].tier2Price,
              tier3Price: selectedVariants[i].tier3Price,
              tier4Price: selectedVariants[i].tier4Price,
              tier5Price: selectedVariants[i].tier5Price,
              tier6Price: selectedVariants[i].tier6Price,
              tier7Price: selectedVariants[i].tier7Price,
              tier8Price: selectedVariants[i].tier8Price,
              tier9Price: selectedVariants[i].tier9Price,
            ),
          );
        }
        data.variants = variant;
        data.confirm = confirm;
        if (widget.type == "SPECIAL") {
          data.perType = perType;
          data.changeType = priceType;
          data.perValue = double.parse(controller.text);
        }
        await InventoryApi().createPriceGroup(data);
        loading.loading(false);
        showCustomDialog(context, "Амжилттай үнэ өөрчиллөө", true,
            onPressed: () {
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: productColor),
          backgroundColor: white,
          surfaceTintColor: white,
          title: Text(
            widget.type == "GROUP"
                ? "Стандарт үнэ өөрчлөх"
                : "Тусгай үнийн жагсаалт нэмэх",
            style: const TextStyle(
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
                child: FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Ерөнхий мэдээлэл",
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Үнийн код',
                        secondText: 'Авто үүснэ',
                        secondTextColor: productColor,
                        color: white,
                        secondTextFontWeight: FontWeight.w500,
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: "name",
                        decoration: const InputDecoration(
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(color: productColor),
                          fillColor: white,
                          filled: true,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Нэр'),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна'),
                        ]),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: "description",
                        decoration: const InputDecoration(
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(color: productColor),
                          fillColor: white,
                          filled: true,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text('Тайлбар'),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна'),
                        ]),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Барааны тоо',
                        secondText: '${selectedVariants.length}',
                        secondTextColor: productColor,
                        color: white,
                      ),
                      if (widget.type == "SPECIAL")
                        Column(
                          children: [
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Өөрчлөлт төрөл',
                              secondText:
                                  perType == "AMOUNT" ? "Үнийн дүн" : "Хувь",
                              secondTextColor: productColor,
                              color: white,
                              arrowColor: productColor,
                              onClick: () {
                                selectType();
                              },
                            ),
                            FormTextField(
                              textColor: productColor,
                              textAlign: TextAlign.end,
                              name: "pervalue",
                              controller: controller,
                              onChanged: (p0) {
                                setState(() {});
                              },
                              inputType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Энд оруулна уу',
                                hintStyle: TextStyle(color: productColor),
                                fillColor: white,
                                filled: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Өөрчлөлт дүн'),
                                  ],
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Заавал оруулна'),
                              ]),
                            ),
                            FieldCard(
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Өөрчлөлт хийх арга',
                              secondText: priceType == "DECREASE"
                                  ? "Бууруулах"
                                  : "Өсгөх",
                              secondTextColor: productColor,
                              color: white,
                              arrowColor: productColor,
                              onClick: () {
                                priceChangeType();
                              },
                            ),
                          ],
                        ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Эхлэх огноо',
                        secondText: DateFormat('yyyy-MM-dd').format(startDate),
                        secondTextColor: productColor,
                        color: white,
                        arrowColor: productColor,
                        onClick: () {
                          changeStartDate();
                        },
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Дуусах огноо',
                        secondText: DateFormat('yyyy-MM-dd').format(endDate),
                        secondTextColor: productColor,
                        color: white,
                        arrowColor: productColor,
                        onClick: () {
                          changeEndDate();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Үнэ өөрчлөх бараа сонгоно уу",
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Бараа сонгох',
                        secondText: '',
                        secondTextColor: productColor,
                        color: white,
                        arrowColor: productColor,
                        onClick: () {
                          selectVariant();
                        },
                      ),
                      Column(
                        children: selectedVariants
                            .map(
                              (data) => StandardPriceCard(
                                isSelected: true,
                                data: data,
                                perType: perType,
                                perValue: controller.text,
                                onClick: () {
                                  setState(() {
                                    variants.rows?.add(data);
                                    selectedVariants.remove(data);
                                  });
                                },
                              ),
                            )
                            .toList(),
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
                              onClick: () {
                                onSubmit(false);
                              },
                              borderColor: productColor,
                              labelColor: backgroundColor,
                              textColor: productColor,
                              labelText: 'Хадгалах',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomButton(
                              onClick: () {
                                onSubmit(true);
                              },
                              labelColor: productColor,
                              labelText: 'Хадгалах',
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
              ),
      ),
    );
  }

  selectType() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.perTypes!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          perType = e.code.toString();
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: MediaQuery.of(context).size.width,
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

  priceChangeType() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.priceChangeTypes!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          priceType = e.code.toString();
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: MediaQuery.of(context).size.width,
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

  selectVariant() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SelectVariantSheet(
        listenController: listenController,
        selectedVariants: selectedVariants,
        variants: variants,
      ),
    );
  }

  changeStartDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(DateTime.now())),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      startDate = newDate;
                    });
                    if (startDate.difference(endDate).inDays > 0) {
                      setState(() {
                        endDate = startDate;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  changeEndDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime:
                      DateTime.parse(DateFormat('yyyy-MM-dd').format(endDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      endDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
