import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class RankDetailPageArguments {
  String id;
  RankDetailPageArguments({
    required this.id,
  });
}

class RankDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/RankDetailPage';
  const RankDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RankDetailPage> createState() => _RankDetailPageState();
}

class _RankDetailPageState extends State<RankDetailPage> with AfterLayoutMixin {
  ReferenceInformationGet invitation = ReferenceInformationGet();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invitation = await BusinessApi().clientClassificationGet(widget.id);
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
          'Зэрэглэл нэр, код',
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
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ангилал код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Ангилал код',
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
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Ангилалын нэр',
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
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Зэрэглэл код',
                          style: TextStyle(color: dark),
                        ),
                        invitation.refCode != null
                            ? Text(
                                '${invitation.refCode}',
                                style: TextStyle(
                                  color: networkColor,
                                ),
                              )
                            : Text(
                                '-',
                                style: TextStyle(
                                  color: networkColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Зэрэглэл',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${invitation.name}',
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
                        vertical: 15, horizontal: 15),
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
                            '${invitation.description}',
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
                        vertical: 15, horizontal: 15),
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
                        vertical: 15, horizontal: 15),
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
                        vertical: 15, horizontal: 15),
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
                        vertical: 15, horizontal: 15),
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