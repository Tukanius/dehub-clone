import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class InvitationDetailPageArguments {
  String id;
  InvitationDetailPageArguments({
    required this.id,
  });
}

class InvitationDetailPage extends StatefulWidget {
  final String id;
  static const routeName = 'invitationdetailpage';
  const InvitationDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _InvitationDetailPageState createState() => _InvitationDetailPageState();
}

class _InvitationDetailPageState extends State<InvitationDetailPage>
    with AfterLayoutMixin {
  bool isLoading = false;
  InvitationReceived invitation = InvitationReceived();
  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    invitation = await BusinessApi().getInfo(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  approve() {
    try {
      var res = BusinessApi().respond(invitation, widget.id);
    } catch (e) {
      print('===============ERROR===============');
      print(e.toString());
      print('===============ERROR===============');
    }
  }

  refuse() {
    try {
      var res = BusinessApi().refuse(invitation, widget.id);
    } catch (e) {
      print('===============ERROR===============');
      print(e.toString());
      print('===============ERROR===============');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: networkColor,
          ),
        ),
        title: Text(
          'Ирсэн урилга',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: networkColor,
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
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 20),
                    child: Text(
                      'Урилга мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Урилга №: ',
                            style: TextStyle(color: dark),
                          ),
                        ),
                        Text(
                          '${invitation.refCode}',
                          style: TextStyle(
                            color: networkColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ирсэн огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '2023-04-08 16:24 PM',
                          style: TextStyle(color: dark),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
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
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff71717A).withOpacity(0.1),
                          ),
                          child: Text(
                            '${invitation.invitationStatus}',
                            style: TextStyle(
                              color: dark,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 20),
                    child: Text(
                      'УРИЛГА ИЛГЭЭГЧ',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнерийн нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'PartnerName',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнер код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'PartnerRef#',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнесийн нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'BusinessName',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнес код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'BusRef#',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Buyer роль',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Тийм',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Supplier роль',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Үгүй',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урьсан ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Username',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урьсан и-мэйл хаяг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'email',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урьсан утас',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Mobile',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Санхүү ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Username',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Урилгын тайлбар',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    height: 125,
                    color: white,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff636E72).withOpacity(0.3),
                        ),
                      ),
                      child: Text(''),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      'УРИЛГА ХҮЛЭЭН АВАГЧ',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнерийн нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'PartnerName',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнер код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'PartnerRef#',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Татвар төлөгч №',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'RegisterID',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнесийн нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'BusinessName',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнес код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'BusRef#',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  invitation.invitationStatus == "SENT"
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: networkColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: CustomButton(
                                    labelColor: backgroundColor,
                                    labelText: "Татгалзах",
                                    onClick: () {
                                      refuse();
                                    },
                                    textColor: networkColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: CustomButton(
                                    textColor: white,
                                    labelColor: networkColor,
                                    onClick: () {
                                      approve();
                                    },
                                    labelText: "Батлах",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
    );
  }
}
