import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class DirectionDetailPageArguments {
  String id;
  DirectionDetailPageArguments({
    required this.id,
  });
}

class DirectionDetailPage extends StatefulWidget {
  final String id;
  static const routeName = 'DirectionDetailPage';
  const DirectionDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DirectionDetailPage> createState() => _DirectionDetailPageState();
}

class _DirectionDetailPageState extends State<DirectionDetailPage>
    with AfterLayoutMixin {
  ReferenceInformationGet referenceGet = ReferenceInformationGet();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    referenceGet = await BusinessApi().distrbutionAreaGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: networkColor),
        title: Text(
          'Чиглэл',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Тохиргоо',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бүсийн код',
                    secondText: 'Бүсийн код',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Нэр',
                    secondText: 'Бүсийн нэр',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Чиглэлийн код',
                    secondText: 'Чиглэлийн код',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Чиглэл нэр',
                    secondText: '${referenceGet.name}',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Тайлбар',
                    secondText: '${referenceGet.description}',
                    secondTextColor: networkColor,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Системийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Статус',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff01D462).withOpacity(0.1),
                          ),
                          child: Text(
                            'Идэвхтэй',
                            style: TextStyle(
                              color: Color(0xff01D462),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бүртгэсэн ажилтан',
                    secondText: 'Username',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'И-мэйл хаяг',
                    secondText: 'MailAddress',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бүртгэсэн огноо',
                    secondText:
                        '${DateFormat("yyyy-MM-dd").format(referenceGet.createdAt!)}',
                    secondTextColor: networkColor,
                  ),
                ],
              ),
            ),
    );
  }
}
