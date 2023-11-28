import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/partner_cards/business_suggest_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class InvitationSentPageArguments {
  ListenController listenController;
  Business data;
  String invitationType;
  InvitationSentPageArguments({
    required this.listenController,
    required this.data,
    required this.invitationType,
  });
}

class InvitationSentPage extends StatefulWidget {
  final ListenController listenController;
  final Business data;
  final String invitationType;
  static const routeName = '/InvitationSentPage';
  const InvitationSentPage({
    Key? key,
    required this.listenController,
    required this.invitationType,
    required this.data,
  }) : super(key: key);

  @override
  State<InvitationSentPage> createState() => _InvitationSentPageState();
}

class _InvitationSentPageState extends State<InvitationSentPage>
    with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  Partner partner = Partner();
  int page = 1;
  int limit = 10;
  Result business = Result(rows: [], count: 0);
  bool isLoading = true;
  Business invitation = Business();
  List<String> receiverIds = [];
  bool isLineEmpty = false;
  bool isSubmit = false;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(partnerId: widget.data.partnerId);
    var res = await BusinessApi()
        .businessSuggest(ResultArguments(filter: filter, offset: offset));
    setState(() {
      business = res;
      isLoading = false;
    });
  }

  save(bool send) async {
    if (isSubmit == false) {
      if (receiverIds.isEmpty) {
        show(context);
      } else {
        onSubmit(send);
      }
    }
  }

  show(ctx) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Харилцагч сонгоно уу!'),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 15, bottom: 5),
              child: GestureDetector(
                child: Text(
                  'Ойлголоо',
                  style: TextStyle(color: red),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  onSubmit(bool send) async {
    try {
      setState(() {
        isLoading = true;
      });
      invitation.toMessage = "invite";
      invitation.send = send;
      invitation.receiverIds = receiverIds;
      invitation.toMessage = controller.text;
      await BusinessApi().createInvitation(invitation);
      widget.listenController.changeVariable('invitationSent');
      showCustomDialog(
        context,
        "Урилга амжилттай илгээгдлээ",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('================err=============');
      debugPrint(e.toString());
      debugPrint('================err=============');
    }
  }

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: false).partnerUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset('assets/svg/close.svg'),
          ),
        ),
        title: Text(
          'Урилга илгээх',
          style: TextStyle(
            fontSize: 16,
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
                      'Урилга мэдээлэл',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: grey3),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урилга №',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Авто үүснэ',
                          style: TextStyle(
                            color: networkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Илгээсэн огноо, цаг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                          style: TextStyle(
                            color: dark,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
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
                            borderRadius: BorderRadius.circular(20),
                            color: grey2.withOpacity(0.1),
                          ),
                          child: Text(
                            'Түр төлөв',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Урилга илгээгч',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: grey3),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнер нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.user?.currentBusiness?.partnerName}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Партнер код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.partner?.refCode}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Татвар төлөгч №',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.partner?.regNumber}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнесийн нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.partner?.businessName}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнес код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.user?.currentBusiness?.refCode}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Илгээсэн ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${partner.user?.firstName}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
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
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Урилга төрөл',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${widget.invitationType}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Урилгын тайлбар',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: grey3),
                    ),
                  ),
                  FormTextField(
                    controller: controller,
                    textColor: networkColor,
                    name: 'description',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      hintText: 'Тайлбар оруулна уу',
                      hintStyle: TextStyle(color: networkColor),
                      fillColor: white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: business.rows!
                        .map(
                          (item) => BusinessSuggestCard(
                            receiverIds: receiverIds,
                            onClick: () {},
                            data: item,
                          ),
                        )
                        .toList(),
                  ),
                  isLineEmpty == true
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Text(
                            'Харилцагч сонгоно уу!',
                            style: TextStyle(color: red),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 2),
                          child: CustomButton(
                            borderColor: networkColor,
                            textColor: networkColor,
                            onClick: () {
                              save(false);
                            },
                            labelColor: backgroundColor,
                            labelText: 'Хадгалах',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 3, right: 5),
                          child: CustomButton(
                            onClick: () {
                              save(true);
                            },
                            labelColor: networkColor,
                            labelText: 'Илгээх',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }
}
