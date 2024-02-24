import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/src/user_module/screens/create_user/form/addional_form.dart';
import 'package:dehub/src/user_module/screens/create_user/form/create_user_form.dart';
import 'package:dehub/src/user_module/screens/create_user/form/picture_form.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CreateUserArguments {
  ListenController listenController;
  User? data;
  CreateUserArguments({
    required this.listenController,
    this.data,
  });
}

class CreateUser extends StatefulWidget {
  static const routeName = '/CreateUser';
  final ListenController listenController;
  final User? data;
  const CreateUser({
    super.key,
    this.data,
    required this.listenController,
  });

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = true;

  onSubmit() async {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        User data = User.fromJson(fbkey.currentState!.value);
        if (widget.data == null) {
          data.avatar = source.user.avatar;
        }
        data.identityCardBack = source.user.identityCardBack;
        data.identityCardFront = source.user.identityCardFront;
        data.departmentUnitId = source.user.departmentUnitId;
        data.departmentSubUnitId = source.user.departmentSubUnitId;
        data.employeeUnitId = source.user.employeeUnitId;
        data.socialLinks = source.user.socialLinks!
            .where((element) => element.link != null)
            .toList();
        if (data.identityCardBack == null || data.identityCardFront == null) {
          loading.loading(false);
          showCustomDialog(
              context,
              'Бүртгэл үүсгэхэд профайл, иргэний үнэмлэх оруулах шаардлагатай',
              false);
        } else if (data.departmentUnitId == null &&
            data.departmentSubUnitId == null &&
            data.employeeUnitId == null) {
          loading.loading(false);
          showCustomDialog(context, 'Хэрэглэгчийн харьяалал сонгоно уу', false);
        } else {
          if (widget.data == null) {
            await UserApi().userCreate(data);
          } else {
            await UserApi().userUpdate(data, widget.data!.id!);
          }
          widget.listenController.changeVariable('newUser');
          loading.loading(false);
          showCustomDialog(context, "Амжилттай", true, onPressed: () {
            Navigator.of(context).pop();
          });
        }
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    source.clearData();
    if (widget.data != null) {
      source.departmentUnit(widget.data!.departmentUnitId!);
      source.departmentSubUnit(widget.data!.departmentSubUnitId!);
      source.employeeUnit(widget.data!.employeeUnitId!);
      source.profileImage(widget.data!.avatar!);
      source.cardFront(widget.data!.identityCardFront!);
      source.cardBack(widget.data!.identityCardBack!);
      if (widget.data!.socialLinks!.isNotEmpty) {
        for (var i = 0; i < widget.data!.socialLinks!.length; i++) {
          int index = source.user.socialLinks!.indexWhere(
              (element) => element.type == widget.data!.socialLinks![i].type);
          if (index > -1) {
            source.user.socialLinks?[index].link =
                widget.data!.socialLinks![i].link;
          }
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserModuleProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: widget.data == null
            ? AppBar(
                surfaceTintColor: white,
                backgroundColor: white,
                iconTheme: const IconThemeData(color: userColor),
                title: const Text(
                  'Шинэ хэрэглэгч нэмэх',
                  style: TextStyle(
                    color: userColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
        body: isLoading == true
            ? const SizedBox()
            : SingleChildScrollView(
                child: FormBuilder(
                  key: fbkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreateUserForm(
                        data: widget.data,
                      ),
                      const UserPictureForm(),
                      AdditionalForm(
                        data: widget.data,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        onClick: onSubmit,
                        labelColor: userColor,
                        labelText: 'Хадгалах',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
