import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_department_unit.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/sheets/select_employee_unit.dart';
import 'package:dehub/utils/validations.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AdminUserForm extends StatefulWidget {
  final bool edit;
  const AdminUserForm({
    super.key,
    required this.edit,
  });

  @override
  State<AdminUserForm> createState() => _AdminUserFormState();
}

class _AdminUserFormState extends State<AdminUserForm> {
  Partner user = Partner();
  General general = General();

  departmentUnit() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.departmentUnitId != null) {
      final res = general.departmentUnits!.firstWhere(
          (element) => element.id == source.partner.departmentUnitId);
      return res.name;
    } else {
      return null;
    }
  }

  employeeUnit() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (source.partner.employeeUnitId != null) {
      final res = general.employeeUnits!
          .firstWhere((element) => element.id == source.partner.employeeUnitId);
      return res.name;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    Provider.of<PartnerProvider>(context, listen: true);
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
          child: const Text('Админы регстр №'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'registerNo',
          readOnly: !widget.edit,
          initialValue: user.user?.registerNo,
          decoration: InputDecoration(
            hintText: 'Админы регстр №',
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
          child: const Text('Ургын овог'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'familyName',
          readOnly: !widget.edit,
          initialValue: user.user?.familyName,
          decoration: InputDecoration(
            hintText: 'Ургын овог',
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
            (value) => validateCryllic(value.toString(), context),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Эцэг эхийн нэр'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'lastName',
          readOnly: !widget.edit,
          initialValue: user.user?.lastName,
          decoration: InputDecoration(
            hintText: 'Эцэг эхийн нэр',
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
            (value) => validateCryllic(value.toString(), context),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Нэр'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'firstName',
          readOnly: !widget.edit,
          initialValue: user.user?.firstName,
          decoration: InputDecoration(
            hintText: 'Нэр',
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
            (value) => validateCryllic(value.toString(), context),
          ]),
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: departmentUnit(),
          labelText: 'Харьяалах нэгжийн нэр',
          labelTextColor: widget.edit == true ? black : grey2,
          backgroundColor: widget.edit == true ? white : backgroundColor,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectDepartmentUnit(),
                  );
                }
              : () {},
        ),
        SelectionField(
          hintText: 'Сонгоно уу',
          value: employeeUnit(),
          labelText: 'Албан тушаалын нэр',
          labelTextColor: widget.edit == true ? black : grey2,
          backgroundColor: widget.edit == true ? white : backgroundColor,
          onClick: widget.edit == true
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SelectEmployeeUnit(),
                  );
                }
              : () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text('Утасны дугаар №1'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'phone',
          readOnly: !widget.edit,
          initialValue: user.user?.phone,
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
          initialValue: user.user?.phone2,
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
          child: const Text('И-мэйл хаяг №1'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'email',
          inputType: TextInputType.emailAddress,
          readOnly: !widget.edit,
          initialValue: user.user?.email,
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
          initialValue: user.user?.email2,
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
          child: const Text('Facebook хаяг'),
        ),
        FormTextField(
          textColor: widget.edit == true ? black : grey2,
          name: 'socialFbLink',
          readOnly: !widget.edit,
          initialValue: user.user?.email2,
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
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
