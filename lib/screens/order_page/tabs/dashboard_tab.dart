import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/order_delivery/order_delivery.dart';
import 'package:dehub/screens/order_shipping/order_shipping.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Захиалгын дашбоард',
              style: TextStyle(
                color: buttonColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrderDelivery.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: orderColor.withOpacity(0.2),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/zahialga.svg',
                            color: buttonColor,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Захиалга хүргэлт',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                user.currentBusiness?.type == "SUPPLIER"
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OrderShipping.routeName);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: orderColor.withOpacity(0.2),
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/push.svg',
                                  color: buttonColor,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Ачилт удирдлага',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: orderColor.withOpacity(0.2),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/push.svg',
                          color: buttonColor,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Захиалга нэгтгэл',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: orderColor.withOpacity(0.2),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/push.svg',
                          color: buttonColor,
                        ),
                      ),
                      Text(
                        'Буцаалтын тооцоо',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: orderColor.withOpacity(0.2),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/map.svg',
                          color: buttonColor,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Лавлах мэдээлэл',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
