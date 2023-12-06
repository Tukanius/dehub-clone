import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/order_branch_card/order_branch_card.dart';
import 'package:dehub/models/order.dart';
// import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ChangeBranchNamePageArguments {
  ListenController receiverBranchController;
  List<Order> data;
  ChangeBranchNamePageArguments({
    required this.receiverBranchController,
    required this.data,
  });
}

class ChangeBranchNamePage extends StatefulWidget {
  final ListenController receiverBranchController;
  final List<Order> data;
  static const routeName = '/ChangeBranchNamePage';
  const ChangeBranchNamePage({
    Key? key,
    required this.receiverBranchController,
    required this.data,
  }) : super(key: key);

  @override
  State<ChangeBranchNamePage> createState() => _ChangeBranchNamePageState();
}

class _ChangeBranchNamePageState extends State<ChangeBranchNamePage> {
  String? selectedBranch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: Text(
          "Хүлээн авах хаяг солих",
          style: TextStyle(
            color: dark,
            fontSize: 16,
          ),
        ),
        actions: [
          AddButton(
            onClick: () {},
            addColor: white,
            color: orderColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: widget.data
                  .map(
                    (e) => OrderBranchCard(
                      onClick: () {
                        widget.receiverBranchController.receiverBranchChange(e);
                        Navigator.of(context).pop();
                      },
                      data: e,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 70,
            ),
            // CustomButton(
            //   isGradient: true,
            //   labelText: 'Сольё',
            // ),
          ],
        ),
      ),
    );
  }
}
