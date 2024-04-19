import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionDetailPageArguments {
  Payment data;
  TransactionDetailPageArguments({
    required this.data,
  });
}

class TransactionDetailPage extends StatefulWidget {
  final Payment data;
  static const routeName = '/transactiondetailpage';
  const TransactionDetailPage({
    super.key,
    required this.data,
  });

  @override
  TransactionDetailPageState createState() => TransactionDetailPageState();
}

class TransactionDetailPageState extends State<TransactionDetailPage>
    with AfterLayoutMixin {
  Payment payment = Payment();
  General general = General();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    payment = await PaymentApi().transactionGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  transactionType() {
    final res = general.transactionTypes!
        .firstWhere((element) => element.code == payment.type);
    return res.name;
  }

  paymentMethod() {
    final res = general.paymentMethod!
        .firstWhere((element) => element.code == payment.paymentMethod);
    return res.name;
  }

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == payment.creditAccountCurrency);
    return res.name;
  }

  bankName() {
    final res = general.bankNames!
        .firstWhere((element) => element.code == payment.account?.bankName);
    return res.name;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).paymentGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: paymentColor),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: paymentColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Гүйлгээний лавлах',
                    secondText: '${payment.refCode}',
                    labelTextColor: dark,
                    secondTextColor: grey2,
                    secondTextFontWeight: FontWeight.w500,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Огноо, цаг',
                    secondText: DateFormat('yyyy-MM-dd HH:mm')
                        .format(payment.createdAt!),
                    labelTextColor: dark,
                    secondTextColor: grey2,
                    secondTextFontWeight: FontWeight.w500,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Гүйлгээний төрөл',
                    secondText: "${transactionType()}",
                    labelTextColor: dark,
                    secondTextColor: grey2,
                    secondTextFontWeight: FontWeight.w500,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Төлбөрийн хэрэгсэл',
                    secondText: "${paymentMethod()}",
                    labelTextColor: dark,
                    secondTextColor: grey2,
                    secondTextFontWeight: FontWeight.w500,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Гүйлгээний дүн',
                    secondText:
                        '${Utils().formatCurrency("${payment.amount}")}₮',
                    labelTextColor: dark,
                    secondTextColor:
                        payment.inOutType == "DEBIT" ? neonGreen : red,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Валют',
                    secondText: "${currency()}",
                    labelTextColor: dark,
                    secondTextColor: grey2,
                    secondTextFontWeight: FontWeight.w500,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Гүйлгээний утга',
                    secondText: "${payment.description}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Гүйлгээ хийсэн',
                    secondText:
                        "${payment.payerUser?.lastName?[0]}. ${payment.payerUser?.firstName}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Үлдэгдэл',
                    secondText: "${payment.balance}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: const Text(
                      'ХАРЬЦСАН ДАНС',
                      style:
                          TextStyle(color: grey3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Дансны дугаар',
                    secondText: "${payment.account?.number}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Дансны нэр',
                    secondText: "${payment.account?.name}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 12,
                    labelText: 'Банкны нэр',
                    secondText: "${bankName()}",
                    labelTextColor: dark,
                    secondTextColor: neonGreen,
                    color: white,
                    marginBottom: 5,
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
