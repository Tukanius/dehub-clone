import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettlementRespondArguments {
  Finance data;
  SettlementRespondArguments({
    required this.data,
  });
}

class SettlementRespond extends StatefulWidget {
  static const routeName = '/SettlementRespond';
  final Finance data;
  const SettlementRespond({
    super.key,
    required this.data,
  });

  @override
  State<SettlementRespond> createState() => _SettlementRespondState();
}

class _SettlementRespondState extends State<SettlementRespond> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: source.currentColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: black,
              fontFamily: "Montserrat",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: '#${widget.data.business?.partner?.refCode}',
                style: TextStyle(color: source.currentColor),
              ),
              TextSpan(
                text: ', ${widget.data.business?.partner?.businessName}',
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: grey2,
                    fontFamily: "Montserrat",
                  ),
                  children: [
                    const TextSpan(
                      text: 'Хүндэт ',
                    ),
                    TextSpan(
                      text:
                          '${widget.data.financeStaff?.lastName?[0]}. ${widget.data.financeStaff?.firstName} ',
                      style: TextStyle(color: source.currentColor),
                    ),
                    const TextSpan(
                      text: '\nТаны төлөөлж буй ',
                    ),
                    TextSpan(
                      text: '#${widget.data.business?.partner?.refCode}, ',
                      style: TextStyle(color: source.currentColor),
                    ),
                    TextSpan(
                      text: '${widget.data.business?.partner?.businessName}',
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text: ' -ийн хувьд ',
                    ),
                    TextSpan(
                      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      style: TextStyle(color: source.currentColor),
                    ),
                    const TextSpan(
                      text: ' -ийн байдлаар санхүүжилт эргэн төлөх ',
                    ),
                    TextSpan(
                      text: '2',
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const TextSpan(
                      text: ' тооны нийт ',
                    ),
                    TextSpan(
                      text:
                          '${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const TextSpan(
                      text: ' төгрөгийн үлдэгдэл байна.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      onClick: () {},
                      labelText: 'Дэлгэрэнгүй',
                      labelColor: source.currentColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      onClick: () {},
                      labelText: 'Тооцоо зөвшөөрөх',
                      labelColor: source.currentColor,
                    ),
                  ),
                ],
              ),
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
