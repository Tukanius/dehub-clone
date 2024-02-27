import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/forms/admin_user_form.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({super.key});

  @override
  State<AdminUser> createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = true;
  bool edit = false;

  onSubmit() async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        Partner data = Partner.fromJson(fbkey.currentState!.value);
        data.departmentUnitId = source.partner.departmentUnitId;
        data.employeeUnitId = source.partner.employeeUnitId;
        if (data.departmentUnitId != null && data.employeeUnitId != null) {
          await PartnerApi().updateAdmin(data);
          await Provider.of<UserProvider>(context, listen: false)
              .partnerMe(false);
          setState(() {
            edit = false;
          });
        } else {
          showCustomDialog(
              context,
              data.departmentUnitId == null
                  ? 'Харьяалах нэгжийн нэр сонгоно уу'
                  : 'Албан тушаалын нэр сонгоно уу',
              false);
        }
        loading.loading(false);
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    Partner user =
        Provider.of<UserProvider>(context, listen: false).partnerUser;
    source.departmentUnit(user.user!.departmentUnitId!);
    source.employeeUnit(user.user!.employeeUnitId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (edit == true)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  edit = false;
                });
              },
              backgroundColor: white,
              shape: const CircleBorder(
                side: BorderSide(
                  color: grey3,
                ),
              ),
              child: SvgPicture.asset(
                'assets/svg/remove.svg',
                colorFilter: const ColorFilter.mode(grey3, BlendMode.srcIn),
              ),
            ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              if (edit == true) {
                onSubmit();
              } else {
                setState(() {
                  edit = true;
                });
              }
            },
            backgroundColor: partnerColor,
            shape: const CircleBorder(),
            child: edit == false
                ? SvgPicture.asset(
                    'assets/svg/edit_rounded.svg',
                    colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
                  )
                : const Icon(
                    Icons.check,
                    color: white,
                  ),
          ),
        ],
      ),
      body: isLoading == true
          ? const SizedBox()
          : SingleChildScrollView(
              child: FormBuilder(
                key: fbkey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AdminUserForm(
                    edit: edit,
                  ),
                ),
              ),
            ),
    );
  }
}
