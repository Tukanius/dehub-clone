import 'package:after_layout/after_layout.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleAssignArguments {
  String id;
  User? data;
  ListenController listenController;
  RoleAssignArguments({
    required this.id,
    required this.listenController,
    this.data,
  });
}

class RoleAssign extends StatefulWidget {
  static const routeName = '/RoleAssign';
  final String id;
  final User? data;
  final ListenController listenController;
  const RoleAssign({
    super.key,
    required this.listenController,
    this.data,
    required this.id,
  });

  @override
  State<RoleAssign> createState() => _RoleAssignState();
}

class _RoleAssignState extends State<RoleAssign> with AfterLayoutMixin {
  bool isLoading = true;
  General general = General();
  List<User> businesses = [];

  onSubmit() async {
    List<User> data = [];
    data = businesses.where((element) => element.roles!.isNotEmpty).toList();
    for (var i = 0; i < data.length; i++) {
      debugPrint((data[i].toJson()).toString());
    }
  }

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    source.clearData();
    for (var element in general.businesses!) {
      element.roles = [];
      element.accessLevel = 'TO_ANYONE';
    }
    businesses = general.businesses!;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text(
                      'Системд төлөөлөх бизнесийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: businesses.map(
                      (data) {
                        data.roles ??= [];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          color: white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${businesses.indexOf(data) + 1}'),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data.refCode}',
                                          style: const TextStyle(
                                            color: userColor,
                                          ),
                                        ),
                                        Text('${data.profileName}'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: general.roles!.map(
                                        (role) {
                                          int index = -1;
                                          if (data.roles != null) {
                                            index = data.roles!.indexWhere(
                                                (element) =>
                                                    element == role.name);
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              if (index > -1) {
                                                setState(() {
                                                  data.roles!.removeAt(index);
                                                });
                                              } else {
                                                setState(() {
                                                  data.roles!.add(role.name!);
                                                });
                                              }
                                            },
                                            child: Container(
                                              color: transparent,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    side:
                                                        MaterialStateBorderSide
                                                            .resolveWith(
                                                      (states) =>
                                                          const BorderSide(
                                                        color: userColor,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    activeColor: userColor,
                                                    value: index > -1,
                                                    onChanged: (value) {
                                                      if (index > -1) {
                                                        setState(() {
                                                          data.roles!
                                                              .removeAt(index);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          data.roles!
                                                              .add(role.name!);
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  Text(
                                                    '${role.name}',
                                                    style: const TextStyle(
                                                      color: grey2,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              if (data.roles!.indexWhere(
                                      (element) => element == "Order") >
                                  -1)
                                Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: general.accessLevels!
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                data.accessLevel = e.code;
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: black,
                                                        width:
                                                            data.accessLevel ==
                                                                    e.code
                                                                ? 1.5
                                                                : 1,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            data.accessLevel ==
                                                                    e.code
                                                                ? black
                                                                : transparent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    e.name!,
                                                    style: const TextStyle(
                                                      color: grey2,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
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
                          borderColor: grey2,
                          textColor: black,
                          labelColor: white,
                          labelText: 'Буцах',
                          onClick: () {
                            Navigator.of(context).pop();
                          },
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
    );
  }
}
