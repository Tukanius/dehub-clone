import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PdfPage extends StatefulWidget {
  static const routeName = '/pdfpage';
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  show(context) {
    showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dismissible(
          onDismissed: (direction) {
            Navigator.of(context).pop();
          },
          direction: DismissDirection.vertical,
          key: GlobalKey(),
          child: Container(
            child: Image(
              image: AssetImage('images/invoice_pdf.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/close.svg',
                    colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                show(context);
              },
              child: Image(
                image: AssetImage(
                  'images/invoice_pdf.png',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 0.5, color: grey3),
                  ),
                  child: Icon(
                    Icons.share_outlined,
                    color: grey3,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 0.5, color: grey3),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/save1.svg',
                    colorFilter: ColorFilter.mode(grey3, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}