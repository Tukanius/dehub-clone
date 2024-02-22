import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/user_module/screens/create_user/create_user.dart';
import 'package:dehub/src/user_module/screens/update_user/tabs/role_setting.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class UpdateUserPageArguments {
  User data;
  ListenController listenController;
  UpdateUserPageArguments({
    required this.data,
    required this.listenController,
  });
}

class UpdateUserPage extends StatefulWidget {
  static const routeName = '/UpdateUserPage';
  final User data;
  final ListenController listenController;
  const UpdateUserPage({
    super.key,
    required this.listenController,
    required this.data,
  });

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: userColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          "Хэрэгчийн профайл",
          style: TextStyle(
            color: userColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
          indicatorColor: userColor,
          labelColor: userColor,
          unselectedLabelColor: grey2,
          tabs: const [
            Tab(
              text: 'Үндсэн мэдээлэл',
            ),
            Tab(
              text: 'Эрхийн тохиргоо',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CreateUser(
            listenController: widget.listenController,
            data: widget.data,
          ),
          RoleSetting(
            data: widget.data,
          ),
        ],
      ),
    );
  }
}
