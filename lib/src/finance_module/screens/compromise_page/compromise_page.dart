import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CompromisePageArguments {
  Finance data;
  CompromisePageArguments({
    required this.data,
  });
}

class CompromisePage extends StatefulWidget {
  final Finance data;
  static const routeName = '/CompromisePage';
  const CompromisePage({
    super.key,
    required this.data,
  });

  @override
  State<CompromisePage> createState() => _CompromisePageState();
}

class _CompromisePageState extends State<CompromisePage> {
  User user = User();
  List<Finance> compromises = [];
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSubmit = false;

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    List<Finance> data = [];
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        for (var i = 0; i < compromises.length; i++) {
          data.add(
            Finance(
              amount: compromises[i].amount,
              date:
                  DateFormat('yyyy-MM-dd').format(compromises[i].paymentDate!),
            ),
          );
        }
        await FinanceApi().compromiseCreate(
            source.url, Finance(compromises: data), widget.data.id!);
        showCustomDialog(
          context,
          'Амлалт амжилттай илгээлээ',
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
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
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          surfaceTintColor: white,
          backgroundColor: white,
          title: Text(
            'Амлалт өгөх',
            style: TextStyle(
              color: source.currentColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: IconThemeData(color: source.currentColor),
        ),
        body: FormBuilder(
          key: fbKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ЭТН №: ',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                              Text(
                                '${widget.data.refCode}',
                                style: TextStyle(color: source.currentColor),
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        color: lightGrey,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: grey2,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Хүндэт ',
                            ),
                            TextSpan(
                              text: '${user.firstName}',
                              style: TextStyle(color: source.currentColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: grey2,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            const TextSpan(
                              text: 'Таны төлөөлж буй ',
                            ),
                            TextSpan(
                              text:
                                  '${user.currentBusiness?.partnerName}, ${user.currentBusiness?.refCode}',
                              style: TextStyle(color: source.currentColor),
                            ),
                            const TextSpan(
                              text: '-ийн ',
                            ),
                            TextSpan(
                              text:
                                  '${user.currentBusiness?.profileName}, ${user.currentBusiness?.refCode}',
                              style: TextStyle(color: source.currentColor),
                            ),
                            const TextSpan(
                              text: '-ийн ',
                            ),
                            TextSpan(
                              text: '${widget.data.refCode}',
                              style: TextStyle(color: source.currentColor),
                            ),
                            const TextSpan(
                              text: ' дугаартай эргэн төлөлтийн нэхэмжлэх ',
                            ),
                            TextSpan(
                              text:
                                  '${Utils().formatCurrency(widget.data.amountToPay.toString())}',
                              style: TextStyle(color: source.currentColor),
                            ),
                            const TextSpan(
                              text: ' төгрөгийн үлдэгдэлтэйгээр ',
                            ),
                            TextSpan(
                              text: '0',
                              style: TextStyle(color: source.currentColor),
                            ),
                            const TextSpan(
                              text: ' хоногоор хугацаа хэтэрсэн байна.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            const TextSpan(
                              text: 'Дүн: ',
                              style: TextStyle(
                                color: grey2,
                              ),
                            ),
                            TextSpan(
                              text: Utils().formatCurrency(
                                  widget.data.amountToPay.toString()),
                              style: TextStyle(
                                color: source.currentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            const TextSpan(
                              text: 'Үлдэх дүн: ',
                              style: TextStyle(
                                color: grey2,
                              ),
                            ),
                            TextSpan(
                              text: Utils().formatCurrency((widget
                                          .data.amountToPay! -
                                      compromises.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (double.tryParse(element.amount
                                                      .toString()) ??
                                                  0)))
                                  .toString()),
                              style: TextStyle(
                                color: source.currentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Хуваарь тохирох',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            color: source.currentColor,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  compromises.add(
                                    Finance(
                                      amount: null,
                                      paymentDate: DateTime.now(),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: const Text(
                                  'Хуваарь нэмэх',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: compromises.map((data) {
                          return Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Төлөх боломжит дүн',
                                        style: TextStyle(
                                          color: grey2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      FormTextField(
                                        textColor: grey2,
                                        name: "${compromises.indexOf(data)}",
                                        fontSize: 12,
                                        onChanged: (value) {
                                          setState(() {
                                            data.amount =
                                                double.tryParse(value);
                                          });
                                        },
                                        inputType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: white,
                                          hintText: 'Дүн оруулна уу',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: lightGrey,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: red),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          isDense: true,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: 'Заавал оруулна уу'),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Огноо цаг сонгох',
                                          style: TextStyle(
                                            color: grey2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  color: white,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'Болсон',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: black,
                                                            fontFamily:
                                                                "Montserrat",
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            CupertinoDatePicker(
                                                          minimumDate: DateTime
                                                              .parse(DateFormat(
                                                                      "yyyy-MM-dd")
                                                                  .format(DateTime
                                                                      .now())),
                                                          initialDateTime:
                                                              data.paymentDate,
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          use24hFormat: true,
                                                          showDayOfWeek: true,
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  newDate) {
                                                            setState(() {
                                                              data.paymentDate =
                                                                  newDate;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: white,
                                              border:
                                                  Border.all(color: lightGrey),
                                            ),
                                            child: Text(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(data.paymentDate!),
                                              style: const TextStyle(
                                                color: grey2,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: CustomButton(
                        isLoading: isSubmit,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        borderColor: source.currentColor,
                        labelColor: backgroundColor,
                        labelText: 'Буцах',
                        textColor: source.currentColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomButton(
                        isLoading: isSubmit,
                        onClick: () {
                          onSubmit();
                        },
                        labelColor: source.currentColor,
                        labelText: 'Амлалт илгээх',
                      ),
                    ),
                    const SizedBox(
                      width: 25,
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
      ),
    );
  }
}
