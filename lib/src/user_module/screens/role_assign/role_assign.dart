import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/src/user_module/screens/role_assign/sheets/select_access_level.dart';
import 'package:dehub/src/user_module/screens/role_assign/sheets/select_branch.dart';
import 'package:dehub/src/user_module/screens/role_assign/sheets/select_business.dart';
import 'package:dehub/src/user_module/screens/role_assign/sheets/select_role.dart';
import 'package:dehub/src/user_module/screens/role_assign/sheets/select_role_type.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RoleAssignArguments {
  String id;
  User? data;
  RoleAssignArguments({
    required this.id,
    this.data,
  });
}

class RoleAssign extends StatefulWidget {
  static const routeName = '/RoleAssign';
  final String id;
  final User? data;
  const RoleAssign({
    super.key,
    this.data,
    required this.id,
  });

  @override
  State<RoleAssign> createState() => _RoleAssignState();
}

class _RoleAssignState extends State<RoleAssign> with AfterLayoutMixin {
  bool isLoading = true;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  onSubmit() async {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      User data = User();
      data.userId = widget.id;
      data.businessId = source.user.business?.id;
      data.branchId = source.user.branchId;
      data.roleId = source.user.roleId;
      data.accessLevel = source.user.accessLevel;
      data.type = source.user.type == "Байнгын" ? "PERMANENT" : "TEMPORARY";
      if (source.user.type == 'Түр') {
        data.startDate = startDate.toString();
        data.endDate = endDate.toString();
      }
      if (data.businessId != null &&
          data.branchId != null &&
          data.roleId != null &&
          data.accessLevel != null &&
          data.type != null) {
        await UserApi().roleAdd(data);
        loading.loading(false);
        showCustomDialog(context, "Амжилттай эрх нэмлээ", true, onPressed: () {
          Navigator.of(context).pop();
        });
      } else {
        showCustomDialog(context, 'Талбаруудийг бүрэн бөглөнө үү', false);
        loading.loading(false);
      }
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    source.clearData();
    if (widget.data != null) {
      source.selectBusiness(widget.data!.business!);
      source.selectBranch(widget.data!.branch!.id!, widget.data!.branch!.name!);
      source.selectRole(widget.data!.role!.id!, widget.data!.role!.name!);
      source.selectAccessLevel(widget.data!.accessLevel!);
      source.selectRoleType(
          widget.data!.type! == "PERMANENT" ? 'Байнгын' : 'Түр');
      if (widget.data!.type == "TEMPORARY") {
        startDate = DateTime.parse(widget.data!.startDate!);
        endDate = DateTime.parse(widget.data!.endDate!);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: userColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Хэрэглэгчийн эрх нэмэх',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: userColor,
          ),
        ),
      ),
      body: isLoading == true
          ? const SizedBox()
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Системд төлөөлөх бизнесийн мэдээлэл',
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text('Бизнесийн нэр'),
                    ),
                    selectionField(
                      text: source.user.business?.profileName != null
                          ? "${source.user.business?.profileName} / ${source.user.business?.refCode}"
                          : null,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectBusiness(),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text('Хамрах хүрээ'),
                    ),
                    selectionField(
                      text: source.user.branchName,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectBranch(),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text('Хэрэглэгчийн роль'),
                    ),
                    selectionField(
                      text: source.user.roleName,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectRole(),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text('Өгөгдлийн түвшин'),
                    ),
                    selectionField(
                      text: source.user.accessLevel == 'ONLY_ME'
                          ? 'Надад хуваарилагдсан'
                          : source.user.accessLevel == "TO_ANYONE"
                              ? 'Бүгд'
                              : null,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectAccessLevel(),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text('Ролийн төрөл'),
                    ),
                    selectionField(
                      text: source.user.type,
                      onClick: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectRoleType(),
                        );
                      },
                    ),
                    if (source.user.type == 'Түр')
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text('Эхлэх хугацаа'),
                                ),
                                selectionField(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(startDate),
                                  onClick: () {
                                    changeStartDate();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text('Дуусах хугацаа'),
                                ),
                                selectionField(
                                  text:
                                      DateFormat('yyyy-MM-dd').format(endDate),
                                  onClick: () {
                                    changeEndDate();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                            borderColor: grey2,
                            textColor: black,
                            labelColor: white,
                            labelText: 'Буцах',
                            onClick: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: CustomButton(
                            textColor: white,
                            labelColor: userColor,
                            labelText: 'Хадгалах',
                            onClick: onSubmit,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
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

  Widget selectionField({String? text, required Function() onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: grey2.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(5),
          color: white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text ?? "Сонгоно уу",
                style: TextStyle(
                  color: text != null ? black : grey2,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 14,
            )
          ],
        ),
      ),
    );
  }

  changeStartDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(DateTime.now())),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      startDate = newDate;
                    });
                    if (startDate.difference(endDate).inDays > 0) {
                      setState(() {
                        endDate = startDate;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  changeEndDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Болсон',
                  style: TextStyle(
                    fontSize: 12,
                    color: black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime:
                      DateTime.parse(DateFormat('yyyy-MM-dd').format(endDate)),
                  minimumDate: DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startDate)),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      endDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
