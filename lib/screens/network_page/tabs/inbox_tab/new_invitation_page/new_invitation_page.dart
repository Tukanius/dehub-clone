import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/tabs/from_dehub.dart';
import 'package:dehub/screens/network_page/tabs/inbox_tab/new_invitation_page/tabs/onboard_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class NewInvitationPage extends StatefulWidget {
  static const routeName = '/NewInvitationPage';
  const NewInvitationPage({super.key});

  @override
  State<NewInvitationPage> createState() => _NewInvitationPageState();
}

class _NewInvitationPageState extends State<NewInvitationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: networkColor,
            ),
          ),
          title: Text(
            'Худалдан авагч урих',
            style: TextStyle(
              color: networkColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: networkColor,
            unselectedLabelColor: dark,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'DeHUB Network-с',
                    style: TextStyle(),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    'Onboard урилга',
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FromDehubTab(),
            OnboardTab(),
          ],
        ),
      ),
    );
  }
}
