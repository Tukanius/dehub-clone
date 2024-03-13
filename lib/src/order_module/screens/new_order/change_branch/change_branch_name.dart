import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/src/order_module/components/order_branch_card/order_branch_card.dart';
import 'package:dehub/models/result.dart';
// import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ChangeBranchNamePageArguments {
  String id;
  ListenController receiverBranchController;
  ChangeBranchNamePageArguments({
    required this.id,
    required this.receiverBranchController,
  });
}

class ChangeBranchNamePage extends StatefulWidget {
  final ListenController receiverBranchController;
  final String id;
  static const routeName = '/ChangeBranchNamePage';
  const ChangeBranchNamePage({
    super.key,
    required this.id,
    required this.receiverBranchController,
  });

  @override
  State<ChangeBranchNamePage> createState() => _ChangeBranchNamePageState();
}

class _ChangeBranchNamePageState extends State<ChangeBranchNamePage>
    with AfterLayoutMixin {
  bool isLoading = true;
  Result branches = Result(rows: []);
  @override
  afterFirstLayout(BuildContext context) async {
    branches = await OrderApi().branchSelect(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  String? selectedBranch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: orderColor),
        title: const Text(
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
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: branches.rows!
                        .map(
                          (e) => OrderBranchCard(
                            onClick: () {
                              widget.receiverBranchController
                                  .receiverBranchChange(e);
                              Navigator.of(context).pop();
                            },
                            data: e,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
    );
  }
}
