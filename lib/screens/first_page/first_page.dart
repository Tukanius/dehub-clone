import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/first_page/tabs/ajil_uureg.dart';
import 'package:dehub/screens/first_page/tabs/dashboard_page.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/firstpage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

User user = User();

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfilePage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: user.avatar == null
                      ? CircleAvatar(
                          radius: 13,
                          child: ClipOval(
                            child: Image(
                                image: NetworkImage(
                              'https://i0.wp.com/a.slack-edge.com/df10d/img/avatars/ava_0024-192.png?ssl=1',
                            )),
                          ),
                        )
                      : CircleAvatar(
                          radius: 13,
                          backgroundImage: NetworkImage('${user.avatar}'),
                        ),
                ),
              ),
            ),
          ],
          backgroundColor: mainColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(MenuPage.routeName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SvgPicture.asset('images/menu.svg'),
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            unselectedLabelColor: white,
            indicatorColor: white,
            tabs: [
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Дашбоард',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Ажил үүрэг',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            DashboardPage(),
            AjilUureg(),
          ],
        ),
      ),
    );
  }
}
