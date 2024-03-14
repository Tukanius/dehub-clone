import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/profile/information/partner_info.dart';
import 'package:dehub/src/profile/information/personal_info.dart';
import 'package:dehub/src/profile/information/settings_page.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePageArguments {
  int index;
  ProfilePageArguments({
    required this.index,
  });
}

class ProfilePage extends StatefulWidget {
  final int index;
  static const routeName = '/profilepage';
  const ProfilePage({
    super.key,
    required this.index,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.index = widget.index;
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
    await Navigator.of(context).pushNamed(SplashPage.routeName);
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: grey2,
          surfaceTintColor: grey2,
          iconTheme: const IconThemeData(color: white),
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
                child: const Column(
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
              ? const Text(
                  'Миний мэдээлэл',
                  style: TextStyle(fontSize: 15, color: white),
                )
              : tabController.index == 1
                  ? const Text(
                      'Партнер мэдээлэл',
                      style: TextStyle(fontSize: 15, color: white),
                    )
                  : const Text(
                      'Систем тохиргоо',
                      style: TextStyle(fontSize: 15, color: white),
                    ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: grey2,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changePage(0);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: grey3, width: 0.5),
                              color: tabController.index == 0 ? grey2 : white,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/bx_user-circle.svg',
                              colorFilter: ColorFilter.mode(
                                  tabController.index != 0 ? grey3 : white,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: grey3, width: 0.5),
                              color: tabController.index == 1 ? grey2 : white,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/hospital.svg',
                              colorFilter: ColorFilter.mode(
                                  tabController.index != 1 ? grey3 : white,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(2);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: grey3, width: 0.5),
                                color:
                                    tabController.index == 2 ? grey2 : white),
                            child: SvgPicture.asset(
                              'assets/svg/settings.svg',
                              colorFilter: ColorFilter.mode(
                                  tabController.index != 2 ? grey3 : white,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        PersonalInfo(),
                        PartnerInfo(),
                        SettingsPage(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
