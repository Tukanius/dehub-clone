import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
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
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;
  String? khorooId;
  String? khorooName;
  bool isSubmit = false;

  onSubmit() async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        Partner data = Partner.fromJson(fbKey.currentState!.value);
        data.provinceId = provinceId;
        data.districtId = districtId;
        data.khorooId = khorooId;
        if (provinceId == null || districtId == null || khorooId == null) {
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

  @override
  afterFirstLayout(BuildContext context) {
    if (widget.data != null) {}
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return GestureDetector(
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
                  value: provinceName,
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
                  value: districtName,
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
                  value: khorooName,
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
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
                          khorooId = null;
                          khorooName = null;
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
                          khorooId = null;
                          khorooName = null;
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

  selectKhoroo() {
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
                  .where((element) => element.parent == districtId)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        setState(() {
                          khorooId = e.code;
                          khorooName = e.name;
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
}
