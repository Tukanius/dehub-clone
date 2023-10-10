import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:moment_dart/moment_dart.dart';

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
    Key? key,
    required this.listenController,
    required this.id,
  }) : super(key: key);

  @override
  _InvitationDetailPageState createState() => _InvitationDetailPageState();
}

class _InvitationDetailPageState extends State<InvitationDetailPage>
    with AfterLayoutMixin {
  bool isLoading = false;
  InvitationReceived invitation = InvitationReceived();
  InvitationReceived respond = InvitationReceived();
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

  onSubmit(bool accept) async {
    try {
      setState(() {
        isLoading = true;
      });
      respond.accept = accept;
      respond.responseMessage = 'accept';
      await BusinessApi().respond(respond, widget.id);
      showCustomDialog(
        context,
        accept == true ? "Амжилттай зөвшөөрлөө" : "Амжилттай татгалзлаа",
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      widget.listenController.changeVariable('refresh');
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
                          '${Moment.parse(invitation.createdAt.toString()).format("YYYY-MM-DD HH:mm")}',
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
                            invitationStatus(),
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
                          'И-мэйл хаяг',
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
                          'Утас',
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
                          'Buyer-с ирсэн',
                          style: TextStyle(color: dark),
                        ),
                        invitation.sender?.type == "BUYER"
                            ? Text(
                                'Тийм',
                                style: TextStyle(color: networkColor),
                              )
                            : Text(
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
                          'Supplier-с ирсэн',
                          style: TextStyle(color: dark),
                        ),
                        invitation.sender?.type == "SUPPLIER"
                            ? Text(
                                'Тийм',
                                style: TextStyle(color: networkColor),
                              )
                            : Text(
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урилга төрөл',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${invitation.type}',
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
                          '${invitation.receiver?.partner?.refCode}',
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
                          '${invitation.receiver?.profileName}',
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
                          '${invitation.receiver?.refCode}',
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
                                      onSubmit(false);
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
                                      onSubmit(true);
                                    },
                                    labelText: "Зөвшөөрөх",
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
