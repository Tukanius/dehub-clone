import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class INVOICEPDF extends StatefulWidget {
  final Invoice data;
  final List<Invoice> lines;
  const INVOICEPDF({
    super.key,
    required this.lines,
    required this.data,
  });

  @override
  State<INVOICEPDF> createState() => _INVOICEPDFState();
}

class _INVOICEPDFState extends State<INVOICEPDF> {
  Invoice supplierBusiness = Invoice();
  Invoice buyerBusiness = Invoice();
  Invoice supplierAcc = Invoice();
  Invoice buyerAcc = Invoice();
  User user = User();

  @override
  void initState() {
    if (widget.data.type == "SALES") {
      setState(() {
        supplierBusiness = widget.data.senderBusiness!;
        buyerBusiness = widget.data.receiverBusiness!;
        supplierAcc = widget.data.senderAcc!;
        buyerAcc = widget.data.receiverAcc!;
      });
    } else {
      setState(() {
        buyerBusiness = widget.data.senderBusiness!;
        supplierBusiness = widget.data.receiverBusiness!;
        buyerAcc = widget.data.senderAcc!;
        supplierAcc = widget.data.receiverAcc!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.shade400,
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        color: invoiceColor,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Төлбөр хүлээж буй',
                          style: TextStyle(
                            color: white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Нэхэмжлэх №',
                                  style: TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.data.refCode}',
                                  style: const TextStyle(
                                    color: invoiceColor,
                                    fontSize: 7,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Захиалга №',
                                  style: TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'INV-23492374',
                                  style: TextStyle(
                                    color: invoiceColor,
                                    fontSize: 7,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Худалдан авагч',
                                  style: TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.profileName}',
                                  style: const TextStyle(
                                    color: invoiceColor,
                                    fontSize: 7,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Нийлүүлэгч',
                                  style: TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.profileName}',
                                  style: const TextStyle(
                                    color: invoiceColor,
                                    fontSize: 7,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text(
                    'Сангийн сайдын 2017 оны 347 дугаар тушаалын хавсралт №',
                    style: TextStyle(
                      fontSize: 6,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'НЭХЭМЖЛЭХ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'ДДТД: Энд ебаримт холбогдохоор код гарах байх',
            style: TextStyle(fontSize: 7),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Нэхэмжлэгч',
                      style:
                          TextStyle(fontSize: 7, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ТТД: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.regNumber}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Нэр: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.partner?.businessName}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Хаяг: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.partner?.businessAddress}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Утас: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.partner?.phone}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Э-шуудан: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierBusiness.partner?.email}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Банкны нэр: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierAcc.bankName}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Банкны дансны дугаар: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${supplierAcc.number}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Хариуцагч',
                      style:
                          TextStyle(fontSize: 7, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ТТД: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.regNumber}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Нэр: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.partner?.businessName}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Хаяг: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.partner?.businessAddress}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Утас: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.partner?.phone}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Э-шуудан: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerBusiness.partner?.email}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Банкны нэр: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerAcc.bankName}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Банкны дансны дугаар: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${buyerAcc.number}',
                                  style: const TextStyle(
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: invoiceColor,
            thickness: 1,
          ),
          Table(
            border: const TableBorder(
              horizontalInside: BorderSide(
                color: Color(0xffb9b9b9),
                width: 0.5,
              ),
              verticalInside: BorderSide(
                color: Color(0xffb9b9b9),
                width: 0.5,
              ),
              top: BorderSide(
                color: Color(0xffb9b9b9),
                width: 0.5,
              ),
              left: BorderSide(
                color: Color(0xffb9b9b9),
                width: 0.5,
              ),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.3),
              2: FractionColumnWidth(0.105),
              3: FractionColumnWidth(0.14),
              4: FractionColumnWidth(0.12),
              5: FractionColumnWidth(0.145),
              6: FractionColumnWidth(0.14),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xfff0f0f0)),
                children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        '№',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Бараа, ажил үйлчилгээний нэр',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Код',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Хэмжих нэгж',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Тоо хэмжээ',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Нэгжийн үнэ',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Бүгд үнэ',
                        style: TextStyle(
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...List.generate(
                widget.lines.length,
                (index) => TableRow(
                  decoration: const BoxDecoration(color: white),
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${widget.lines[index].name}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${widget.lines[index].skuCode}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${widget.lines[index].unit?.toLowerCase()}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${Utils().formatCurrency(widget.lines[index].quantity.toString())}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${Utils().formatCurrency(widget.lines[index].price.toString())}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${Utils().formatCurrency((widget.lines[index].quantity! * widget.lines[index].price!).toString())}',
                          style: const TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: invoiceColor,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 7,
                    child: Text(
                      'Бараа ажил, үйлчилгээний үнэ:',
                      style: TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${Utils().formatCurrency((widget.lines.fold(0.0, (previousValue, element) => previousValue + element.price!).toString()))}₮',
                      style: const TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 7,
                    child: Text(
                      'Нэмэгдсэн өртгийн албан татвар:',
                      style: TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${Utils().formatCurrency((widget.lines.fold(0.0, (previousValue, element) => previousValue + element.vatAmount!).toString()))}₮',
                      style: const TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 7,
                    child: Text(
                      'Нийслэл хотын албан татвар:',
                      style: TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${Utils().formatCurrency((widget.lines.fold(0.0, (previousValue, element) => previousValue + element.taxAmount!).toString()))}₮',
                      style: const TextStyle(
                        fontSize: 7,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '         ${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'ЗАХИАЛГА БАТАЛГААЖУУЛАХ',
                style: TextStyle(
                  color: invoiceColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${widget.data.description}',
            style: const TextStyle(
              color: invoiceColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: const Text(
              'Дансаар төлөх бол гүйлгээний утгад НЭХЭМЖЛЭХ ДУГААР-г бичнэ үү',
              style: TextStyle(
                fontSize: 8,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
