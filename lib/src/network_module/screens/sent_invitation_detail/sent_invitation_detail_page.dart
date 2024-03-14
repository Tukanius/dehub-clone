import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
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
    super.key,
    required this.id,
  });

  @override
  SentInvitationDetailState createState() => SentInvitationDetailState();
}

class SentInvitationDetailState extends State<SentInvitationDetail>
    with AfterLayoutMixin {
  Invitation invitation = Invitation();
  General general = General();
  User user = User();
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

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      Invitation respond = Invitation();
      respond.accept = true;
      respond.responseMessage = 'accept';
      await BusinessApi().send(invitation.id!);
      loading.loading(false);
      showCustomDialog(context, "Урилга амжилттай илгээлээ", true,
          onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Илгээсэн урилга',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: networkColor,
          ),
        ),
      ),
      body: isLoading != false
          ? const Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 20),
                    child: const Text(
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
                        const Text(
                          'Урилга №: ',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${invitation.refCode}',
                          style: const TextStyle(
                            color: networkColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Ирсэн огноо',
                    secondText: invitation.invitedDate != null
                        ? DateFormat("yyyy-MM-dd")
                            .format(invitation.invitedDate!)
                        : '-',
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
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
                    child: const Text(
                      'УРИЛГА ИЛГЭЭГЧ',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Партнерийн нэр',
                    secondText: invitation.sender?.partnerName,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Партнер код',
                    secondText: invitation.sender?.partner?.refCode,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бизнесийн нэр',
                    secondText: invitation.sender?.profileName,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бизнес код',
                    secondText: invitation.sender?.refCode,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Buyer роль',
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? "Үгүй"
                        : "Тийм",
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Supplier роль',
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? "Тийм"
                        : "Үгүй",
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Урьсан ажилтан',
                    secondText: invitation.senderUser?.firstName,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Урьсан и-мэйл хаяг',
                    secondText: invitation.senderUser?.email,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Урьсан утас',
                    secondText: invitation.senderUser?.phone,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Санхүү ажилтан',
                    secondText: invitation.senderFinStaff?.firstName,
                    secondTextColor: networkColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Урилгын тайлбар',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'УРИЛГА ХҮЛЭЭН АВАГЧ',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Партнерийн нэр',
                    secondText: invitation.receiver?.partnerName,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Партнер код',
                    secondText: invitation.receiver?.refCode,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Татвар төлөгч №',
                    secondText: invitation.receiver?.regNumber,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бизнесийн нэр',
                    secondText: invitation.receiver?.profileName,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Бизнес код',
                    secondText: invitation.receiver?.refCode,
                    secondTextColor: networkColor,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (invitation.invitationStatus == "DRAFT")
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            borderColor: networkColor,
                            labelText: 'Буцах',
                            labelColor: white,
                            textColor: networkColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: CustomButton(
                            onClick: onSubmit,
                            labelText: 'Илгээх',
                            labelColor: networkColor,
                            textColor: white,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  if (invitation.invitationStatus == "DRAFT")
                    const SizedBox(
                      height: 50,
                    ),
                ],
              ),
            ),
    );
  }
}
