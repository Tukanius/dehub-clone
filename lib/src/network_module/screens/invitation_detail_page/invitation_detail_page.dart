import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  Invitation invitation = Invitation();
  General general = General();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    invitation = await BusinessApi().getInfo(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  invitationStatus() {
    final result = general.invitationStatus!
        .firstWhere((element) => element.code == invitation.invitationStatus);
    return result;
  }

  statusColor(bool opacity) {
    if (opacity == false) {
      switch (invitation.invitationStatus) {
        case 'DRAFT':
          return grey;
        case 'SENT':
          return orange;
        case 'ACCEPTED':
          return green;
        case 'REJECTED':
          return red;
        default:
      }
    } else {
      switch (invitation.invitationStatus) {
        case 'DRAFT':
          return grey.withOpacity(0.1);
        case 'SENT':
          return orange.withOpacity(0.1);
        case 'ACCEPTED':
          return green.withOpacity(0.1);
        case 'REJECTED':
          return red.withOpacity(0.1);
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
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
                        Text(
                          'Урилга №: ',
                          style: TextStyle(color: dark),
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
                        invitation.invitedDate != null
                            ? Text(
                                '${DateFormat("yyyy-MM-dd").format(invitation.invitedDate!)}',
                                style: TextStyle(color: dark),
                              )
                            : Text(
                                '-',
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
                            color: statusColor(true),
                          ),
                          child: Text(
                            '${invitationStatus().name}',
                            style: TextStyle(
                              color: statusColor(false),
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
                          '${invitation.sender?.partnerName}',
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
                          '${invitation.sender?.refCode}',
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
                          '${invitation.sender?.partner?.businessName}',
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
                          '${invitation.sender?.partner?.refCode}',
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
                          '${invitation.senderUser?.firstName}',
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
                          '${invitation.senderUser?.email}',
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
                          '${invitation.senderUser?.phone}',
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
                          '${invitation.senderFinStaff?.firstName}',
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
                      child: Text('${invitation.toMessage}'),
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
                          '${invitation.receiver?.partnerName}',
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
                          '${invitation.receiver?.refCode}',
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
                          '${invitation.receiver?.regNumber}',
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
                          '${invitation.receiver?.partner?.businessName}',
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
                          '${invitation.receiver?.partner?.refCode}',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
    );
  }
}
