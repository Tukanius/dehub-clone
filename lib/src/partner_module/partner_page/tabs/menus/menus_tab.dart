import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/partner_profile/partner_profile.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class MenusTab extends StatefulWidget {
  const MenusTab({super.key});

  @override
  State<MenusTab> createState() => _MenusTabState();
}

class _MenusTabState extends State<MenusTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Партнер удирдлага',
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              children: [
                DashboardCard(
                  boxColor: partnerColor.withOpacity(0.15),
                  padding: 11,
                  labelText: 'Партнер профайл',
                  svgColor: partnerColor,
                  svg: 'assets/svg/profile.svg',
                  onClick: () {
                    Navigator.of(context).pushNamed(PartnerProfile.routeName);
                  },
                ),
                DashboardCard(
                  boxColor: partnerColor.withOpacity(0.15),
                  padding: 9,
                  labelText: 'Манай нийлүүлэлт',
                  svgColor: partnerColor,
                  svg: 'assets/svg/zahialga.svg',
                  onClick: () {},
                ),
                DashboardCard(
                  boxColor: partnerColor.withOpacity(0.15),
                  padding: 5,
                  labelText: 'Худалдан авалт',
                  svgColor: partnerColor,
                  svg: 'assets/svg/buyer.svg',
                  onClick: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
