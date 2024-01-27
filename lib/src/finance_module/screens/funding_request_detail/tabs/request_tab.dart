import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestTab extends StatefulWidget {
  final Finance data;
  const RequestTab({
    super.key,
    required this.data,
  });

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  General general = General();
  bool isSwitched = false;
  User user = User();

  feeRule() {
    final String? res;
    if (widget.data.type == "SUPPLIER") {
      res = general.productSuppFeeRules!
          .firstWhere((element) => element.code == widget.data.feeRule)
          .name;
    } else {
      res = general.productBuyerFeeRules!
          .firstWhere((element) => element.code == widget.data.feeRule)
          .name;
    }
    return res;
  }

  penaltyType() {
    final String? res;
    if (widget.data.type == "SUPPLIER") {
      res = general.productSuppPenaltyTypes!
          .firstWhere((element) => element.code == widget.data.penaltyType)
          .name;
    } else {
      res = general.productBuyerPenaltyTypes!
          .firstWhere((element) => element.code == widget.data.penaltyType)
          .name;
    }
    return res;
  }

  overdue() {
    final res = general.invoiceOverdueStatus!
        .firstWhere((element) => element.code == widget.data.invOverdueStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: false).financeGeneral;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${widget.data.refCode}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлтийн төрөл',
            secondText: '${requestType()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлт гаргасан',
            secondText: '${widget.data.requestedFinUser?.firstName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хүсэлтийн огноо',
            secondText: DateFormat('yyyy-MM-dd').format(widget.data.createdAt!),
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Хүсэлтийн төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(
                                requestStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000)
                        .withOpacity(0.2),
                  ),
                  child: Text(
                    '${requestStatus().name}',
                    style: TextStyle(
                        color: Color(int.parse(
                                requestStatus().color.substring(1, 7),
                                radix: 16) +
                            0xff000000),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            onClick: () {},
            paddingVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: '${widget.data.program?.name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            onClick: () {},
            paddingVertical: 10,
            labelText: 'Бүтээгдэхүүн',
            secondText: '${widget.data.product?.name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Санхүүжилт хүссэн дүн',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: white,
            child: FormTextField(
              readOnly: true,
              hintText: 'Finance_Amount',
              name: "amount",
              initialValue: "${widget.data.requestedAmount?.toInt()}₮",
              inputType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: source.currentColor),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Санхүүжилт валют',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${currency()}',
                  style: TextStyle(color: source.currentColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Нөхцөл хангах байдал',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Боломжит доод дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.finMinAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Боломжит дээд дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.finMaxAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэхэмжлэх доод үлдэгдэл',
            secondText:
                '${Utils().formatCurrency(widget.data.minInvBalance.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэх min.тенор',
            secondText: '${widget.data.minTenor?.toInt()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэх max.тенор',
            secondText: '${widget.data.maxTenor?.toInt()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Санхүүжилт хоног',
            secondText: '${widget.data.product?.buyerTerm?.toInt()} хоног',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Шимтгэл тооцсон хувь',
            secondText:
                '${widget.data.calculatedFeePercent?.toStringAsFixed(6)}%',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Тооцсон шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.calculatedFeeAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Өргөдөл хураамж',
            secondText:
                '${Utils().formatCurrency(widget.data.appFee.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Олголт шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.disbursementFee.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нийт шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.totalScfFeeAmount.toString())}₮',
            secondTextColor: source.currentColor,
            secondTextFontWeight: FontWeight.bold,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Шимтгэл дүрэм',
            secondText: feeRule(),
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Шимтгэл доод дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.minFeeAmount.toString()) + symbol()}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Эргэн төлөх хугацаа',
            secondText: '',
            // DateFormat('yyyy-MM-dd').format(
            //   widget.data.invPaymentDate!.add(Duration(
            //     days: widget.data.product!.buyerTerm!.toInt(),
            //   )),
            // ),
            secondTextColor: source.currentColor,
            color: white,
          ),
          if (user.currentBusiness?.type == "SUPPLIER")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Буцаан дуудах эсэх',
                    style: TextStyle(color: dark),
                  ),
                  CustomSwitch(
                    color: const Color(0xff151357),
                    isDefault: widget.data.recourseTerm,
                  ),
                ],
              ),
            ),
          if (widget.data.recourseTerm == true &&
              user.currentBusiness?.type == "SUPPLIER")
            FieldCard(
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: 'Буцаан дуудах огноо',
              secondText:
                  DateFormat("yyyy-MM-dd").format(widget.data.recourseDate!),
              secondTextColor: source.currentColor,
              color: white,
            ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Ху.Хэтрэлт алданги',
            secondText:
                '${Utils().formatCurrency(widget.data.penaltyPercent.toString())}%',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Алдангийн арга',
            secondText: penaltyType(),
            secondTextColor: source.currentColor,
            color: white,
          ),
          // FieldCard(
          //   paddingHorizontal: 15,
          //   paddingVertical: 10,
          //   labelText: 'Эргэн төлөх дүрэм',
          //   secondText: '',
          //   secondTextColor: source.currentColor,
          //   color: white,
          // ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Нэхэмжлэх хугацаа',
            secondText: "${widget.data.invConfirmedDays?.toInt()} хоног",
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хугацааны Min шалгуур',
            secondText: '${widget.data.minDays?.toInt()} хоног',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хугацааны Max шалгуур',
            secondText: '${widget.data.maxDays?.toInt()} хоног',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Хугацаа хэтрэлт',
            secondText: "${overdue().name}",
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Санхүүжилт авах данс',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дансны дугаар',
            secondText: '${widget.data.receiverBusinessAcc?.number}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Дансны нэр',
            secondText: '${widget.data.receiverBusinessAcc?.name}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: 'Банкны нэр',
            secondText: '${widget.data.receiverBusinessAcc?.bankName}',
            secondTextColor: source.currentColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Хавсаргасан файл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.data.requestFiles!.isNotEmpty)
            Column(
              children: widget.data.requestFiles!
                  .map(
                    (data) => GestureDetector(
                      onTap: () {
                        launchUrl(data.url!);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        color: white,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.downloading_rounded,
                              size: 26,
                              color: Color(0xff151357),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Хавсаргасан файл №${widget.data.requestFiles!.indexOf(data) + 1}',
                              style: const TextStyle(
                                color: Color(0xff151357),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  requestStatus() {
    final res = general.scfRequestStatus!
        .firstWhere((element) => element.code == widget.data.requestStatus);
    return res;
  }

  requestType() {
    final res = general.scfRequestTypes!
        .firstWhere((element) => element.code == widget.data.type)
        .name;
    return res;
  }

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .name;
    return res;
  }

  symbol() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency)
        .symbol;
    return res;
  }
}
