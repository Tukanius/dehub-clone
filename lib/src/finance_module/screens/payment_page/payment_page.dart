import 'dart:io';
import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment_method.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:after_layout/after_layout.dart';

class FinancePaymentArguments {
  String refCode;
  String id;
  FinancePaymentArguments({
    required this.id,
    required this.refCode,
  });
}

class FinancePayment extends StatefulWidget {
  final String id;
  final String refCode;
  static const routeName = '/FinancePayment';
  const FinancePayment({
    super.key,
    required this.refCode,
    required this.id,
  });

  @override
  State<FinancePayment> createState() => _FinancePaymentState();
}

class _FinancePaymentState extends State<FinancePayment> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  General general = General();

  String selectedMethod = 'Сонгох';
  String? selectedMethodId;
  String selectedAccount = 'Сонгох';
  String? selectedAccountId;
  bool isSubmit = false;
  PlatformFile? pickedFile;
  String fileName = "Сонгох";
  FilePickerResult? file;
  File? fileToDisplay;
  User user = User();
  List<PaymentMethod> methods = [];

  bool methodValidate = false;
  bool accountValidate = false;

  pay() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);

    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        Finance data = Finance.fromJson(fbkey.currentState!.value);
        data.method = selectedMethodId;
        data.creditAccountId = selectedAccountId;
        if (user.url != null) data.files = [user.url.toString()];
        await FinanceApi().pay(source.url, data, widget.id);
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

  validateCheck() {
    if (selectedMethodId == null) {
      setState(() {
        methodValidate = true;
      });
    }
    if (selectedMethodId == 'B2B' && selectedAccountId == null) {
      setState(() {
        accountValidate = true;
      });
    }
    if (selectedMethodId != null && selectedAccountId != null) {
      pay();
    }
  }

  void pickFile() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    try {
      file = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (file != null) {
        fileName = file!.files.first.name;
        pickedFile = file!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        debugPrint("File name $fileName");
        user = await AuthApi().uploadFile(pickedFile!, "finance");
        source.contractFiles(user.url.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    methods = general.paymentMethods!
        .where((element) => element.code == "B2B" || element.code == "QPAY")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: IconThemeData(color: source.currentColor),
          title: Text(
            '${widget.refCode} - Төлөх',
            style: TextStyle(
              color: source.currentColor,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: fbkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Төлбөрийн мэдээлэл',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: "Төлбөрийн хэрэгсэл",
                  secondText: selectedMethod,
                  secondTextColor: source.currentColor,
                  validate: methodValidate,
                  onClick: () {
                    paymentMethod();
                  },
                  arrowColor: source.currentColor,
                ),
                if (selectedMethodId == "B2B")
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    validate: accountValidate,
                    labelText: "Зарлага гаргах данс",
                    secondText: selectedAccount,
                    secondTextColor: source.currentColor,
                    onClick: () {
                      bankAccount();
                    },
                    arrowColor: source.currentColor,
                  ),
                if (selectedMethodId == "B2B")
                  FormTextField(
                    textColor: source.currentColor,
                    name: 'amount',
                    textAlign: TextAlign.end,
                    inputType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Энд оруулна уу',
                      hintStyle: TextStyle(color: source.currentColor),
                      fillColor: white,
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      prefixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text('Дүн'),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Заавал оруулна'),
                    ]),
                  ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Нэмэлт мэдээлэл',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FieldCard(
                  paddingHorizontal: 15,
                  paddingVertical: 10,
                  color: white,
                  labelText: "Файл хавсаргах",
                  secondText: fileName,
                  secondTextColor: source.currentColor,
                  onClick: () {
                    pickFile();
                  },
                  arrowColor: source.currentColor,
                ),
                Container(
                  color: white,
                  padding: const EdgeInsets.all(15),
                  child: const FormTextField(
                    textAlign: TextAlign.left,
                    name: 'addInfo',
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Тайлбар оруулна уу',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: grey),
                      ),
                      fillColor: white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: grey2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: CustomButton(
                        labelText: 'Буцах',
                        textColor: source.currentColor,
                        borderColor: source.currentColor,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomButton(
                        labelColor: source.currentColor,
                        labelText: 'Төлөх',
                        onClick: () {
                          validateCheck();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  paymentMethod() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Төлбөрийн хэрэгсэл сонгоно уу',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: methods
                    .map(
                      (e) => Material(
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedMethod = e.name!;
                              selectedMethodId = e.code;
                              methodValidate = false;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text('${e.code}'),
                          ),
                        ),
                      ),
                    )
                    .toList(),
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

  bankAccount() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Зарлага гаргах данс сонгоно уу',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: general.bankAccounts!
                    .map(
                      (e) => Material(
                        color: backgroundColor,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedAccount = '${e.number} /${e.bankName}/';
                              selectedAccountId = e.id;
                              accountValidate = false;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: grey2,
                                  radius: 14,
                                  backgroundImage: NetworkImage("${e.icon}"),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('${e.number} /${e.bankName}/'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
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
}
