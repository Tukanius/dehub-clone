import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/partner_module/components/picture_form/picture_form.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class MarketingInformation extends StatefulWidget {
  final Partner? data;
  final ListenController listenController;
  const MarketingInformation({
    super.key,
    required this.listenController,
    this.data,
  });

  @override
  State<MarketingInformation> createState() => _MarketingInformationState();
}

class _MarketingInformationState extends State<MarketingInformation>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  int confirmValue = 0;

  List<bool> confirmValues = [true, false];

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (widget.data != null) {
      source.profileImage(widget.data!.logo!);
      confirmValue = widget.data!.isConfirmed! == true ? 0 : 1;
      if (widget.data!.profileBanners != null) {
        for (var i = 0; i < widget.data!.profileBanners!.length; i++) {
          source.bannerImages(widget.data!.profileBanners![i]);
        }
      }
    }
  }

  onSubmit() async {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      List<Partner> profileBanners = [];
      try {
        Partner data = Partner.fromJson(fbkey.currentState!.value);
        for (var i = 0; i < source.partner.profileBanners!.length; i++) {
          profileBanners.add(
            Partner(
              url: source.partner.profileBanners?[i].url,
              isMain: source.partner.profileBanners?[i].isMain,
            ),
          );
        }
        data.profileBanners = profileBanners;
        data.logo = source.partner.logo;
        data.isConfirmed = confirmValue == 0 ? true : false;
        loading.loading(true);
        await PartnerApi().profileBusiness(data, widget.data!.id!);
        widget.listenController.changeVariable('businessProfile');
        loading.loading(false);
        Navigator.of(context).pop();
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: fbkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Профайлын нэр'),
                  ),
                  FormTextField(
                    textColor: black,
                    name: 'profileName',
                    initialValue: widget.data?.profileName,
                    decoration: InputDecoration(
                      hintText: 'Профайлын нэр',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Заавал оруулна',
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Профайлын нэр /Латин/'),
                  ),
                  FormTextField(
                    textColor: black,
                    name: 'profileNameEng',
                    initialValue: widget.data?.profileNameEng,
                    decoration: InputDecoration(
                      hintText: 'Профайлын нэр /Латин/',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Заавал оруулна',
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const PartnerPictureForm(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Товч танилцуулга'),
                  ),
                  FormTextField(
                    textColor: black,
                    name: 'profileInfo',
                    maxLines: 2,
                    initialValue: widget.data?.profileInfo,
                    decoration: InputDecoration(
                      hintText: 'Товч танилцуулга',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Заавал оруулна',
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Идэвхжүүлэх эсэх: '),
                  ),
                  Column(
                    children: confirmValues
                        .map(
                          (e) => Material(
                            color: white,
                            child: RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              title: Text(
                                e == true ? "Тийм" : "Үгүй",
                                style:
                                    const TextStyle(color: dark, fontSize: 14),
                              ),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => partnerColor),
                              value: confirmValues.indexOf(e),
                              groupValue: confirmValue,
                              onChanged: (value) {
                                setState(() {
                                  confirmValue = value!;
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    onClick: onSubmit,
                    labelColor: partnerColor,
                    labelText: 'Хадгалах',
                    textColor: white,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
