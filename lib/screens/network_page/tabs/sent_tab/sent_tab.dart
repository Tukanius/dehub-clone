import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/dehub_network.dart';
import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/onboar_invitation.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SentTab extends StatefulWidget {
  const SentTab({Key? key}) : super(key: key);

  @override
  _SentTabState createState() => _SentTabState();
}

class _SentTabState extends State<SentTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Material(
                color: white,
                elevation: 2,
                child: TabBar(
                  labelColor: networkColor,
                  unselectedLabelColor: dark,
                  indicatorColor: networkColor,
                  tabs: [
                    Container(
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
                    Container(
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
        body: TabBarView(
          children: [
            DehubNetwork(),
            OnboarInvitation(),
          ],
        ),
      ),
    );
  }
}
