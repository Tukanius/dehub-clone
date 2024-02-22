import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/profile/components/card.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInvitationSendArguments {
  User data;
  UserInvitationSendArguments({
    required this.data,
  });
}

class UserInvitationSend extends StatefulWidget {
  static const routeName = '/UserInvitationSend';
  final User data;
  const UserInvitationSend({
    super.key,
    required this.data,
  });

  @override
  State<UserInvitationSend> createState() => _UserInvitationSendState();
}

class _UserInvitationSendState extends State<UserInvitationSend> {
  onSubmit() async {
    final source = Provider.of<LoadingProvider>(context, listen: false);
    try {
      source.loading(true);
      await UserApi().invitationSend(widget.data.id!);
      source.loading(false);
      showCustomDialog(context, "Амжилттай урилга илгээлээ", true,
          onPressed: () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      source.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: userColor),
        title: const Text(
          'Урилга илгээх',
          style: TextStyle(
            color: userColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: white,
        surfaceTintColor: white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              InformationCard(
                paddingVertical: 3,
                labelText: 'Ургын овог',
                value: "${widget.data.familyName}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Эцэг, эхийн нэр',
                value: "${widget.data.lastName}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Өөрийн нэр',
                value: "${widget.data.firstName}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Регистер №',
                value: "${widget.data.registerNo}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'И-мэйл',
                value: "${widget.data.email}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Утасны дугаар',
                value: "${widget.data.phone}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Харьяалах нэгж',
                value: "${widget.data.departmentUnit?.name}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Харьяалах дэд нэгж',
                value: "${widget.data.departmentSubUnit?.name}",
              ),
              InformationCard(
                paddingVertical: 3,
                labelText: 'Албан тушаал',
                value: "${widget.data.employeeUnit?.name}",
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
                    flex: 3,
                    child: CustomButton(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      labelColor: white,
                      labelText: 'Буцах',
                      borderColor: grey2,
                      textColor: black,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 5,
                    child: CustomButton(
                      onClick: onSubmit,
                      labelColor: userColor,
                      labelText: 'Урилга илгээх',
                      textColor: white,
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
}
