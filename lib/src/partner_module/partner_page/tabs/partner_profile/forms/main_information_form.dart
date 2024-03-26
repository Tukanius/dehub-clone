import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_classification.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_country.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_equity_type.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_legal_entity_type.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_partner_category.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/district_sheet.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/khoroo_sheet.dart';
import 'package:dehub/src/partner_module/screens/address_sheets/province_sheet.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:intl/intl.dart';

class MainInformationForm extends StatefulWidget {
  final bool edit;
  const MainInformationForm({
    super.key,
    required this.edit,
  });

  @override
  State<MainInformationForm> createState() => _MainInformationFormState();
}

class _MainInformationFormState extends State<MainInformationForm> {
  Partner user = Partner();
  General general = General();

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

  legalEntityType() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.legalEntityType != null) {
      final res = general.legalEntityTypes!.firstWhere(
          (element) => element.code == source.partner.legalEntityType);
      return res.name;
    } else {
      return null;
    }
  }

  equityType() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.equityType != null) {
      final res = general.equityTypes!
          .firstWhere((element) => element.code == source.partner.equityType);
      return res.name;
    } else {
      return null;
    }
  }

  classification() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.classification != null) {
      final res = general.partnerClassifications!.firstWhere(
          (element) => element.code == source.partner.classification);
      return res.name;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    final source = Provider.of<PartnerProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Text(
                'ҮНДСЭН МЭДЭЭЛЭЛ',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 5,
                  color: grey3,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Партнерийн код'),
        ),
        FormTextField(
          textColor: grey2,
          name: 'partnerRef',
          initialValue: user.partner?.refCode,
          readOnly: true,
          decoration: InputDecoration(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: backgroundColor,
            filled: true,
          ),
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: source.partner.partnerCategory,
          labelText: 'Партнерийн категори',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectPartnerCategory(),
                  );
                }
              : () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Бүртгэсэн'),
        ),
        FormTextField(
          textColor: grey2,
          name: '1',
          initialValue: user.user?.lastName != null
              ? '${user.user?.lastName?[0]}. ${user.user?.firstName}'
              : "${user.user?.firstName}",
          readOnly: true,
          decoration: InputDecoration(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Бүртгэсэн огноо, цаг'),
        ),
        FormTextField(
          textColor: grey2,
          name: '2',
          readOnly: true,
          initialValue:
              DateFormat("yyyy-MM-dd HH:mm").format(user.partner!.createdAt!),
          decoration: InputDecoration(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Регистр/Татвар төлөгчийн дугаар'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'regNumber',
          readOnly: !widget.edit,
          initialValue: user.partner?.regNumber,
          decoration: InputDecoration(
            hintText: 'Регистр/Татвар төлөгчийн дугаар',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Заавал оруулна',
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Улсын бүртгэлийн гэрчилгээ №'),
        ),
        FormTextField(
          textColor: grey2,
          name: '3',
          readOnly: true,
          initialValue: 'Улсын бүртгэлийн гэрчилгээ №',
          decoration: InputDecoration(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Аж ахуйн нэгжийн нэр'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'businessName',
          readOnly: !widget.edit,
          initialValue: user.partner?.businessName,
          decoration: InputDecoration(
            hintText: 'Аж ахуйн нэгжийн нэр',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Заавал оруулна',
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Аж ахуйн нэгжийн нэр/Латин/'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'businessNameEng',
          readOnly: !widget.edit,
          initialValue: user.partner?.businessNameEng,
          decoration: InputDecoration(
            hintText: 'Аж ахуйн нэгжийн нэр/Латин/',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Заавал оруулна',
            ),
          ]),
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: legalEntityType(),
          labelText: 'Аж ахуйн нэгжийн хэлбэр',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectLegalEntityType(),
                  );
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: source.partner.country,
          labelText: 'Улсын харьяалал',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectCountry(),
                  );
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: equityType(),
          labelText: 'Өмчийн хэлбэр',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectEquityType(),
                  );
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: classification(),
          labelText: 'Ангилал',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectClassification(),
                  );
                }
              : () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'ХОЛБОО БАРИХ',
            style: TextStyle(
              color: grey3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Веб сайтын хаяг'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'web',
          inputType: TextInputType.url,
          readOnly: !widget.edit,
          initialValue: user.partner?.web,
          decoration: InputDecoration(
            hintText: 'Веб сайтын хаяг',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('И-мэйл хаяг №1'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'email',
          inputType: TextInputType.emailAddress,
          readOnly: !widget.edit,
          initialValue: user.partner?.email,
          decoration: InputDecoration(
            hintText: 'И-мэйл хаяг №1',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('И-мэйл хаяг №2'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'email2',
          readOnly: !widget.edit,
          initialValue: user.partner?.email2,
          decoration: InputDecoration(
            hintText: 'И-мэйл хаяг №2',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Утасны дугаар №1'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'phone',
          readOnly: !widget.edit,
          initialValue: user.partner?.phone,
          decoration: InputDecoration(
            hintText: 'Утасны дугаар №1',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Утасны дугаар №2'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'phone2',
          readOnly: !widget.edit,
          initialValue: user.partner?.phone2,
          decoration: InputDecoration(
            hintText: 'Утасны дугаар №2',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Facebook хаяг'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'fbLink',
          readOnly: !widget.edit,
          initialValue: user.partner?.fbLink,
          decoration: InputDecoration(
            hintText: 'Facebook хаяг',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Text(
                'ХАЯГ',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 5,
                  color: grey3,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: provinceName(),
          labelText: 'Аймаг, нийслэл',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  selectProvince();
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: districtName(),
          labelText: 'Сум, дүүрэг',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  selectDistrict();
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: khorooName(),
          labelText: 'Баг, хороо',
          backgroundColor: widget.edit == true ? white : backgroundColor,
          labelTextColor: widget.edit == true ? black : grey2,
          onClick: widget.edit == true
              ? () {
                  selectKhoroo();
                }
              : () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Хороолол, гудамж'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'khoroolol',
          readOnly: !widget.edit,
          initialValue: user.partner?.khoroolol,
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Заавал оруулна'),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Хотхон, байр'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'khotkhonBair',
          readOnly: !widget.edit,
          initialValue: user.partner?.khotkhonBair,
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Заавал оруулна'),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Хашаа, давхар'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'khashaaDavkhar',
          readOnly: !widget.edit,
          initialValue: user.partner?.khashaaDavkhar,
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Заавал оруулна'),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Хаалганы дугаар'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'khaalgaDugaar',
          readOnly: !widget.edit,
          initialValue: user.partner?.khaalgaDugaar,
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Заавал оруулна'),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Хаягийн бичгийн тайлбар'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'businessAddress',
          readOnly: !widget.edit,
          maxLines: 3,
          initialValue: user.partner?.businessAddress,
          decoration: InputDecoration(
            hintText: 'Хаягийн бичгийн тайлбар',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
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
                'БАЙРШИЛ',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 5,
                  color: grey3,
                  thickness: 0.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Өргөрөг'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'locationLat',
          readOnly: !widget.edit,
          initialValue: user.partner?.locationLat != null
              ? user.partner!.locationLat.toString()
              : '',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Уртраг'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'locationLng',
          readOnly: !widget.edit,
          initialValue: user.partner?.locationLng != null
              ? user.partner!.locationLng.toString()
              : '',
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            isDense: true,
            fillColor: widget.edit == true ? white : backgroundColor,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
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
