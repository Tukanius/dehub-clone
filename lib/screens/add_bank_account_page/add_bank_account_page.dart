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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: grey3.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: paymentColor,
                        unselectedLabelColor: grey3,
                        indicatorColor: paymentColor,
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
