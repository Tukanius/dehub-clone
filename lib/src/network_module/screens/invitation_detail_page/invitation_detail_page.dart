import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvitationDetailPageArguments {
  ListenController listenController;
  String id;
  InvitationDetailPageArguments({
    required this.listenController,
    required this.id,
  });
}

class InvitationDetailPage extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/invitationdetailpage';
  const InvitationDetailPage({
    super.key,
    required this.listenController,
    required this.id,
  });

  @override
  InvitationDetailPageState createState() => InvitationDetailPageState();
}

class InvitationDetailPageState extends State<InvitationDetailPage>
    with AfterLayoutMixin {
  bool isLoading = true;
  Invitation invitation = Invitation();
  Invitation respond = Invitation();
  List<Invitation> list = [];
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    invitation = await BusinessApi().getInfo(widget.id);
    list = [
      Invitation(
        firstName: 'Урилга №',
        lastName: invitation.refCode,
      ),
    ];
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
      respond.accept = true;
      respond.responseMessage = 'accept';
      await BusinessApi().respond(respond, widget.id);
      widget.listenController.changeVariable('refresh');
      showCustomDialog(
        context,
        "Амжилттай зөвшөөрлөө",
        true,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('===============ERROR===============');
      debugPrint(e.toString());
      debugPrint('===============ERROR===============');
    }
  }

  invitationStatus() {
    switch (invitation.invitationStatus) {
      case "DRAFT":
        return "Түр төлөв";
      case "SENT":
        return "Илгээгдсэн";
      case "ACCEPTED":
        return "Зөвшөөрсөн";
      case "REJECTED":
        return "Цуцлагдсан";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: white,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Ирсэн урилга',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: networkColor,
          ),
        ),
      ),
      body: isLoading == true
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ирсэн огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd hh:MM")
                              .format(invitation.createdAt!),
                          style: const TextStyle(color: dark),
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
                        const Text(
                          'Статус',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff71717A).withOpacity(0.1),
                          ),
                          child: Text(
                            invitationStatus(),
                            style: const TextStyle(
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
                    paddingVertical: 15,
                    labelText: 'Партнерийн нэр',
                    secondText: '${invitation.sender?.partnerName}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Партнер код',
                    secondText: '${invitation.sender?.partner?.refCode}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Бизнесийн нэр',
                    secondText: '${invitation.sender?.partner?.businessName}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Бизнес код',
                    secondText: '${invitation.sender?.refCode}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Урьсан ажилтан',
                    secondText: '${invitation.senderUser?.firstName}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'И-мэйл хаяг',
                    secondText: '${invitation.senderUser?.email}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Утас',
                    secondText: '${invitation.senderUser?.phone}',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Buyer-с ирсэн',
                    secondText:
                        invitation.sender?.type == "BUYER" ? 'Тийм' : 'Үгүй',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Supplier-с ирсэн',
                    secondText:
                        invitation.sender?.type == "SUPPLIER" ? 'Тийм' : 'Үгүй',
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Санхүү ажилтан',
                    secondText: "${invitation.senderFinStaff?.firstName}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Урилга төрөл',
                    secondText: "${invitation.type}",
                    secondTextColor: networkColor,
                    color: white,
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
                    paddingVertical: 15,
                    labelText: 'Партнерийн нэр',
                    secondText: "${invitation.receiver?.partnerName}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Партнер код',
                    secondText: "${invitation.receiver?.partner?.refCode}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Татвар төлөгч №',
                    secondText: "${invitation.receiver?.regNumber}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Бизнесийн нэр',
                    secondText: "${invitation.receiver?.profileName}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: 'Бизнес код',
                    secondText: "${invitation.receiver?.refCode}",
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (invitation.invitationStatus == "SENT" &&
                      Permission().check(user, "NET_INV_RES"))
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: CustomButton(
                                borderColor: networkColor,
                                labelColor: backgroundColor,
                                labelText: "Татгалзах",
                                onClick: () {
                                  // onSubmit(false);
                                },
                                textColor: networkColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: CustomButton(
                                textColor: white,
                                labelColor: networkColor,
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    PinCheckScreen.routeName,
                                    arguments: PinCheckScreenArguments(
                                      onSubmit: () {
                                        onSubmit();
                                      },
                                      color: networkColor,
                                      labelText: 'Урилга баталгаажуулалт',
                                    ),
                                  );
                                },
                                labelText: "Зөвшөөрөх",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
