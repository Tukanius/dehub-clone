import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/tabs/admin_user.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/tabs/main_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PartnerProfile extends StatefulWidget {
  static const routeName = '/PartnerProfile';
  const PartnerProfile({super.key});

  @override
  State<PartnerProfile> createState() => _PartnerProfileState();
}

class _PartnerProfileState extends State<PartnerProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://miro.medium.com/v2/resize:fit:356/1*EnF9uIN_u2_X7ey24lB7Tg.png'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Компани М',
                    style: TextStyle(
                      color: partnerColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'ТТД: 32100013',
                    style: TextStyle(
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
                        const Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: grey2,
                                    size: 14,
                                  ),
                                  Text(
                                    'duurenzaya@skillup.mn',
                                    style: TextStyle(
                                      color: grey2,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    color: grey2,
                                    size: 14,
                                  ),
                                  Text(
                                    '89107733',
                                    style: TextStyle(
                                      color: grey2,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Buyer бизнес',
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
                        Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: const Text(
                            'Гүүдтек',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Supplier бизнес',
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
                        Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: const Text(
                            'Гүүдтек татан авалт',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
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
