import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/src/user_module/sheets/bank_select_sheet.dart';
import 'package:dehub/src/user_module/sheets/user_select_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceRoleAssignArguments {
  ListenController listenController;
  FinanceRoleAssignArguments({
    required this.listenController,
  });
}

class FinanceRoleAssign extends StatefulWidget {
  static const routeName = '/FinanceRoleAssign';
  final ListenController listenController;
  const FinanceRoleAssign({
    super.key,
    required this.listenController,
  });

  @override
  State<FinanceRoleAssign> createState() => _FinanceRoleAssignState();
}

class _FinanceRoleAssignState extends State<FinanceRoleAssign>
    with AfterLayoutMixin {
  General general = General();
  Result users = Result(rows: []);
  Result banks = Result(rows: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    users = await UserApi().userSelect();
    banks = await UserApi().bankSelect();
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    await source.clearData();
    setState(() {
      isLoading = false;
    });
  }

  bank() {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    if (source.user.bank != null) {
      final res = general.bankNames!
          .firstWhere((element) => element.code == source.user.bank);
      return res.name;
    } else {
      return null;
    }
  }

  onSubmit() async {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await UserApi().financeRoleAssign(User(
        bank: source.user.bank,
        userId: source.user.userId,
      ));
      widget.listenController.changeVariable('asdf');
      loading.loading(false);
      showCustomDialog(context, "Ажмилттай эрх тохирууллаа", true,
          onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Эрх тохируулах',
          style: TextStyle(
            color: userColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: userColor),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: userColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SelectionField(
                      labelText: 'Банкны нэр',
                      hintText: 'Сонгох',
                      value: bank(),
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => BankSelectSheet(
                            banks: banks.rows!,
                          ),
                        );
                      },
                    ),
                    SelectionField(
                      labelText: 'Банктай харилцах ажилтан',
                      hintText: 'Сонгох',
                      value: source.user.username,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => UserSelectSheet(
                            users: users.rows!,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            borderColor: grey2,
                            labelColor: white,
                            labelText: 'Буцах',
                            textColor: buttonColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: CustomButton(
                            labelColor: userColor,
                            labelText: 'Зөвшөөрөх',
                            onClick: onSubmit,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
