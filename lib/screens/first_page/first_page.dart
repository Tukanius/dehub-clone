import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/modules_card/modules_card.dart';
import 'package:dehub/components/schedule_card/schedule_card.dart';
import 'package:dehub/components/take_give_card/take_give_card.dart';
import 'package:dehub/components/tutorial_card/tutorial_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:after_layout/after_layout.dart';
import 'package:skeletons/skeletons.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/firstpage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AfterLayoutMixin {
  bool isNew = false;
  Partner partnerUser = Partner();
  Result invoice = Result(count: 0, rows: []);
  int page = 1;
  int limit = 50;
  bool isLoading = true;
  List<Invoice> filtered = [];

  show(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
          margin: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DeHUB платформд татай морил!',
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Та платформд бизнесээ төлөөлөх админаар бүртгүүлсэн байна. Та админ хэрэглэгчээр нэвтрэхдээ дараах мэдээллээр нэвтэрнэ. Мартуузаа',
                  style: TextStyle(color: buttonColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Нэвтрэх код',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: buttonColor.withOpacity(0.3),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    'PR-2132324',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Хэрэглэгчийн нэр',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: buttonColor.withOpacity(0.3),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Та байгууллагыг төлөөлөх админ хэрэглэгчийн хувьд одоо ингэх ёстой',
                  style: TextStyle(color: buttonColor),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SvgPicture.asset('assets/svg/blue-star.svg'),
                ),
                Text(
                  'Хэрэглэгчийн зөвлөх',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Хэрэглэгчийн зөвлөх танд туслаад ингэнэ ингэнэ. йдыобрөйдылобрө',
                  style: TextStyle(color: buttonColor),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onClick: () {
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  },
                  labelColor: buttonColor,
                  labelText: 'Ок. Зөвлөгөө авъя.',
                  textColor: white,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Гэрээлэх алхамууд',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'йбдөлор йдылобөр  дйлыробөдлйы ор др йдлоырбө дл йдлыобрө',
                  style: TextStyle(color: buttonColor),
                ),
                SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(
                  'assets/svg/dollar-sign.svg',
                  color: Color(0xff1B5EAA),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', status: "SENT");
    var res = partnerUser.user?.currentBusiness?.type == "SUPPLIER"
        ? await InvoiceApi()
            .list(ResultArguments(filter: filter, offset: offset))
        : await InvoiceApi()
            .listReceived(ResultArguments(filter: filter, offset: offset));
    setState(() {
      invoice = res;
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    // show(context);
    await list(page, limit);
    invoice.rows!.map(
      (e) => e.paymentDate == DateTime.now() ? filtered.add(e) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return WillPopScope(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: buttonColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              SvgPicture.asset(
                'assets/svg/notification.svg',
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfilePage.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: partnerUser.user?.avatar == null
                        ? CircleAvatar(
                            radius: 14,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(
                                  'https://i0.wp.com/a.slack-edge.com/df10d/img/avatars/ava_0024-192.png?ssl=1',
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 14,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(
                                  '${partnerUser.user?.avatar}',
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: buttonColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${partnerUser.user?.currentBusiness?.partnerName}',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${partnerUser.user?.currentBusiness?.type}: ",
                                style: TextStyle(
                                  color: Color(0xffFEBC11),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${partnerUser.user?.currentBusiness?.partnerName}",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ModulesCard(
                      partner: partnerUser,
                    ),
                  ],
                ),
                partnerUser.user?.currentBusiness?.type == "BUYER" ||
                        partnerUser.user?.currentBusiness?.type == "SUPPLIER"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          filtered.isEmpty
                              ? SizedBox()
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  color: white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: partnerUser.user
                                                      ?.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? Text(
                                                  "Өнөөдөр хүлээлгэн өгөх",
                                                  style: TextStyle(
                                                    color: buttonColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              : Text(
                                                  "Өнөөдөр хүлээн авах",
                                                  style: TextStyle(
                                                    color: buttonColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            isLoading == true
                                                ? Row(
                                                    children:
                                                        [1, 2, 3, 4, 5, 6, 7]
                                                            .map(
                                                              (e) => Container(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        3),
                                                                child:
                                                                    SkeletonAvatar(
                                                                  style:
                                                                      SkeletonAvatarStyle(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    height: 50,
                                                                    width: 50,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                  )
                                                : Row(
                                                    children: filtered
                                                        .map(
                                                          (e) => TakeGiveCard(),
                                                        )
                                                        .toList(),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/dot-calendar.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '2023-03-23',
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ScheduleCard(),
                                    ScheduleCard(),
                                    ScheduleCard(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              'Батлах хүлээж буй',
                              style: TextStyle(
                                color: buttonColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD")}',
                              style: TextStyle(
                                color: blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          isLoading == true
                              ? SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                )
                              : Column(
                                  children: invoice.rows!
                                      .map(
                                        (e) => InvoiceCard(
                                          data: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              'DeHUB платформд тавтай морил!',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SvgPicture.asset('assets/svg/new-player.svg'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Та партнерийн тохиргоогоо бүрэн гүйцэт хийнэ үү',
                              style: TextStyle(color: buttonColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Заавартай танилцах',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TutorialCard(),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        final shoudPop = await showMyDialog();
        return shoudPop!;
      },
    );
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Та Апп-аас гарах гэж байна'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Болих'),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                  red.withOpacity(0.1),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Гарах',
                style: TextStyle(color: red),
              ),
            ),
          ],
        ),
      );
}
