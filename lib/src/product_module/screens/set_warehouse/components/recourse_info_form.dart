import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RecourseInfoForm extends StatefulWidget {
  const RecourseInfoForm({super.key});

  @override
  State<RecourseInfoForm> createState() => _RecourseInfoFormState();
}

class _RecourseInfoFormState extends State<RecourseInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'minQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Заавал байх үлдэгдэл',
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
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'noticeMinQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Анхааруулах Min үлдэгдэл',
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
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'noticeMaxQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Анхааруулах Max үлдэгдэл',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'deactivateMinQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Идэвхгүй болгох үлдэгдэл',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'minOrderQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Минимум захиалгын тоо',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'reOrderQuantityLevel',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Дахин захиалах үлдэгдэл',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        FormTextField(
          inputType: TextInputType.number,
          textColor: productColor,
          textAlign: TextAlign.end,
          name: 'reOrderQuantity',
          decoration: InputDecoration(
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
              children: const [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Дахин захиалах тоо',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
