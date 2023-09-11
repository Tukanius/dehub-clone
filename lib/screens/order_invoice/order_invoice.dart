import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderInvoice extends StatefulWidget {
  static const routeName = '/OrderInvoice';
  const OrderInvoice({Key? key}) : super(key: key);

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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Нэхэмжлэх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                'Нэхэмжлэхийн хугацаанаас нь өмнө төлөөрэй. Хамтын ажиллагаанд баярлалаа',
                style: TextStyle(
                  color: grey2,
                  fontSize: 12,
                ),
              ),
            ),
            Image(
              image: AssetImage('images/pdf.jpg'),
            ),
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
                  child: Icon(
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
                    'images/save1.svg',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              onClick: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
