import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/add_bank_account_page/banks/golomt.dart';
import 'package:dehub/screens/add_bank_account_page/banks/hudaldaa_hogjil.dart';
import 'package:dehub/screens/add_bank_account_page/banks/khan.dart';
import 'package:dehub/screens/add_bank_account_page/banks/khas.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddBankAccountPage extends StatefulWidget {
  static const routeName = 'addbankaccountpage';
  const AddBankAccountPage({Key? key}) : super(key: key);

  @override
  _AddBankAccountPageState createState() => _AddBankAccountPageState();
}

User user = User();

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          shadowColor: transparent,
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(MenuPage.routeName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SvgPicture.asset(
                'images/menu.svg',
                color: neonGreen,
              ),
            ),
          ),
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
          bottom: PreferredSize(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                color: neonGreen,
                height: 2.0,
              ),
              preferredSize: Size.fromHeight(3.0)),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      color: backgroundColor,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: neonGreen,
                        unselectedLabelColor: grey3,
                        indicatorColor: neonGreen,
                        tabs: [
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              'Голомт банк',
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Хаан банк',
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                            ),
                          ),
                          Container(
                            child: Text(
                              'ХасБанк',
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                            ),
                          ),
                          Container(
                            child: Text(
                              'ХХБ',
                              style: TextStyle(fontSize: 16),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Golomt(),
              Khan(),
              Khas(),
              HudaldaaHogjil(),
            ],
          ),
        ),
      ),
    );
  }
}
