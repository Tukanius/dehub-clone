import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_staffs.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment_term_config_types.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AddCodTermArguments {
  ListenController listenController;
  AddCodTermArguments({
    required this.listenController,
  });
}

class AddCodTerm extends StatefulWidget {
  static const routeName = '/AddCodTerm';
  final ListenController listenController;
  const AddCodTerm({
    super.key,
    required this.listenController,
  });

  @override
  State<AddCodTerm> createState() => _AddCodTermState();
}

class _AddCodTermState extends State<AddCodTerm> {
  General general = General();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  PaymentTermConfigTypes type = PaymentTermConfigTypes();
  int? advancePercent;
  int? confirmationDay;

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        BusinessStaffs business = BusinessStaffs();
        business.condition = 'COD';
        business.configType = type.code;
        business.advancePercent = advancePercent;
        business.confirmationDay = confirmationDay;
        loading.loading(true);
        await BusinessApi().createPaymentTerm(business);
        loading.loading(false);
        widget.listenController.changeVariable('invoiceConditionCreate');
        showCustomDialog(
          context,
          "Төлбөрийн нөхцөл амжилттай нэмлээ",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Бэлэн төлөх нөхцөл нэмэх',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: networkColor),
        backgroundColor: white,
        surfaceTintColor: white,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: fbkey,
          child: Column(
            children: [
              FieldCard(
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: 'Нөхцөл',
                secondText: type.text ?? 'Сонгох',
                arrowColor: networkColor,
                secondTextColor: networkColor,
                onClick: () {
                  configType();
                },
              ),
              if (type.code == "CIA")
                FormTextField(
                  textAlign: TextAlign.end,
                  name: 'advancePercent',
                  textColor: networkColor,
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      advancePercent = int.tryParse(value);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      child: const Text(
                        'Хувь',
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                    hintText: 'Энд оруулна уу',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                  ]),
                ),
              FormTextField(
                textAlign: TextAlign.end,
                name: 'confirmationDay',
                textColor: networkColor,
                inputType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    confirmationDay = int.tryParse(value);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'Хоног',
                    ),
                  ),
                  fillColor: white,
                  filled: true,
                  hintText: 'Энд оруулна уу',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      borderColor: networkColor,
                      labelText: 'Буцах',
                      labelColor: backgroundColor,
                      textColor: networkColor,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      labelColor: networkColor,
                      labelText: 'Хадгалах',
                      onClick: () {
                        onSubmit();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
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

  configType() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: general.paymentTermConfigTypes!
                .where((element) => element.condition == "COD")
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        type = e;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text('${e.text}'),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
