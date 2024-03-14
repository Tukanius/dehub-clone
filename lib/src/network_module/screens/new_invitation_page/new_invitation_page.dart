import 'package:dehub/src/network_module/screens/new_invitation_page/tabs/from_dehub.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/tabs/onboard_tab.dart';
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
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: networkColor),
          title: const Text(
            'Худалдан авагч урих',
            style: TextStyle(
              color: networkColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            labelColor: networkColor,
            indicatorColor: networkColor,
            unselectedLabelColor: dark,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: "Montserrat",
            ),
            tabs: const [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'DeHUB Network-с',
                    style: TextStyle(),
                  ),
                ),
              ),
              SizedBox(
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
        body: const TabBarView(
          children: [
            FromDehubTab(),
            OnboardTab(),
          ],
        ),
      ),
    );
  }
}
