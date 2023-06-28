import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class SentInvitationDetailArguments {
  String id;
  SentInvitationDetailArguments({
    required this.id,
  });
}

class SentInvitationDetail extends StatefulWidget {
  final String id;
  static const routeName = '/SentInvitationDetail';
  const SentInvitationDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _SentInvitationDetailState createState() => _SentInvitationDetailState();
}

class _SentInvitationDetailState extends State<SentInvitationDetail>
    with AfterLayoutMixin {
  InvitationReceived invitation = InvitationReceived();
  bool isLoading = false;

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
          'Илгээсэн урилга',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: networkColor,
          ),
        ),
      ),
      body: isLoading != false
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
                          '${invitation.getInvitedDate()}',
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
                          'Урилга төлөв',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff38C0FE).withOpacity(0.1),
                          ),
                          child: Text(
                            '${invitation.invitationStatus}',
                            style: TextStyle(
                              color: Color(0xff38C0FE),
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
                          '${invitation.sender!.partnerName}',
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
                          '${invitation.sender!.refCode}',
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
                          '${invitation.sender!.partner!.businessName}',
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
                          '${invitation.sender!.partner!.refCode}',
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
                          '${invitation.senderUser!.firstName}',
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
                          '${invitation.senderUser!.email}',
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
                          '${invitation.senderUser!.phone}',
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
                          '${invitation.senderFinStaff!.firstName}',
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
                          color: grey3.withOpacity(0.3),
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
                          '${invitation.receiver!.refCode}',
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
                          '${invitation.receiver!.regNumber}',
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
                                  margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: networkColor,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      'Татгалзах',
                                      style: TextStyle(
                                        color: networkColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: networkColor,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      'Батлах',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
