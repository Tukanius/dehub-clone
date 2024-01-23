import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/src/order_module/screens/order_invoice/pdf/pdf.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderInvoiceArguments {
  List<Order> lines;
  Invoice data;
  OrderInvoiceArguments({
    required this.data,
    required this.lines,
  });
}

class OrderInvoice extends StatefulWidget {
  final List<Order> lines;
  final Invoice data;
  static const routeName = '/OrderInvoice';
  const OrderInvoice({
    super.key,
    required this.lines,
    required this.data,
  });

  @override
  State<OrderInvoice> createState() => _OrderInvoiceState();
}

class _OrderInvoiceState extends State<OrderInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Нэхэмжлэх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const CustomCloseButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: const Text(
                'Нэхэмжлэхийн хугацаанаас нь өмнө төлөөрэй. Хамтын ажиллагаанд баярлалаа',
                style: TextStyle(
                  color: grey2,
                  fontSize: 12,
                ),
              ),
            ),
            PDF(
              lines: widget.lines,
              data: widget.data,
            ),
            const SizedBox(
              height: 25,
            ),
            // Image(
            //   image: AssetImage('images/pdf.jpg'),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: grey2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share_outlined,
                    color: grey2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: grey2),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/save1.svg',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onClick: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              labelColor: orderColor,
              textColor: white,
              labelText: "Ойлголоо",
            ),
          ],
        ),
      ),
    );
  }
}
