import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/network_page/tabs/sent_tab/tabs/dehub_network.dart';
import 'package:dehub/src/network_module/network_page/tabs/sent_tab/tabs/onboar_invitation.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/new_invitation_page.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SentTab extends StatefulWidget {
  const SentTab({super.key});

  @override
  SentTabState createState() => SentTabState();
}

class SentTabState extends State<SentTab> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: const CustomBackButton(color: white),
        backgroundColor: networkColor,
        leadingWidth: 130,
        actions: [
          if (Permission().check(user, "NET_INV_SENT"))
            AddButton(
              color: white,
              addColor: networkColor,
              onClick: () {
                Navigator.of(context).pushNamed(NewInvitationPage.routeName);
              },
            ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Material(
                  color: white,
                  elevation: 2,
                  child: TabBar(
                    overlayColor:
                        MaterialStatePropertyAll(Colors.grey.shade100),
                    labelColor: networkColor,
                    unselectedLabelColor: dark,
                    indicatorColor: networkColor,
                    tabs: const [
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            'DeHub Network-c',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            'Onboard урилга',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: const TabBarView(
            children: [
              DehubNetwork(),
              OnboarInvitation(),
            ],
          ),
        ),
      ),
    );
  }
}
