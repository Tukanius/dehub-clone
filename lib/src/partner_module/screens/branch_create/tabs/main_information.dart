import 'dart:io';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/sheets/buyer_select.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/sheets/select_branch_type.dart';
import 'package:dehub/src/partner_module/screens/branch_create/tabs/sheets/supplier_select.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../components/picture_form.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:after_layout/after_layout.dart';

class MainInformation extends StatefulWidget {
  final TabController tabController;
  final Partner? data;
  final ListenController listenController;
  const MainInformation({
    super.key,
    this.data,
    required this.listenController,
    required this.tabController,
  });

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? warehouseType;
  int? supplierRadioValue;
  int? buyerRadioValue;
  bool isDefault = false;
  bool isLoading = true;
  General general = General();
  Result buyers = Result(rows: []);
  Result suppliers = Result(rows: []);
  List<bool> values = [false, true];
  List<Partner> selectedBuyers = [];
  List<Partner> selectedSuppliers = [];

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
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    List<String> buyers = [];
    List<String> suppliers = [];
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        Partner data = Partner.fromJson(fbKey.currentState!.value);
        data.type = source.partner.type;
        data.profileBanners = source.partner.profileBanners;
        data.logo = source.partner.logo;
        data.isDefault = isDefault;
        data.isBuyer = buyerRadioValue == 1 ? true : false;
        if (buyerRadioValue == 1) {
          for (var i = 0; i < source.buyers.length; i++) {
            buyers.add(source.buyers[i].id!);
          }
          data.buyerIds = buyers;
        }
        data.isSupplier = supplierRadioValue == 1 ? true : false;
        if (supplierRadioValue == 1) {
          for (var i = 0; i < source.suppliers.length; i++) {
            suppliers.add(source.suppliers[i].id!);
          }
          data.supplierIds = suppliers;
        }
        if (supplierRadioValue == 1 && source.suppliers.isEmpty ||
            buyerRadioValue == 1 && source.buyers.isEmpty) {
          showCustomDialog(
            context,
            'Бизнес сонгоно уу',
            false,
          );
        } else if (source.partner.type == null) {
          showCustomDialog(
            context,
            'Салбарын төрөл сонгоно уу',
            false,
          );
        } else if (source.partner.profileBanners!.length > 5) {
          showCustomDialog(
            context,
            '5 болон түүнээс доош зураг оруулах боломжтой',
            false,
          );
        } else {
          if (widget.data != null) {
            loading.loading(true);
            await source.branchUpdate(data, widget.data!.id!);
            loading.loading(false);
          } else {
            loading.loading(true);
            await source.branchCreate(data);
            loading.loading(false);
          }
          widget.listenController.changeVariable('branch');
          setState(() {
            widget.tabController.index = 1;
          });
        }
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  dynamic branchType() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.type != null) {
      final res = general.branchTypes!
          .firstWhere((element) => element.code == source.partner.type)
          .name;
      return res;
    } else {
      return null;
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    buyers = await PartnerApi().businessSelect("BUYER");
    suppliers = await PartnerApi().businessSelect("SUPPLIER");
    if (widget.data != null) {
      source.branchType(widget.data!.type!);
      if (widget.data!.logo != null) {
        source.profileImage(widget.data!.logo!);
      }
      if (widget.data!.profileBanners != null) {
        for (var i = 0; i < widget.data!.profileBanners!.length; i++) {
          source.bannerImages(
            Partner(
              url: widget.data!.profileBanners![i].url,
              isMain: widget.data!.profileBanners![i].isMain,
            ),
          );
        }
      }
      isDefault = widget.data!.isDefault!;
      buyerRadioValue = widget.data!.isBuyer == true ? 1 : 0;
      supplierRadioValue = widget.data!.isSupplier == true ? 1 : 0;
      if (widget.data!.isBuyer == true) {
        for (var i = 0; i < widget.data!.buyers!.length; i++) {
          Partner buyer = buyers.rows!.firstWhere(
              (element) => element.id == widget.data!.buyers![i].id);
          buyers.rows?.removeWhere(
              (element) => element.id == widget.data!.buyers![i].id);
          source.selectBuyer(buyer);
        }
      }
      if (widget.data!.isSupplier == true) {
        for (var i = 0; i < widget.data!.suppliers!.length; i++) {
          Partner supplier = suppliers.rows!.firstWhere(
              (element) => element.id == widget.data!.suppliers![i].id);
          suppliers.rows?.removeWhere(
              (element) => element.id == widget.data!.suppliers![i].id);
          source.selectSupplier(supplier);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: partnerColor,
            ),
          )
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Салбарын нэр',
                              style: TextStyle(
                                color: grey3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          FormTextField(
                            textColor: grey2,
                            name: 'name',
                            initialValue: widget.data?.name ?? '',
                            decoration: InputDecoration(
                              hintText: 'Салбарийн нэр оруулна уу',
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
                              (value) => validateCryllic(
                                    value.toString(),
                                    context,
                                  ),
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text(
                              'Салбарын нэр/Latin, English/',
                              style: TextStyle(
                                color: grey3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          FormTextField(
                            textColor: grey2,
                            name: 'nameEng',
                            initialValue: widget.data?.nameEng ?? '',
                            decoration: InputDecoration(
                              hintText: 'Салбарын нэр/Latin, English/',
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
                              (value) =>
                                  englishValidate(value.toString(), context),
                            ]),
                          ),
                          SelectionField(
                            hintText: 'Салбарын төрөл',
                            labelText: 'Салбарын төрөл',
                            backgroundColor: backgroundColor,
                            value: branchType(),
                            onClick: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const SelectBranchType(),
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Профайлд гарах баннер зураг',
                              style: TextStyle(
                                color: grey3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const PartnerPictureForm(),
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
                      labelColor: white,
                      borderColor: partnerColor,
                      labelText: 'Үргэлжлүүлэх',
                      textColor: partnerColor,
                      onClick: onSubmit,
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
}

String? validateCryllic(String name, BuildContext context) {
  String pattern = r'(^[а-яА-ЯӨөҮүЁёӨө -]+$)';
  RegExp isValidName = RegExp(pattern);
  if (name.isEmpty) {
    return "Заавал оруулна";
  } else {
    if (!isValidName.hasMatch(name)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}

String? englishValidate(String name, BuildContext context) {
  String pattern = r'^[a-zA-Z -]+$';
  RegExp isValidName = RegExp(pattern);
  if (name.isEmpty) {
    return "Заавал оруулна";
  } else {
    if (!isValidName.hasMatch(name)) {
      return "Зөвхөн англи үсэг ашиглана";
    } else {
      return null;
    }
  }
}
