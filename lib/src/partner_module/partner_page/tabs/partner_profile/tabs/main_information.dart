import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/forms/main_information_form.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainInformation extends StatefulWidget {
  const MainInformation({super.key});

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation>
    with AfterLayoutMixin {
  bool edit = false;
  bool isEditted = false;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  Partner user = Partner();
  Partner api = Partner();
  General general = General();
  bool isLoading = true;

  onSubmit() async {
    Partner partner =
        Provider.of<PartnerProvider>(context, listen: false).partner;
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        if (partner.legalEntityType != null &&
            partner.equityType != null &&
            partner.country != null &&
            partner.classification != null &&
            partner.province != null &&
            partner.district != null &&
            partner.khoroo != null) {
          loading.loading(true);
          Partner data = Partner.fromJson(fbKey.currentState!.value);
          data.province = partner.province;
          data.district = partner.district;
          data.khoroo = partner.khoroo;
          data.legalEntityType = partner.legalEntityType;
          data.equityType = partner.equityType;
          data.country = partner.country;
          data.classification = partner.classification;
          await PartnerApi().profileUpdate(data);
          await Provider.of<UserProvider>(context, listen: false)
              .partnerMe(false);
          loading.loading(false);
          setState(() {
            edit = false;
          });
        } else {
          showCustomDialog(context, "Талбаруудйиг бүрэн бөглөнө үү", false);
        }
      } catch (ex) {
        loading.loading(false);
      }
    }
  }

  setValue() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    source.partnerCategory(user.partner?.partnerCategory);
    if (user.partner?.legalEntityType != null) {
      source.legalEntityType(user.partner!.legalEntityType!);
    }
    source.country(user.partner?.country);
    source.equityType(user.partner?.equityType);
    source.province(user.partner?.province);
    source.district(user.partner?.district);
    source.khoroo(user.partner?.khoroo);
    if (user.partner?.classification != null) {
      source.classification(user.partner!.classification!);
    }
  }

  @override
  afterFirstLayout(BuildContext context) {
    if (user.partner != null) {
      setValue();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
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
                setValue();
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
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: fbKey,
                  onChanged: () {
                    setState(() {
                      isEditted = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MainInformationForm(
                      edit: edit,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
