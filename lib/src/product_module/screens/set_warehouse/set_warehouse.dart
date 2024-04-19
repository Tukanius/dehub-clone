import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/components/recourse_info_form.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/sheets/merch_staff_sheet.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/sheets/variant_suppliers.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/sheets/warehouse_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SetWarehouseArguments {
  InventoryGoods data;
  ListenController listenController;
  SetWarehouseArguments({
    required this.listenController,
    required this.data,
  });
}

class SetWarehouse extends StatefulWidget {
  static const routeName = '/SetWareHouse';
  final ListenController listenController;
  final InventoryGoods data;
  const SetWarehouse({
    super.key,
    required this.listenController,
    required this.data,
  });

  @override
  State<SetWarehouse> createState() => _SetWarehouseState();
}

class _SetWarehouseState extends State<SetWarehouse> with AfterLayoutMixin {
  bool isLoading = true;
  DateTime startDate = DateTime.now();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  General general = General();

  onSubmit(bool confirm) async {
    final res = Provider.of<InventoryProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    List<InventoryGoods> variantSuppliers = [];
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        data.variantId = widget.data.variantId;
        data.confirm = confirm;
        data.warehouseId = res.product.warehouse?.id;
        data.quantityStartDate = startDate.toString();
        data.merchStaffId = res.product.merchStaff?.id;
        data.variantSuppliers = res.product.variantSuppliers;
        if (res.product.variantSuppliers!.isNotEmpty &&
            res.product.variantSuppliers != null) {
          for (var i = 0; i < res.product.variantSuppliers!.length; i++) {
            variantSuppliers.add(
              InventoryGoods(
                buyerBusinessId:
                    res.product.variantSuppliers?[i].buyerBusinessId,
                supplierBusinessId:
                    res.product.variantSuppliers?[i].supplierBusinessId,
                merchStaffId: res.product.variantSuppliers?[i].merchStaffId,
                isDefault: res.product.variantSuppliers?[i].isDefault,
                isDropshipping: res.product.variantSuppliers?[i].isDropshipping,
                backorderable: res.product.variantSuppliers?[i].backorderable,
              ),
            );
          }
        }
        data.variantSuppliers = variantSuppliers;
        await InventoryApi().setWarehouse(data);
        loading.loading(false);
        widget.listenController.changeVariable('setWarehouse');
        showCustomDialog(context, 'Амжилттай үлдэгдэл тохирууллаа', true,
            onPressed: () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  afterFirstLayout(BuildContext context) {
    Provider.of<InventoryProvider>(context, listen: false).clearData();
    setState(() {
      isLoading = false;
    });
  }

  supplierType() {
    final res = general.supplierTypes!
        .firstWhere((element) => element.code == widget.data.supplierType)
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
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          "Эхний үлдэгдэл тохируулах",
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Нэр: "),
                                          Expanded(
                                            child: Text(
                                              '${widget.data.nameMon}',
                                              style: const TextStyle(
                                                  color: productColor),
                                            ),
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
                          "Нийлүүлэгч",
                          style: TextStyle(color: productColor),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Төрөл',
                        secondText: widget.data.supplierType != null
                            ? '${supplierType()}'
                            : '-',
                        secondTextColor: grey3,
                        color: white,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Агуулах",
                          style: TextStyle(color: productColor),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Агуулах нэр',
                        secondText: source.product.warehouse?.name ?? 'Сонгох',
                        secondTextColor: productColor,
                        color: white,
                        onClick: () {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            builder: (context) => const WarehouseSheet(),
                          );
                        },
                        arrowColor: productColor,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Хариуцсан нярав',
                        secondText: source
                                .product.warehouse?.warehouseUser?.firstName ??
                            "Авто гарах",
                        secondTextColor: productColor,
                        color: white,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Системд эхлэх мэдээлэл",
                          style: TextStyle(color: productColor),
                        ),
                      ),
                      FormTextField(
                        inputType: TextInputType.number,
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'warehouseQuantity',
                        onChanged: (value) {},
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
                                'Эхний үлдэгдэл тоо',
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
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: white,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
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
                                        minimumDate: DateTime.now(),
                                        initialDateTime: startDate
                                            .add(const Duration(minutes: 10)),
                                        mode: CupertinoDatePickerMode.date,
                                        use24hFormat: true,
                                        showDayOfWeek: true,
                                        onDateTimeChanged: (DateTime newDate) {
                                          setState(() {
                                            startDate = newDate;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          color: white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Эхлэх огноо'),
                              Row(
                                children: [
                                  Text(
                                    DateFormat("yyyy-MM-dd").format(startDate),
                                    style: const TextStyle(color: productColor),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/dot-calendar.svg',
                                    colorFilter: const ColorFilter.mode(
                                        productColor, BlendMode.srcIn),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Нөөц хянах мэдээлэл",
                          style: TextStyle(color: productColor),
                        ),
                      ),
                      const RecourseInfoForm(),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Мерчандайз",
                          style: TextStyle(color: productColor),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Хариуцсан ажилтан',
                        secondText: 'Сонгох',
                        secondTextColor: productColor,
                        color: white,
                        onClick: () {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            builder: (context) => const MerchStaffSheet(),
                          );
                        },
                        arrowColor: productColor,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Нэр',
                        secondText:
                            source.product.merchStaff?.firstName ?? 'Нэр',
                        secondTextColor: productColor,
                        color: white,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'Утас',
                        secondText: source.product.merchStaff?.phone ?? 'Утас',
                        secondTextColor: productColor,
                        color: white,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: 'И-мэйл',
                        secondText:
                            source.product.merchStaff?.email ?? 'И-мэйл',
                        secondTextColor: productColor,
                        color: white,
                      ),
                      if (widget.data.supplierType == "RESELLER")
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Татан авалтын мэдээлэл',
                            style: TextStyle(color: productColor),
                          ),
                        ),
                      if (source.product.variantSuppliers!.isNotEmpty &&
                          source.product.variantSuppliers != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            children: source.product.variantSuppliers!
                                .map(
                                  (data) => GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        useSafeArea: true,
                                        builder: (context) =>
                                            VariantSuppliersSheet(
                                          data: data,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data.supplierName}',
                                                style: const TextStyle(
                                                    color: productColor),
                                              ),
                                              Text(
                                                '${data.partnerName}',
                                                style: const TextStyle(
                                                  color: grey2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: productColor,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      if (widget.data.supplierType == "RESELLER")
                        CustomButton(
                          onClick: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              builder: (context) =>
                                  const VariantSuppliersSheet(),
                            );
                          },
                          borderColor: grey2.withOpacity(0.5),
                          labelColor: const Color(0xffE9E9EA),
                          labelText: 'Мэдээлэл нэмэх',
                          textColor: productColor,
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
                              onClick: () {
                                onSubmit(false);
                              },
                              labelColor: white,
                              labelText: 'Хадгалах',
                              borderColor: productColor,
                              textColor: productColor,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CustomButton(
                              onClick: () {
                                onSubmit(true);
                              },
                              labelColor: productColor,
                              labelText: "Батлах",
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
}
