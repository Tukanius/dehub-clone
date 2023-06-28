import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ZoningDetailPageArguments {
  String id;
  ZoningDetailPageArguments({
    required this.id,
  });
}

class ZoningDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/ZoningDetailPage';
  const ZoningDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ZoningDetailPage> createState() => _ZoningDetailPageState();
}

class _ZoningDetailPageState extends State<ZoningDetailPage>
    with AfterLayoutMixin {
  ReferenceInformationGet reference = ReferenceInformationGet();
  bool isLoading = true;
  @override
  afterFirstLayout(BuildContext context) async {
    reference = await BusinessApi().distrbutionAreaGet(widget.id);
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
        iconTheme: IconThemeData(color: networkColor),
        title: Text(
          'Бүсчлэл',
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
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүсийн код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${reference.refCode}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
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
                          'Нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${reference.name}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
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
                          'Тайлбар',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            '${reference.description}',
                            style: TextStyle(
                              color: networkColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
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
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Username',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
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
                          'И-мэйл хаяг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'MailAddress',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
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
                          'Бүртгэсэн огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Огноо, цаг',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
