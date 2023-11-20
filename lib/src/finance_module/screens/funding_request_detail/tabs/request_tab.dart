import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RequestTab extends StatefulWidget {
  final Finance data;
  const RequestTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  General general = General();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).financeGeneral;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Хүсэлтийн мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${widget.data.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${widget.data.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн код',
            secondText: '${requestType()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч код',
            secondText: '${widget.data.requestedBusiness?.refCode}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийлүүлэгч',
            secondText: '${widget.data.requestedBusiness?.profileName}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлт гаргасан',
            secondText: '${widget.data.requestedFinUser?.firstName}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хүсэлтийн огноо',
            secondText:
                '${DateFormat('yyyy-MM-dd').format(widget.data.createdAt!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хариу өгөх хугацаа',
            secondText:
                '${DateFormat('yyyy-MM-dd').format(widget.data.responseDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Хүсэлтийн төлөв',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: grey2, width: 1.5),
                  ),
                  child: Text(
                    '${requestStatus()}',
                    style: TextStyle(color: grey2, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            onClick: () {},
            marginVertical: 10,
            labelText: 'Хөтөлбөрийн нэр',
            secondText: '${widget.data.program?.name}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            onClick: () {},
            marginVertical: 10,
            labelText: 'Бүтээгдэхүүн',
            secondText: '${widget.data.product?.name}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Санхүүжилт олгох дүн',
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
              hintText: 'Finance_Amount',
              suffixIcon: Icon(
                Icons.edit_square,
                color: black,
              ),
              name: "amount",
              inputType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: financingColor),
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
                Text(
                  'Санхүүжилт валют',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${currency()}',
                  style: TextStyle(color: financingColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Нөхцөл хангах байдал',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Боломжилт доод дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.finMinAmount.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Боломжилт дээд дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.finMaxAmount.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэхэмжлэх доод үлдэгдэл',
            secondText:
                '${Utils().formatCurrency(widget.data.minInvBalance.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэх min.тенор',
            secondText: '${widget.data.minTenor?.toInt()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэх max.тенор',
            secondText: '${widget.data.maxTenor?.toInt()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжилт хоног',
            secondText: '${widget.data.remainingDays?.toInt()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Шимтгэл тооцсон хувь',
            secondText: '${widget.data.calculatedFeePercent?.toInt()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Тооцсон шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.calculatedFeeAmount.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Санхүүжих шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.scfFee.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Гүйлгээний шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.trxFee.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Өргөдөл хураамж',
            secondText:
                '${Utils().formatCurrency(widget.data.appFee.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Олголт шимтгэл',
            secondText:
                '${Utils().formatCurrency(widget.data.disbursementFee.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нийт шимтгэл',
            secondText: 'SUM_FEE',
            secondTextColor: financingColor,
            secondTextFontWeight: FontWeight.bold,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Шимтгэл дүрэм',
            secondText: '${widget.data.feeRule}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Шимтгэл дээд дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.maxFeeAmount.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Шимтгэл доод дүн',
            secondText:
                '${Utils().formatCurrency(widget.data.minFeeAmount.toString()) + symbol()}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Эргэн төлөх хугацаа',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Буцаан дуудах эсэх',
                  style: TextStyle(color: dark),
                ),
                CustomSwitch(
                  color: Color(0xff151357),
                  isDefault: true,
                ),
              ],
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Буцаан дуудах огноо',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Ху.Хэтрэлт алданги',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Алдангийн арга',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Эргэн төлөх дүрэм',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Нэхэмжлэх хугацаа',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацааны Min шалгуур',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацааны Max шалгуур',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Хугацаа хэтрэлт',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Санхүүжилт авах данс',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Дансны дугаар',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Дансны нэр',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          FieldCard(
            marginHorizontal: 15,
            marginVertical: 10,
            labelText: 'Банкны нэр',
            secondText:
                '${DateFormat("yyyy-MM-dd").format(widget.data.repaymentDate!)}',
            secondTextColor: financingColor,
            color: white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Гэрээ баталгаажилт',
              style: TextStyle(
                color: grey3,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.downloading_rounded,
                      size: 26,
                      color: Color(0xff151357),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Гэрээг уншиж зөвшөөрөх',
                      style: TextStyle(
                        color: Color(0xff151357),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Баталгаажилт',
                      style: TextStyle(
                        color: buttonColor,
                      ),
                    ),
                    Text(
                      'Баталгаажсан',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: neonGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  requestStatus() {
    final res = general.scfRequestStatus!
        .firstWhere((element) => element.code == widget.data.requestStatus)
        .name;
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
