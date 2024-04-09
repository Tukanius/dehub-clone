import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_staffs.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class NewConditionPageArguments {
  ListenController listenController;
  NewConditionPageArguments({
    required this.listenController,
  });
}

class NewConditionPage extends StatefulWidget {
  final ListenController listenController;

  static const routeName = '/NewConditionPage';
  const NewConditionPage({required this.listenController, super.key});

  @override
  State<NewConditionPage> createState() => _NewConditionPageState();
}

class _NewConditionPageState extends State<NewConditionPage> {
  General general = General();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  int expireDayCount = 0;

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      BusinessStaffs business = BusinessStaffs();
      business.configType = "INV_NET_X";
      business.condition = 'INV_CONFIG';
      business.expireDayCount = expireDayCount;
      await BusinessApi().createPaymentTerm(business);
      widget.listenController.changeVariable('invoiceConditionCreate');
      showCustomDialog(
        context,
        "Төлбөрийн нөхцөл амжилттай нэмлээ",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Нэхэмжлэх - шинэ нөхцөл',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Нөхцөлийг сонгоно уу',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: const Text('Нэхэмжлэх баталснаас хойш ажлын X хоног'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Нэмэлт тохиргоо',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FormBuilder(
                  key: fbkey,
                  child: FormTextField(
                    name: 'expireDayCount',
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        expireDayCount = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: const InputDecoration(
                      fillColor: white,
                      filled: true,
                      hintText: 'Хоногийн тоо',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Заавал оруулна'),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
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
    );
  }
}
