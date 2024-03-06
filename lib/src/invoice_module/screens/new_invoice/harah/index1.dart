import 'package:dehub/components/goods_info_card/goods_info_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class Index1 extends StatefulWidget {
  final Invoice invoice;
  final bool isNewInvoice;
  static const routeName = '/index1';
  const Index1({
    required this.isNewInvoice,
    required this.invoice,
    super.key,
  });

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> with AfterLayoutMixin {
  User user = User();
  Invoice supplierBusiness = Invoice();
  Invoice buyerBusiness = Invoice();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    if (widget.isNewInvoice == false) {
      supplierBusiness = widget.invoice.type == "SALES"
          ? widget.invoice.senderBusiness!
          : widget.invoice.receiverBusiness!;
      buyerBusiness = widget.invoice.type == "SALES"
          ? widget.invoice.receiverBusiness!
          : widget.invoice.senderBusiness!;
    } else {
      buyerBusiness = widget.invoice.receiverBusiness!;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: invoiceColor,
            ),
          )
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontFamily: 'Montserrat', color: black),
                        children: [
                          TextSpan(
                            text:
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())} ',
                          ),
                          user.lastName != null
                              ? TextSpan(
                                  text: '${user.lastName?[0]}. ',
                                  style: const TextStyle(
                                    color: invoiceColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const TextSpan(),
                          TextSpan(
                            text: "${user.firstName} ",
                            style: const TextStyle(
                              color: invoiceColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: 'үүсгэсэн.'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 25, bottom: 10),
                    child: const Text(
                      'НЭХЭМЖЛЭХ',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'Нэхэмжлэх №',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.refCode == null
                                  ? const Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(
                                      '${widget.invoice.refCode}',
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
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
                              flex: 4,
                              child: Text(
                                'Бүртгэсэн',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                DateFormat("yyyy-MM-dd").format(DateTime.now()),
                                style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
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
                              flex: 4,
                              child: Text(
                                'Төлбөрийн сонголт',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.paymentTerm?.description !=
                                      null
                                  ? Text(
                                      '${widget.invoice.paymentTerm?.description}',
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : const Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
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
                              flex: 4,
                              child: Text(
                                'Нэхэмжлэх баталсан',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.createdAt != null
                                  ? Text(
                                      DateFormat("yyyy-MM-dd")
                                          .format(widget.invoice.createdAt!),
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : const Text(
                                      "-",
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
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
                              flex: 4,
                              child: Text(
                                'Төлөх сүүлийн өдөр',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8181A5),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 6,
                              child: widget.invoice.paymentDate != null
                                  ? Text(
                                      DateFormat("yyyy-MM-dd")
                                          .format(widget.invoice.paymentDate!),
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )
                                  : const Text(
                                      '-',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нэхэмжлэгч:',
                        style: TextStyle(
                          color: Color(0xff8181A5),
                        ),
                      ),
                      Text(
                        'Төлбөр төлөгч:',
                        style: TextStyle(
                          color: Color(0xff8181A5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: widget.isNewInvoice == false
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${supplierBusiness.partner?.businessName}',
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'ТТД: ${supplierBusiness.regNumber}',
                                      style: const TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.profileName}',
                                      style: const TextStyle(
                                        color: invoiceColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.partner?.email}',
                                      style: const TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${supplierBusiness.partner?.phone}',
                                      style: const TextStyle(color: black),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.partner?.businessName}',
                                      style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'ТТД: ${user.currentBusiness?.regNumber}',
                                      style: const TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.currentBusiness?.profileName}',
                                      style: const TextStyle(
                                        color: invoiceColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.partner?.email}',
                                      style: const TextStyle(
                                        color: black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${user.partner?.phone}',
                                      style: const TextStyle(color: black),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${buyerBusiness.partner?.businessName}',
                                style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ТТД: ${buyerBusiness.regNumber}',
                                style: const TextStyle(
                                  color: black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.profileName}',
                                style: const TextStyle(
                                  color: invoiceColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.partner?.email}',
                                style: const TextStyle(
                                  color: black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${buyerBusiness.partner?.phone}',
                                style: const TextStyle(color: black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GoodsInfoCard(
                    data: widget.invoice.lines!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Хөнгөлөлт'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.discountAmount.toString())} ₮',
                              style: const TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: grey2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Нийт дүн'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.itemsTotal.toString())} ₮',
                              style: const TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Тооцсон НӨАТ'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.vatAmount.toString())} ₮',
                              style: const TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Тооцсон НХАТ'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.taxAmount.toString())}₮',
                              style: const TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Хүргэлт төлбөр'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency("${widget.invoice.shippingAmount}")}₮',
                              style: const TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: grey2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.invoice.totalAmount.toString())} ₮',
                              style: const TextStyle(
                                color: invoiceColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
  }
}
