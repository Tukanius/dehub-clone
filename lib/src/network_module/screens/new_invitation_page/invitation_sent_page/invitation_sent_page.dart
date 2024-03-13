import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/src/network_module/components/partner_cards/business_suggest_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
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
    super.key,
    required this.listenController,
    required this.invitationType,
    required this.data,
  });

  @override
  State<InvitationSentPage> createState() => _InvitationSentPageState();
}

class _InvitationSentPageState extends State<InvitationSentPage>
    with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  User user = User();
  int page = 1;
  int limit = 10;
  Result business = Result(rows: [], count: 0);
  bool isLoading = true;
  Business invitation = Business();
  List<String> receiverIds = [];
  bool isLineEmpty = false;

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
    if (receiverIds.isEmpty) {
      show(context);
    } else {
      onSubmit(send);
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
                child: const Text(
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
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      invitation.toMessage = "invite";
      invitation.send = send;
      invitation.receiverIds = receiverIds;
      invitation.toMessage = controller.text;
      await BusinessApi().createInvitation(invitation);
      loading.loading(false);
      widget.listenController.changeVariable('invitationSent');
      showCustomDialog(
        context,
        "Урилга амжилттай илгээгдлээ",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  void initState() {
    controller.text =
        'Сайн байна уу, Тантай DeHUB бизнесийн сүлжээнд холбогдож, хамтран ажиллах хүсэлтэй байна.';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset('assets/svg/close.svg'),
          ),
        ),
        title: const Text(
          'Урилга илгээх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Урилга мэдээлэл',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: grey3),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: const Row(
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
                        const Text(
                          'Илгээсэн огноо, цаг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd").format(DateTime.now()),
                          style: const TextStyle(
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
                        const Text(
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
                          child: const Text(
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
                    child: const Text(
                      'Урилга илгээгч',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: grey3),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Партнер нэр',
                    labelTextColor: dark,
                    secondText: user.currentBusiness?.partnerName,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Партнер код',
                    labelTextColor: dark,
                    secondText: user.partner?.refCode,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Татвар төлөгч №',
                    labelTextColor: dark,
                    secondText: user.partner?.regNumber,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Бизнесийн нэр',
                    labelTextColor: dark,
                    secondText: user.currentBusiness?.profileName,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Бизнес код',
                    labelTextColor: dark,
                    secondText: user.currentBusiness?.refCode,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Илгээсэн ажилтан',
                    labelTextColor: dark,
                    secondText: user.firstName,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: white,
                    child: const Row(
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
                  FieldCard(
                    paddingHorizontal: 10,
                    paddingVertical: 10,
                    labelText: 'Урилга төрөл',
                    labelTextColor: dark,
                    secondText: widget.invitationType,
                    secondTextColor: networkColor,
                    color: white,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Урилгын тайлбар',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: FormTextField(
                      controller: controller,
                      textAlign: TextAlign.left,
                      name: 'toMessage',
                      maxLines: 5,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: grey),
                        ),
                        fillColor: white,
                        filled: true,
                        hintStyle: TextStyle(
                          color: grey2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: business.rows!
                        .map(
                          (item) => BusinessSuggestCard(
                            receiverIds: receiverIds,
                            data: item,
                          ),
                        )
                        .toList(),
                  ),
                  if (isLineEmpty == true)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: const Text(
                        'Харилцагч сонгоно уу!',
                        style: TextStyle(color: red),
                      ),
                    ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }
}
