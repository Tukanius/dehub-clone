import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/finance_module/screens/payment_received_funds/payment_received_funds.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountInformation extends StatefulWidget {
  final Finance data;
  const AccountInformation({
    super.key,
    required this.data,
  });

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  General general = General();
  User user = User();
  String? amount;

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Харилцагчийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Харилцагчийн CIF',
            secondText: 'Харилцагчийн CIF',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Татвар төлөгчийн дугаар',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.regNumber}'
                : '${widget.data.invoice?.supplier?.regNumber}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Харилцагчийн нэр',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.profileName}'
                : '${widget.data.invoice?.supplier?.profileName}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Партнерийн нэр',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.partner?.refCode}, '
                : '${widget.data.invoice?.supplier?.partner?.refCode}, ',
            thirdText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.partner?.businessName}'
                : '${widget.data.invoice?.supplier?.partner?.businessName}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Зээл авсан бизнес',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.refCode}, '
                : '${widget.data.invoice?.supplier?.refCode}, ',
            thirdText: user.currentBusiness?.type == "SUPPLIER"
                ? '${widget.data.invoice?.buyer?.profileName}'
                : '${widget.data.invoice?.supplier?.profileName}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүссэн ажилтан',
            secondText: "SCF/DCF ажилтан",
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: '${widget.data.lbfProgram?.refCode}, ',
            thirdText: '${widget.data.lbfProgram?.name}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Бүтээгдэхүүний нэр',
            secondText: '${widget.data.lbfProduct?.refCode}, ',
            thirdText: '${widget.data.lbfProduct?.name}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэхэмжлэх дугаар',
            secondText: '${widget.data.invoice?.refCode}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Зээл олгосон дүн',
            secondText:
                '${Utils().formatCurrency("${widget.data.invoice?.confirmedAmount}") + currency().symbol}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүлээн авсан данс',
            secondText: user.currentBusiness?.type == "SUPPLIER"
                ? "${widget.data.invoice?.supplierAccount?.number}, "
                : "${widget.data.invoice?.buyerAccount?.number}, ",
            thirdText: user.currentBusiness?.type == "SUPPLIER"
                ? "${widget.data.invoice?.supplierAccount?.name}"
                : "${widget.data.invoice?.buyerAccount?.name}",
            color: white,
            secondTextColor: source.currentColor,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Зээлийн дансны мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дансны дугаар',
            secondText: '${widget.data.accountNumber}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дансны нэр',
            secondText: '${widget.data.accountName}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Бүтээгдэхүүний нэр',
            secondText: '${widget.data.accountCategory}',
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Валют',
            secondText: currency().name,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Данс нээсэн огноо',
            secondText: widget.data.openDate,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Данс хаагдах хугацаа',
            secondText: widget.data.maturityDate,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хугацаа сараар',
            secondText: "${widget.data.periodInMonths}",
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дараагийн өр төлөх хугацаа',
            secondText: widget.data.nextInstallmentDueDate,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хугацаа хэтэрсэн дүн',
            secondText: Utils().formatCurrency("${widget.data.overdueAmount}") +
                currency().symbol,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нийт үлдэгдэл',
            secondText: Utils().formatCurrency("${widget.data.payOffAmount}") +
                currency().symbol,
            color: white,
            secondTextColor: source.currentColor,
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
                flex: 4,
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                  borderColor: grey2,
                  labelColor: white,
                  textColor: black,
                  labelText: 'Буцах',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 6,
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(
                      PaymentReceivedFunds.routeName,
                      arguments: PaymentReceivedFundsArguments(
                        data: widget.data,
                      ),
                    );
                  },
                  labelColor: source.currentColor,
                  textColor: white,
                  labelText: 'Төлөлт хийх',
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
    );
  }
}
