import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PaymentRegisterCard extends StatefulWidget {
  final Invoice data;
  final List<Invoice> list;
  final ListenController listenController;
  final double received;
  const PaymentRegisterCard({
    super.key,
    required this.received,
    required this.listenController,
    required this.list,
    required this.data,
  });

  @override
  State<PaymentRegisterCard> createState() => _PaymentRegisterCardState();
}

class _PaymentRegisterCardState extends State<PaymentRegisterCard> {
  double registered = 0;
  TextEditingController controller = TextEditingController();

  differential() {
    double difference = widget.received -
        widget.list.fold(
            0, (previousValue, element) => previousValue + element.amount!) +
        (double.tryParse(controller.text) ?? 0);
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    int index =
        widget.list.indexWhere((element) => element.id == widget.data.id);
    widget.data.amount ??= 0;
    return GestureDetector(
      onTap: () {
        if (index > -1) {
          setState(() {
            controller.text = '';
            registered = 0;
            widget.list.removeWhere((element) => element.id == widget.data.id);
          });
        } else {
          setState(() {
            widget.list.add(widget.data);
          });
        }
        widget.listenController.changeVariable('asdf');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.data.refCode}',
                    style: const TextStyle(
                      color: invoiceColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: invoiceColor,
                        width: 2,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    activeColor: invoiceColor,
                    value: index > -1,
                    onChanged: (value) {
                      if (index > -1) {
                        setState(() {
                          controller.text = '';
                          registered = 0;
                          widget.list.removeWhere(
                              (element) => element.id == widget.data.id);
                        });
                      } else {
                        setState(() {
                          widget.list.add(widget.data);
                        });
                      }
                      widget.listenController.changeVariable('asdf');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Төлөх: ${DateFormat('yyyy-MM-dd').format(widget.data.paymentDate!)}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Үлдсэн хоног: ${widget.data.remainingDays}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
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
                Expanded(
                  child: Text(
                    'Үлдэгдэл: ${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                      children: [
                        const TextSpan(
                          text: 'Үлдэх: ',
                        ),
                        TextSpan(
                          text:
                              '${Utils().formatCurrency((widget.data.amountToPay! - registered).toString())}₮',
                          style: TextStyle(
                            color: (widget.data.amountToPay! - registered) >= 0
                                ? green
                                : red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (index > -1)
              Row(
                children: [
                  const Text(
                    'Бүртгэх төлбөр:   ',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: FormTextField(
                      textAlign: TextAlign.end,
                      controller: controller,
                      name: 'asdf',
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          registered = double.tryParse(value) ?? 0;
                        });
                        widget.data.amount = double.tryParse(value) ?? 0;
                        widget.listenController.changeVariable('asdf');
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: grey2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: grey2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.data.amountToPay! < differential()) {
                        setState(() {
                          registered = widget.data.amountToPay!;
                          controller.text =
                              widget.data.amountToPay!.toInt().toString();
                        });
                      } else {
                        setState(() {
                          registered = differential();
                          controller.text = differential().toInt().toString();
                        });
                      }
                      widget.listenController.changeVariable('asdf');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: transparent,
                        border: Border.all(color: grey2),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/copy.svg',
                        colorFilter:
                            const ColorFilter.mode(grey2, BlendMode.srcIn),
                        height: 14,
                        width: 14,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
