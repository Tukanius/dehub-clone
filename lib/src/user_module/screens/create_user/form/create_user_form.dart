import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateUserForm extends StatefulWidget {
  final User? data;
  const CreateUserForm({
    super.key,
    this.data,
  });

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('Ургын овог'),
          ),
          FormTextField(
            textColor: black,
            name: 'familyName',
            initialValue: widget.data?.familyName ?? '',
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
              (value) => validateCryllic(value.toString(), context),
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('Овог'),
          ),
          FormTextField(
            textColor: black,
            name: 'lastName',
            initialValue: widget.data?.lastName ?? '',
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
              (value) => validateCryllic(value.toString(), context),
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('Нэр'),
          ),
          FormTextField(
            textColor: black,
            name: 'firstName',
            initialValue: widget.data?.firstName ?? '',
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
              (value) => validateCryllic(value.toString(), context),
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('Регистрийн дугаар'),
          ),
          FormTextField(
            textColor: black,
            name: 'registerNo',
            initialValue: widget.data?.registerNo ?? '',
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
            validator: FormBuilderValidators.compose(
              [(value) => registerValidate(value.toString(), context)],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text('И-мэйл №1'),
          ),
          FormTextField(
            textColor: black,
            name: 'email',
            initialValue: widget.data?.email ?? '',
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
            child: const Text('Гар утас №1'),
          ),
          FormTextField(
            textColor: black,
            name: 'phone',
            initialValue: widget.data?.phone ?? '',
            inputType: TextInputType.number,
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
              FormBuilderValidators.required(errorText: 'Заавал оруулна'),
            ]),
          ),
        ],
      ),
    );
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'И-Мейлээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мейлээ шалгана уу';
    } else {
      return null;
    }
  }
}

String? registerValidate(String value, context) {
  RegExp regex = RegExp(r'^[А-Яа-я|Үү|Өө|Ёё]{2}\d{8}$');
  if (value.isEmpty) {
    return 'Регистр оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Регистр шалгана уу';
    } else {
      return null;
    }
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
