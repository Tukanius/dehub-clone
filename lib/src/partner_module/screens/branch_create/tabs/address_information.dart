import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/district_sheet.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/khoroo_sheet.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/province_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AddressInformation extends StatefulWidget {
  final Partner? data;
  final ListenController listenController;
  const AddressInformation({
    super.key,
    required this.listenController,
    this.data,
  });

  @override
  State<AddressInformation> createState() => _AddressInformationState();
}

class _AddressInformationState extends State<AddressInformation>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  General general = General();
  bool isSubmit = false;
  bool isLoading = true;

  onSubmit() async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        Partner data = Partner.fromJson(fbKey.currentState!.value);
        data.province = source.partner.province;
        data.district = source.partner.district;
        data.khoroo = source.partner.khoroo;
        if (source.partner.province == null ||
            source.partner.district == null ||
            source.partner.khoroo == null) {
          showCustomDialog(context, 'Аймаг, сум, хороо сонгоно уу', false);
        } else {
          await PartnerApi().address(data, source.createdBranch.id!);
          widget.listenController.changeVariable('branch');
          showCustomDialog(context, "Салбарын хаяг амжилттай нэмлээ", true,
              onPressed: () {
            Navigator.of(context).pop();
          });
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

  provinceName() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.province != null) {
      final res = general.zipCodes!
          .firstWhere((element) => element.code == source.partner.province);
      return res.name;
    } else {
      return null;
    }
  }

  districtName() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.district != null) {
      final res = general.zipCodes!
          .firstWhere((element) => element.code == source.partner.district);
      return res.name;
    } else {
      return null;
    }
  }

  khorooName() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.khoroo != null) {
      final res = general.zipCodes!
          .firstWhere((element) => element.code == source.partner.khoroo);
      return res.name;
    } else {
      return null;
    }
  }

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (widget.data != null) {
      source.province(widget.data!.province);
      source.district(widget.data!.district);
      source.khoroo(widget.data!.khoroo);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    Provider.of<PartnerProvider>(context, listen: true);
    return isLoading == true
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: FormBuilder(
                key: fbKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Row(
                          children: [
                            Text(
                              'Хаягийн мэдээлэл',
                              style: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                endIndent: 5,
                                indent: 5,
                                thickness: .5,
                                color: grey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Аймаг, нийслэл',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      selection(
                        value: provinceName(),
                        hintText: 'Аймаг, нийслэл',
                        onClick: () {
                          selectProvince();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Сум, дүүрэг',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      selection(
                        value: districtName(),
                        hintText: 'Сум, дүүрэг',
                        onClick: () {
                          selectDistrict();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Баг, хороо',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      selection(
                        value: khorooName(),
                        hintText: 'Баг, хороо',
                        onClick: () {
                          selectKhoroo();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Хороолол, гудамж',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'khoroolol',
                        initialValue: widget.data?.khoroolol ?? '',
                        decoration: InputDecoration(
                          hintText: 'Хороолол, гудамж',
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
                          'Хотхон, байр',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'khotkhonBair',
                        initialValue: widget.data?.khotkhonBair ?? '',
                        decoration: InputDecoration(
                          hintText: 'Хотхон, байр',
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
                          'Хашаа, давхар',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'khashaaDavkhar',
                        initialValue: widget.data?.khashaaDavkhar ?? '',
                        decoration: InputDecoration(
                          hintText: 'Хашаа, давхар',
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
                          'Хаалганы дугаар',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'khaalgaDugaar',
                        initialValue: widget.data?.khaalgaDugaar ?? '',
                        decoration: InputDecoration(
                          hintText: 'Хаалганы дугаар',
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
                          'Хаягийн дэлгэрэнгүй',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'branchAddress',
                        maxLines: 3,
                        initialValue: widget.data?.branchAddress ?? '',
                        inputType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Хаягийн дэлгэрэнгүй',
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Row(
                          children: [
                            Text(
                              'Network-д гарах мэдээлэл',
                              style: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                endIndent: 5,
                                indent: 5,
                                thickness: .5,
                                color: grey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          'Өргөрөг',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'locationLat',
                        initialValue: widget.data?.locationLat != null
                            ? widget.data?.locationLat.toString()
                            : '',
                        inputType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Өргөрөг',
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
                          'Уртраг',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FormTextField(
                        textColor: black,
                        name: 'locationLng',
                        initialValue: widget.data?.locationLng != null
                            ? widget.data?.locationLng.toString()
                            : '',
                        inputType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Уртраг',
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
            ),
          );
  }

  Widget selection(
      {String? value, required String hintText, Function()? onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: grey2.withOpacity(0.3),
          ),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? hintText,
                style: TextStyle(
                  color: value == null ? grey2 : black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
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
      builder: (context) => const ProvinceSheet(),
    );
  }

  selectDistrict() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const DistrictSheet(),
    );
  }

  selectKhoroo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const KhorooSheet(),
    );
  }
}
