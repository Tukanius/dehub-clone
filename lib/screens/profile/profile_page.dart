import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/profile/information/partner_info.dart';
import 'package:dehub/screens/profile/information/personal_info.dart';
import 'package:dehub/screens/profile/information/settings_page.dart';
import 'package:dehub/screens/profile/information/system_users.dart';
import 'package:dehub/screens/profile/information/screens/page2.dart';
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

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  User partnerUser = User();

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: IconThemeData(color: white),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          tabController.index == 2
              ? Container(
                  child: AddButton(
                    color: Colors.orange,
                    onClick: () {},
                  ),
                )
              : SizedBox(),
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
                : tabController.index == 2
                    ? Text(
                        'Систем хэрэглэгчид',
                        style: TextStyle(fontSize: 15),
                      )
                    : Text(''),
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: grey3, width: 0.5),
                                color: tabController.index == 0
                                    ? mainColor
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/bx_user-circle.svg',
                                color: tabController.index != 0 ? grey3 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(1);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: grey3, width: 0.5),
                                color: tabController.index == 1
                                    ? mainColor
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/Vector.svg',
                                color: tabController.index != 1 ? grey3 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(2);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: grey3, width: 0.5),
                                color: tabController.index == 2
                                    ? mainColor
                                    : white,
                              ),
                              child: SvgPicture.asset(
                                'images/people.svg',
                                color: tabController.index != 2 ? grey3 : white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              changePage(3);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: grey3, width: 0.5),
                                  color: tabController.index == 3
                                      ? mainColor
                                      : white),
                              child: SvgPicture.asset(
                                'images/settings.svg',
                                color: tabController.index != 3 ? grey3 : white,
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
              PersonalInfo(
                data: partnerUser,
              ),
              PartnerInfo1(),
              SystemUsersPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
