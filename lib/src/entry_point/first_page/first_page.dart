import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/src/invoice_module/components/invoice_card/invoice_card.dart';
import 'package:dehub/components/modules_card/modules_card.dart';
import 'package:dehub/components/schedule_card/schedule_card.dart';
// import 'package:dehub/components/start_dialog/start_dialog.dart';
import 'package:dehub/components/tutorial_card/tutorial_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/profile/profile_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';
import 'package:skeletons/skeletons.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/firstpage';
  const FirstPage({
    super.key,
  });

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> with AfterLayoutMixin {
  bool isNew = false;
  Partner partnerUser = Partner();
  Result invoice = Result(count: 0, rows: []);
  int page = 1;
  int limit = 50;
  bool isLoading = true;
  List<Invoice> filtered = [];
  User user = User();
  bool startAnimation = false;
  General general = General();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', status: "SENT");
    var res = user.currentBusiness?.type == "SUPPLIER"
        ? await InvoiceApi()
            .list(ResultArguments(filter: filter, offset: offset))
        : await InvoiceApi()
            .listReceived(ResultArguments(filter: filter, offset: offset));
    setState(() {
      invoice = res;
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  afterFirstLayout(BuildContext context) async {
    // showStartDialog(context);
    if (user.loginType != "PARTNER") {
      await Provider.of<GeneralProvider>(context, listen: false)
          .invoiceInit(false);
      await Provider.of<UserProvider>(context, listen: false).invoice(false);
      await list(page, limit);
      for (var i = 0; i < invoice.rows!.length; i++) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return PopScope(
      canPop: false,
      onPopInvoked: (shouldPop) async {
        await showMyDialog();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 50, top: 30),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: buttonColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/notification.svg',
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          ProfilePage.routeName,
                                          arguments: ProfilePageArguments(
                                            index: 0,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: user.avatar == null ||
                                                user.avatar == ''
                                            ? const CircleAvatar(
                                                backgroundColor: grey,
                                                radius: 14,
                                                backgroundImage: AssetImage(
                                                    'images/avatar.png'),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: grey,
                                                radius: 14,
                                                backgroundImage: NetworkImage(
                                                    '${user.avatar}'),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Text(
                          user.currentBusiness?.partner?.businessName ??
                              "${user.lastName?[0]}. ${user.firstName}",
                          style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${user.currentBusiness?.type ?? user.loginType}: ",
                              style: const TextStyle(
                                color: Color(0xffFEBC11),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              user.currentBusiness?.profileName ?? "-",
                              style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const ModulesCard(),
                ],
              ),
              user.currentBusiness?.type == "BUYER" ||
                      user.currentBusiness?.type == "SUPPLIER"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filtered.isEmpty
                            ? const SizedBox()
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                color: white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: user.currentBusiness?.type ==
                                              "SUPPLIER"
                                          ? const Text(
                                              "Өнөөдөр хүлээлгэн өгөх",
                                              style: TextStyle(
                                                color: buttonColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : const Text(
                                              "Өнөөдөр хүлээн авах",
                                              style: TextStyle(
                                                color: buttonColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/dot-calendar.svg'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
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
                              const SizedBox(
                                height: 12,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ScheduleCard(
                                    count: 5,
                                    labelText: 'Нээлттэй нэхэмжлэх',
                                  ),
                                  ScheduleCard(
                                    count: 15,
                                    labelText: 'Батлах хүлээж буй',
                                  ),
                                  ScheduleCard(
                                    count: 345,
                                    labelText: 'Хугацаа хэтэрсэн',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (invoice.rows!.isNotEmpty)
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: const Text(
                                  'Батлах хүлээж буй',
                                  style: TextStyle(
                                    color: buttonColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    color: blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
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
                                        startAnimation: startAnimation,
                                        index: invoice.rows!.indexOf(e),
                                        data: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const Text(
                            'DeHUB платформд тавтай морил!',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SvgPicture.asset('assets/svg/new-player.svg'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Та партнерийн тохиргоогоо бүрэн гүйцэт хийнэ үү',
                            style: TextStyle(color: buttonColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              'Заавартай танилцах',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TutorialCard(),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Та Апп-аас гарах гэж байна'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Болих'),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                  red.withOpacity(0.1),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
              child: const Text(
                'Гарах',
                style: TextStyle(color: red),
              ),
            ),
          ],
        ),
      );
}
