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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'images/close.svg',
                  color: grey2,
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Image(
            image: AssetImage(
              'images/invoice_pdf.png',
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
                  'images/save1.svg',
                  color: grey3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
