import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/profile/information/partner_info.dart';
import 'package:dehub/screens/profile/information/personal_info.dart';
import 'package:dehub/screens/profile/information/settings_page.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profilepage';
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  logout() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.of(context).pushNamed(SplashPage.routeName);
    setState(() {
      isLoading = false;
    });
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: grey2,
        iconTheme: IconThemeData(color: white),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              logout();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: white.withOpacity(0.3), width: 0.5),
                shape: BoxShape.circle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: white,
                    size: 12,
                  ),
                  Text(
                    'Гарах',
                    style: TextStyle(
                      color: white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        title: tabController.index == 0
            ? Text(
                'Миний мэдээлэл',
                style: TextStyle(fontSize: 15),
              )
            : tabController.index == 1
                ? Text(
                    'Партнер мэдээлэл',
                    style: TextStyle(fontSize: 15),
                  )
                : Text(
                    'Систем тохиргоо',
                    style: TextStyle(fontSize: 15),
                  ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: grey2,
              ),
            )
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    changePage(0);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: grey3, width: 0.5),
                                      color: tabController.index == 0
                                          ? grey2
                                          : white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/bx_user-circle.svg',
                                      color: tabController.index != 0
                                          ? grey3
                                          : white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changePage(1);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: grey3, width: 0.5),
                                      color: tabController.index == 1
                                          ? grey2
                                          : white,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/hospital.svg',
                                      color: tabController.index != 1
                                          ? grey3
                                          : white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changePage(2);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: grey3, width: 0.5),
                                        color: tabController.index == 2
                                            ? grey2
                                            : white),
                                    child: SvgPicture.asset(
                                      'assets/svg/settings.svg',
                                      color: tabController.index != 2
                                          ? grey3
                                          : white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PersonalInfo(),
                    PartnerInfo1(),
                    SettingsPage(),
                  ],
                ),
              ),
            ),
    );
  }
}
