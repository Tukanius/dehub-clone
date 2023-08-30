import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/partner_cards/business_suggest_card.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:lottie/lottie.dart';

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

  showSuccess(ctx, String labeltext) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Амжилттай',
                      style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '${labeltext}',
                      textAlign: TextAlign.center,
                    ),
                    ButtonBar(
                      buttonMinWidth: 100,
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            "Буцах",
                            style: TextStyle(color: dark),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Lottie.asset('images/success.json', height: 150, repeat: false),
            ],
          ),
        );
      },
    );
  }

  validateCheck() async {
    if (receiverIds.isEmpty) {
      show(context);
    } else {
      onSubmit(true);
    }
  }

  save() async {
    if (receiverIds.isEmpty) {
      show(context);
    } else {
      onSubmit(false);
    }
  }

  show(ctx) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
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
      await BusinessApi().createInvitation(invitation);
      widget.listenController.changeVariable('invitationSent');
      showSuccess(
          context,
          send == true
              ? 'Урилга амжилттай илгээгдлээ'
              : "Урилга амжилттай хадгалагдлаа");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('================err=============');
      print(e.toString());
      print('================err=============');
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
            child: SvgPicture.asset('images/close.svg'),
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
                          '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: networkColor),
                          ),
                          child: CustomButton(
                            textColor: networkColor,
                            onClick: () {
                              if (isSubmit == false) {
                                save();
                              }
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
                              if (isSubmit == false) {
                                validateCheck();
                              }
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
