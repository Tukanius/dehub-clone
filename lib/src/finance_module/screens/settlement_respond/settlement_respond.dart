import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
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
  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    final source = Provider.of<FinanceProvider>(context, listen: false);
    try {
      loading.loading(true);
      await FinanceApi().settlementRespond(source.url, widget.data.id!);
      loading.loading(false);
      showCustomDialog(context, 'Амжилттай тооцоо зөвшөөрлөө', true,
          onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      loading.loading(false);
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      labelText: 'Буцах',
                      borderColor: source.currentColor,
                      labelColor: white,
                      textColor: source.currentColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      onClick: onSubmit,
                      labelText: 'Тооцоо зөвшөөрөх',
                      labelColor: source.currentColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: black,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    const TextSpan(
                      text: 'Тооцоо эхлэх огноо: ',
                    ),
                    TextSpan(
                      text: DateFormat('yyyy-MM-dd')
                          .format(widget.data.sentDate!),
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: black,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    const TextSpan(
                      text: 'Тооцоо дуусах огноо: ',
                    ),
                    TextSpan(
                      text: DateFormat('yyyy-MM-dd')
                          .format(widget.data.sentDate!),
                      style: TextStyle(
                        color: source.currentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: Text(
                          'Эхний үлдэгдэл: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${Utils().formatCurrency("${widget.data.firstAmount}")}₮",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: Text(
                          'Тухайн сард нэмэгдсэн: ',
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${Utils().formatCurrency("${widget.data.confirmedAmount}")}₮",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: Text(
                          'Тухайн сард хасагдсан: ',
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${Utils().formatCurrency("0")}₮",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: Text(
                          'Эцсийн үлдэгдэл: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${Utils().formatCurrency("${widget.data.lastAmount}")}₮",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
