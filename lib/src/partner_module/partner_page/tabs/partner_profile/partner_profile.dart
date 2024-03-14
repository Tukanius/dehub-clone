import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/tabs/admin_user.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/tabs/main_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PartnerProfile extends StatefulWidget {
  static const routeName = '/PartnerProfile';
  const PartnerProfile({super.key});

  @override
  State<PartnerProfile> createState() => _PartnerProfileState();
}

class _PartnerProfileState extends State<PartnerProfile> with AfterLayoutMixin {
  Partner user = Partner();
  bool isLoading = true;
  String? fileName;
  bool isFileEmpty = false;
  final picker = ImagePicker();
  File? image;

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    source.clearData();
    setState(() {
      isLoading = false;
    });
  }

  getImage(ImageSource imageSource) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    if (file != null) {
      try {
        setState(() {
          image = File(file.path);
          fileName = file.path;
        });
        setState(() {
          isFileEmpty = false;
        });
        loading.loading(true);
        user = await PartnerApi().upload(file.path);
        await PartnerApi().logoUpdate(Partner(logo: user.url));
        await Provider.of<UserProvider>(context, listen: false)
            .partnerMe(false);
        loading.loading(false);
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return isLoading == true
        ? const SizedBox()
        : DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            getImage(ImageSource.gallery);
                          },
                          child: user.partner?.logo != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage('${user.partner?.logo}'),
                                )
                              : const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('images/avatar.png'),
                                ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${user.partner?.businessName}',
                          style: const TextStyle(
                            color: partnerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'ТТД: ${user.partner?.regNumber}',
                          style: const TextStyle(
                            color: grey2,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Холбоо барих',
                                    style: TextStyle(
                                      color: grey2,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      indent: 5,
                                      endIndent: 5,
                                      thickness: 0.5,
                                      color: grey2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.mail_outline,
                                          color: grey2,
                                          size: 14,
                                        ),
                                        Text(
                                          '${user.partner?.email}',
                                          style: const TextStyle(
                                            color: grey2,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.phone_outlined,
                                        color: grey2,
                                        size: 14,
                                      ),
                                      Text(
                                        '${user.partner?.phone}',
                                        style: const TextStyle(
                                          color: grey2,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: grey2,
                                          size: 14,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${user.partner?.businessAddress}',
                                            style: const TextStyle(
                                              color: grey2,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.person_outline_outlined,
                                          color: grey2,
                                          size: 16,
                                        ),
                                        Text(
                                          '${user.user?.employeeUnit?.name}',
                                          style: const TextStyle(
                                            color: grey2,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TabBar(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.grey.shade200),
                      indicatorColor: partnerColor,
                      unselectedLabelColor: grey2,
                      labelColor: partnerColor,
                      tabs: const [
                        Tab(
                          text: 'Үндсэн мэдээлэл',
                        ),
                        Tab(
                          text: 'Админ хэрэглэгч',
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: const TabBarView(
                children: [
                  MainInformation(),
                  AdminUser(),
                ],
              ),
            ),
          );
  }
}
