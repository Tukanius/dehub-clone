import 'package:dehub/components/reference_information_card/reference_information_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReferenceInformationPage extends StatefulWidget {
  static const routeName = 'ReferenceInformationPage';
  const ReferenceInformationPage({super.key});

  @override
  State<ReferenceInformationPage> createState() =>
      _ReferenceInformationPageState();
}

class _ReferenceInformationPageState extends State<ReferenceInformationPage> {
  List<String> labelText = [
    'Бэлэнгийн нөхцөл',
    "Нэхэмжлэх нөхцөл",
    "Авлагын нөхцөл",
    "Бүсчлэл",
    "Чиглэл",
    "Ангилал",
    "Зэрэглэл",
  ];

  List<Object> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: networkColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: networkColor,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Network удирдлага',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              width: 90,
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: networkColor,
                    ),
                    child: SvgPicture.asset(
                      'images/bag.svg',
                      color: white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Лавлах мэдээлэл',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            for (var i = 0; i < labelText.length; i++)
              ReferenceInformationCard(
                labelText: labelText[i],
                index: i,
              ),
          ],
        ),
      ),
    );
  }
}
