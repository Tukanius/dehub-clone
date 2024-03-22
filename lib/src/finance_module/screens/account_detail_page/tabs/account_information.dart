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
import 'package:intl/intl.dart';
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
        children: [
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
            labelText: 'Харилцагчийн CIF',
            secondText: 'Харилцагчийн CIF',
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
            labelText: 'Олгосон огноо',
            secondText: DateFormat('yyyy-MM-dd HH:mm')
                .format(widget.data.invoice!.createdAt!),
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүлээн авах данс',
            secondText: widget.data.accountNumber,
            color: white,
            secondTextColor: source.currentColor,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дансны төлөв',
            secondText: "НЭЭЛТТЭЙ",
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
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(
                      PaymentReceivedFunds.routeName,
                      arguments: PaymentReceivedFundsArguments(
                        id: null,
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
