import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/tabs/from_dehub.dart';
import 'package:dehub/src/network_module/screens/new_invitation_page/tabs/onboard_tab.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewInvitationPage extends StatefulWidget {
  static const routeName = '/NewInvitationPage';
  const NewInvitationPage({super.key});

  @override
  State<NewInvitationPage> createState() => _NewInvitationPageState();
}

class _NewInvitationPageState extends State<NewInvitationPage> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: const IconThemeData(color: networkColor),
          title: Text(
            user.currentBusiness?.type == "SUPPLIER"
                ? 'Худалдан авагч урих'
                : "Нийлүүлэгч урих",
            style: const TextStyle(
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
        body: TabBarView(
          children: [
            Permission().check(user, "NET_INV_SENT", boolean: 'isCreate')
                ? const FromDehubTab()
                : const NotFound(
                    module: 'NETWORK',
                    labelText: 'Хандах эрх хүрэлцэхгүй байна',
                  ),
            Permission().check(user, "NET_INV_ONB", boolean: 'isCreate')
                ? const OnboardTab()
                : const NotFound(
                    module: 'NETWORK',
                    labelText: 'Хандах эрх хүрэлцэхгүй байна',
                  ),
          ],
        ),
      ),
    );
  }
}
