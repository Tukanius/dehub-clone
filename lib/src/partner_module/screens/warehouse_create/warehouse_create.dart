import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/sheets/buyer_select.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/sheets/supplier_select.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class WarehouseCreateArguments {
  Partner? data;
  ListenController listenController;
  WarehouseCreateArguments({
    this.data,
    required this.listenController,
  });
}

class WarehouseCreate extends StatefulWidget {
  static const routeName = '/WarehouseCreate';
  final Partner? data;
  final ListenController listenController;
  const WarehouseCreate({
    super.key,
    required this.listenController,
    this.data,
  });

  @override
  State<WarehouseCreate> createState() => _WarehouseCreateState();
}

class _WarehouseCreateState extends State<WarehouseCreate>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  List<bool> values = [false, true];
  int? supplierRadioValue = 0;
  int? buyerRadioValue = 0;
  bool isDefault = false;
  bool isLoading = true;
  bool isSubmit = false;
  General general = General();
  Result buyers = Result(rows: []);
  Result suppliers = Result(rows: []);
  List<Partner> selectedBuyers = [];
  List<Partner> selectedSuppliers = [];
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;

  buyerRadio(int value) {
    setState(() {
      buyerRadioValue = value;
    });
  }

  supplierRadio(int value) {
    setState(() {
      supplierRadioValue = value;
    });
  }

  onSubmit() async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    List<String> buyerIds = [];
    List<String> supplierIds = [];
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        Partner data = Partner.fromJson(fbkey.currentState!.value);
        data.district = districtId;
        data.province = provinceId;
        data.isDefault = isDefault;
        data.isBuyer = buyerRadioValue == 1 ? true : false;
        if (buyerRadioValue == 1) {
          for (var i = 0; i < source.buyers.length; i++) {
            buyerIds.add(source.buyers[i].id!);
          }
          data.buyerIds = buyerIds;
        }
        data.isSupplier = supplierRadioValue == 1 ? true : false;
        if (supplierRadioValue == 1) {
          for (var i = 0; i < source.suppliers.length; i++) {
            supplierIds.add(source.suppliers[i].id!);
          }
          data.supplierIds = supplierIds;
        }
        data.warehouseStatus = source.partner.warehouseStatus;
        data.warehouseUserId = source.partner.warehouseUserId;
        if (source.partner.warehouseStatus != null &&
            districtId != null &&
            provinceId != null &&
            source.partner.warehouseUserId != null) {
          if (widget.data != null) {
            await PartnerApi().warehouseUpdate(data, widget.data!.id!);
          } else {
            await PartnerApi().warehouseCreate(data);
          }
          widget.listenController.changeVariable('warehouse');
          showCustomDialog(context, "Амжилттай", true, onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          showCustomDialog(context, "Мэдээлэл бүрэн бөглөнө үү", false);
        }
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

  status() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.warehouseStatus != null) {
      final res = general.warehouseStatus!
          .firstWhere(
              (element) => element.code == source.partner.warehouseStatus)
          .name;
      return res;
    } else {
      return null;
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    source.clearData();
    buyers = await PartnerApi().businessSelect("BUYER");
    suppliers = await PartnerApi().businessSelect("SUPPLIER");
    if (widget.data != null) {
      if (widget.data!.isBuyer == true) {
        for (var i = 0; i < widget.data!.buyers!.length; i++) {
          Partner buyers = this.buyers.rows!.firstWhere(
              (element) => element.id == widget.data!.buyers![i].id);
          source.selectBuyer(buyers);
        }
      }
      if (widget.data!.isSupplier == true) {
        for (var i = 0; i < widget.data!.suppliers!.length; i++) {
          Partner suppliers = this.suppliers.rows!.firstWhere(
              (element) => element.id == widget.data!.suppliers![i].id);
          source.selectSupplier(suppliers);
        }
      }
      isDefault = widget.data!.isDefault!;
      buyerRadioValue = widget.data!.isBuyer == true ? 1 : 0;
      supplierRadioValue = widget.data!.isSupplier == true ? 1 : 0;
      source.warehouseStatus(widget.data!.warehouseStatus!);
      districtId = widget.data!.district;
      source.partnerStaff(widget.data!.warehouseUserId!);
    }
    setState(() {
      isLoading = false;
    });
  }

  district() {
    if (districtId != null) {
      final res =
          general.zipCodes!.firstWhere((element) => element.code == districtId);
      return res.name;
    } else {
      return null;
    }
  }

  partnerStaff() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.warehouseUserId != null) {
      final res = general.partnerStaffs!.firstWhere(
          (element) => element.id == source.partner.warehouseUserId);
      return '${res.lastName?[0]}. ${res.firstName}';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: partnerColor),
        title: const Text(
          'Агуулах нэмэх',
          style: TextStyle(
            color: partnerColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: partnerColor,
              ),
            )
          : SingleChildScrollView(
              child: FormBuilder(
                key: fbkey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Row(
                              children: [
                                Text(
                                  'Үндсэн мэдээлэл',
                                  style: TextStyle(
                                    color: grey2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: grey3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Агуулахын нэр',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          FormTextField(
                            textColor: black,
                            name: 'name',
                            initialValue: widget.data?.name ?? '',
                            decoration: InputDecoration(
                              hintText: 'Агуулахын нэр',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: grey2.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: grey2.withOpacity(0.3),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              isDense: true,
                              fillColor: backgroundColor,
                              filled: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна'),
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Аймаг хот',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          selection(
                            hintText: 'Аймаг хот',
                            onClick: () {
                              selectProvince();
                            },
                            value: provinceName,
                            selected: false,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Сум, дүүрэг',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          selection(
                            hintText: 'Сум, дүүрэг',
                            value: district(),
                            onClick: () {
                              selectDistrict();
                            },
                            selected: false,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Хариуцсан ажилтан',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          selection(
                            hintText: 'Хариуцсан ажилтан',
                            onClick: () {
                              selectPartnerStaff();
                            },
                            value: partnerStaff(),
                            selected: false,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Утасны дугаар',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          FormTextField(
                            textColor: black,
                            name: 'phone',
                            initialValue: widget.data?.phone ?? '',
                            decoration: InputDecoration(
                              hintText: 'Утасны дугаар',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: grey2.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: grey2.withOpacity(0.3),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              isDense: true,
                              fillColor: backgroundColor,
                              filled: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна'),
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Төлөв',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          selection(
                            hintText: 'Төлөв',
                            onClick: () {
                              selectWarehouseStatus();
                            },
                            selected: false,
                            value: status(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('Үндсэн эсэх'),
                        const SizedBox(
                          width: 5,
                        ),
                        Platform.isIOS
                            ? CupertinoSwitch(
                                value: isDefault,
                                activeColor: partnerColor,
                                onChanged: (value) {
                                  setState(() {
                                    isDefault = value;
                                  });
                                },
                              )
                            : Switch(
                                value: isDefault,
                                activeColor: partnerColor,
                                thumbColor:
                                    const MaterialStatePropertyAll(white),
                                onChanged: (value) {
                                  setState(() {
                                    isDefault = value;
                                  });
                                },
                              ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: const Row(
                        children: [
                          Text(
                            'Агуулахын тохиргоо',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: grey3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DeHUB Network-р Buyer тохиргоо',
                            style: TextStyle(
                              color: grey3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Салбарт худалдан авалт хийх эсэх',
                            style: TextStyle(
                              color: grey3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: values
                          .map(
                            (e) => Expanded(
                              child: RadioListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                title: Text(
                                  e == true ? 'Тийм' : "Үгүй",
                                  style: const TextStyle(
                                      color: dark, fontSize: 14),
                                ),
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => partnerColor),
                                value: values.indexOf(e),
                                groupValue: buyerRadioValue,
                                onChanged: (value) {
                                  buyerRadio(value!);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    if (buyerRadioValue == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: selection(
                          hintText: 'Buyer бизнес Ref#',
                          onClick: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BuyerSelect(
                                buyers: buyers.rows!,
                              ),
                            );
                          },
                          selected: false,
                        ),
                      ),
                    if (buyerRadioValue == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: source.buyers
                              .map(
                                (e) => selection(
                                  hintText: '',
                                  value: '${e.refCode} / ${e.profileName}',
                                  onClick: () {
                                    setState(() {
                                      source.buyers.removeWhere((element) =>
                                          element.refCode == e.refCode);
                                      buyers.rows?.add(e);
                                    });
                                  },
                                  selected: true,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DeHUB Network-р Supplier тохиргоо',
                            style: TextStyle(
                              color: grey3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Салбарт худалдан авалт хийх эсэх',
                            style: TextStyle(
                              color: grey3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: values
                          .map(
                            (e) => Expanded(
                              child: RadioListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                title: Text(
                                  e == true ? 'Тийм' : "Үгүй",
                                  style: const TextStyle(
                                      color: dark, fontSize: 14),
                                ),
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => partnerColor),
                                value: values.indexOf(e),
                                groupValue: supplierRadioValue,
                                onChanged: (value) {
                                  supplierRadio(value!);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    if (supplierRadioValue == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: selection(
                          hintText: 'Supplier бизнес Ref#',
                          onClick: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SupplierSelect(
                                suppliers: suppliers.rows!,
                              ),
                            );
                          },
                          selected: false,
                        ),
                      ),
                    if (supplierRadioValue == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: source.suppliers
                              .map(
                                (e) => selection(
                                  hintText: '',
                                  value: '${e.refCode} / ${e.profileName}',
                                  onClick: () {
                                    setState(() {
                                      source.suppliers.removeWhere((element) =>
                                          element.refCode == e.refCode);
                                      suppliers.rows?.add(e);
                                    });
                                  },
                                  selected: true,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      isLoading: isSubmit,
                      onClick: onSubmit,
                      labelText: 'Хадгалах',
                      labelColor: partnerColor,
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

  Widget selection(
      {String? value,
      required String hintText,
      required Function() onClick,
      required bool selected}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor,
          border: Border.all(
            color: grey2.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hintText,
              style: const TextStyle(color: grey2),
            ),
            Icon(
              selected == false
                  ? Icons.arrow_forward_ios
                  : Icons.remove_circle_outline_sharp,
              color: grey3,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  selectProvince() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.zipCodes!
                  .where((element) => element.parent == '0')
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          provinceId = e.code;
                          provinceName = e.name;
                          districtId = null;
                          districtName = null;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text("${e.name}"),
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

  selectDistrict() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.zipCodes!
                  .where((element) => element.parent == provinceId)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          districtId = e.code;
                          districtName = e.name;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text("${e.name}"),
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

  selectWarehouseStatus() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.warehouseStatus!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        source.warehouseStatus(e.code!);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text("${e.name}"),
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

  selectPartnerStaff() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: backgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: general.partnerStaffs!
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        source.partnerStaff(e.id!);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text("${e.lastName?[0]}. ${e.firstName}"),
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
