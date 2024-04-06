import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class UpdateAccountSheet extends StatefulWidget {
  final String shortName;
  final bool isDefault;
  final String id;
  final ListenController listenController;
  const UpdateAccountSheet({
    super.key,
    required this.listenController,
    required this.id,
    required this.shortName,
    required this.isDefault,
  });

  @override
  State<UpdateAccountSheet> createState() => _UpdateAccountSheetState();
}

class _UpdateAccountSheetState extends State<UpdateAccountSheet> {
  bool isDefault = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    setState(() {
      isDefault = widget.isDefault;
    });
    super.initState();
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        Payment data = Payment.fromJson(fbkey.currentState!.value);
        data.isDefault = isDefault;
        await PaymentApi().bankAccountUpdate(data, widget.id);
        loading.loading(false);
        widget.listenController.changeVariable('asdf');
        Navigator.of(context).pop();
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: const BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormBuilder(
              key: fbkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      'Дансны мэдээлэл засах',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: const Text('Дансны товч нэр'),
                  ),
                  FormTextField(
                    name: 'shortName',
                    initialValue: widget.shortName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: grey3.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      hintText: "Дансны товч нэр оруулна уу",
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Заавал оруулна '),
                    ]),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: const Text('Үндсэн данс эсэх'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: white,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => isDefault ? paymentColor : white),
                        checkColor: white,
                        value: isDefault,
                        onChanged: (value) {
                          setState(() {
                            isDefault = !isDefault;
                          });
                        },
                      ),
                      Text(isDefault ? 'Тийм' : "Үгүй"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      borderColor: grey2,
                      labelText: 'Болих',
                      labelColor: white,
                      textColor: buttonColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      onClick: onSubmit,
                      labelColor: paymentColor,
                      labelText: 'Хадгалах',
                      textColor: white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
