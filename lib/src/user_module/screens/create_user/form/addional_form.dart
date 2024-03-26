import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/src/user_module/screens/create_user/sheets/select_department_unit.dart';
import 'package:dehub/src/user_module/screens/create_user/sheets/select_departmentsub_unit.dart';
import 'package:dehub/src/user_module/screens/create_user/sheets/select_employee_unit.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AdditionalForm extends StatefulWidget {
  final User? data;
  const AdditionalForm({
    super.key,
    this.data,
  });

  @override
  State<AdditionalForm> createState() => _AdditionalFormState();
}

class _AdditionalFormState extends State<AdditionalForm> {
  General general = General();

  departmentUnit() {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    if (source.user.departmentUnitId != null) {
      final res = general.departmentUnits!
          .firstWhere((element) => element.id == source.user.departmentUnitId);
      return res.name;
    } else {
      return null;
    }
  }

  departmentSubUnit() {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    if (source.user.departmentSubUnitId != null) {
      final res = general.departmentUnits!.firstWhere(
          (element) => element.id == source.user.departmentSubUnitId);
      return res.name;
    } else {
      return null;
    }
  }

  employeeUnit() {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    if (source.user.employeeUnitId != null) {
      final res = general.employeeUnits!
          .firstWhere((element) => element.id == source.user.employeeUnitId);
      return res.name;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectionField(
            hintText: 'Сонгоно уу',
            labelText: 'Харьяалах нэгж',
            value: departmentUnit(),
            onClick: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SelectDepartmentUnit(),
              );
            },
          ),
          SelectionField(
            hintText: 'Сонгоно уу',
            labelText: 'Харьяалах дэд нэгж',
            value: departmentSubUnit(),
            onClick: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SelectDepartmentSubUnit(),
              );
            },
          ),
          SelectionField(
            hintText: 'Сонгоно уу',
            labelText: 'Албан тушаал',
            value: employeeUnit(),
            onClick: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SelectEmployeeUnit(),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('И-мэйл №2'),
          ),
          FormTextField(
            textColor: black,
            name: 'email2',
            initialValue: widget.data?.email2 ?? '',
            decoration: InputDecoration(
              hintText: 'Оруулна уу',
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
              fillColor: white,
              filled: true,
            ),
            validator: FormBuilderValidators.compose([
              (value) => validateEmail(value.toString(), context),
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('Гар утас №2'),
          ),
          FormTextField(
            textColor: black,
            name: 'phone2',
            initialValue: widget.data?.phone2 ?? '',
            decoration: InputDecoration(
              hintText: 'Оруулна уу',
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
              fillColor: white,
              filled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Text(
                  'Social линкүүд',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Divider(
                    indent: 5,
                    color: grey3,
                    thickness: .5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: source.user.socialLinks!.map((e) {
              int index = source.user.socialLinks!.indexOf(e);
              String svg = 'assets/svg/${e.type?.toLowerCase()}.svg';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(e.type!),
                  ),
                  SizedBox(
                    height: 42,
                    child: FormTextField(
                      onChanged: (value) {
                        if (value == '') {
                          setState(() {
                            source.user.socialLinks?[index].link = null;
                          });
                        } else {
                          setState(() {
                            source.user.socialLinks?[index].link = value;
                          });
                        }
                      },
                      textColor: black,
                      name: e.type,
                      initialValue: source.user.socialLinks?[index].link ?? '',
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            svg,
                            colorFilter:
                                const ColorFilter.mode(grey2, BlendMode.srcIn),
                          ),
                        ),
                        hintText: 'Оруулна уу',
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
                        fillColor: white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return null;
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мейлээ шалгана уу';
    } else {
      return null;
    }
  }
}
