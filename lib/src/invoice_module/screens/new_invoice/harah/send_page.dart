import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendPage extends StatefulWidget {
  final Invoice data;
  static const routeName = '/sendpage';
  const SendPage({
    super.key,
    required this.data,
  });

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: invoiceColor,
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              'assets/svg/close.svg',
            ),
          ),
        ),
        title: Text(
          '${widget.data.refCode} - илгээх',
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, left: 16, bottom: 10),
                  child: const Text(
                    'ХҮЛЭЭН АВАГЧ',
                    style: TextStyle(
                      color: grey3,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Buyer нэр'),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.data.receiverBusiness?.profileName}',
                                  style: const TextStyle(
                                    color: invoiceColor,
                                  ),
                                  textAlign: TextAlign.end,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('И-мэйл хаяг'),
                        Row(
                          children: [
                            Text(
                              '${widget.data.receiverBusiness?.partner?.email}',
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
                ],
              ),
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Нэхэмжлэх дүн'),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
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
                ],
              ),
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хавсралт'),
                        Row(
                          children: [
                            Text(
                              'Invoice-23987.PDF',
                              style: TextStyle(
                                color: invoiceColor,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: grey2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text(
                    'ИЛГЭЭГЧ',
                    style: TextStyle(
                      color: grey3,
                      fontSize: 14,
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
              padding: const EdgeInsets.only(
                left: 20,
              ),
              color: white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.perm_contact_cal_outlined,
                            color: invoiceColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.data.senderBusiness?.profileName}',
                            style: const TextStyle(color: invoiceColor),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: grey3,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Партнерийн нэр',
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.data.senderBusiness?.partner?.businessName}',
                            style: const TextStyle(color: invoiceColor),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: grey3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Салбарын нэр',
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.data.senderBranch?.name}',
                            style: const TextStyle(color: invoiceColor),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: grey3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text(
                    'Нэмж бичих зүйлс',
                    style: TextStyle(color: black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                labelText: 'Нэхэмжлэл илгээх',
                onClick: () {},
                labelColor: invoiceColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
