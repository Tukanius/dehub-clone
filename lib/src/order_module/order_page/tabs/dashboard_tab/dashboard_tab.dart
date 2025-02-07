import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/customers/customers.dart';
import 'package:dehub/src/order_module/screens/delivery_management/delivery_management.dart';
import 'package:dehub/src/order_module/screens/dropship_order/dropship_order.dart';
import 'package:dehub/src/order_module/screens/order_delivery/order_delivery.dart';
import 'package:dehub/src/order_module/screens/order_shipping/order_shipping.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});
  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  User user = User();
  Order dashboard = Order(recentDelivered: []);
  Map<String, double> data = {};
  bool isLoading = true;
  List<Color> colorList = [];
  List<String> svgs = [
    'assets/svg/income_review.svg',
    'assets/svg/expenditure_review.svg',
    'assets/svg/finance_review.svg',
    'assets/svg/paid_review.svg',
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "ORD_DASH")) {
      Map<String, double> pieData = {};
      dashboard = await OrderApi().dashboard(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      for (var i = 0; i < dashboard.byPie!.length; i++) {
        setState(() {
          pieData[dashboard.byPie![i].name!] =
              dashboard.byPie![i].amount!.toDouble();
          colorList.add(
            Color(int.parse(dashboard.byPie![i].color!.substring(1, 7),
                    radix: 16) +
                0xff000000),
          );
        });
      }
      for (var i = 0; i < dashboard.numberSurvey!.length; i++) {
        dashboard.numberSurvey![i].image = svgs[i];
      }
      setState(() {
        data = pieData;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    final index = Provider.of<IndexProvider>(context, listen: true);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: const Text(
                    'Захиалгын дашбоард',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (Permission().check(user, "ORD_NET"))
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(OrderCustomers.routeName);
                          },
                          boxColor: orderColor.withOpacity(0.2),
                          padding: 9,
                          labelText: user.currentBusiness?.type == "SUPPLIER"
                              ? 'Гэрээт харилцагч'
                              : 'Гэрээт нийлүүлэгч',
                          svgColor: buttonColor,
                          svg: 'assets/svg/order_customer.svg',
                        ),
                      if (user.currentBusiness?.type == "SUPPLIER" &&
                          Permission().check(user, "ORD_DN_LIST"))
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(DeliveryManagement.routeName);
                          },
                          boxColor: orderColor.withOpacity(0.2),
                          padding: 10,
                          labelText: 'Хүргэлт удирдлага',
                          svgColor: buttonColor,
                          svg: 'assets/svg/push.svg',
                        ),
                      if (user.currentBusiness?.type == "SUPPLIER" &&
                          Permission().check(user, "ORD_PS_LIST"))
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(OrderShipping.routeName);
                          },
                          boxColor: orderColor.withOpacity(0.2),
                          padding: 7,
                          labelText: 'Ачилт удирдлага',
                          svgColor: buttonColor,
                          svg: 'assets/svg/assign.svg',
                        ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(OrderDelivery.routeName);
                        },
                        boxColor: orderColor.withOpacity(0.2),
                        padding: 8,
                        labelText: user.currentBusiness?.type == "BUYER"
                            ? 'Захиалга хүлээн авах'
                            : "Захиалга хүргэлт",
                        svgColor: buttonColor,
                        svg: 'assets/svg/zahialga.svg',
                      ),
                      if (user.currentBusiness?.type == "SUPPLIER" &&
                              Permission().check(user, "ORD_DROPPED") ||
                          user.currentBusiness?.type == "SUPPLIER" &&
                              Permission().check(user, "ORD_DRSHPING"))
                        DashboardCard(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(DropshipOrder.routeName);
                          },
                          boxColor: orderColor.withOpacity(0.2),
                          padding: 7,
                          labelText: 'Dropship захиалга',
                          svgColor: buttonColor,
                          svg: 'assets/svg/box.svg',
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (Permission().check(user, "ORD_DASH"))
                  isLoading == true
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(left: 15),
                                scrollDirection: Axis.horizontal,
                                itemCount: dashboard.numberSurvey?.length,
                                itemBuilder: (context, index) => StatsCard(
                                  data: dashboard.numberSurvey![index],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
              ],
            ),
          ),
        ];
      },
      body: Permission().check(user, "ORD_DASH")
          ? isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: orderColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if (data.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: const Text(
                                'Борлуулалтын захиалга',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                index.indexChange(3);
                              },
                              child: Container(
                                color: transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: const Row(
                                  children: [
                                    Text(
                                      "Бүгдийг",
                                      style: TextStyle(
                                        color: orderColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: orderColor,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (data.isNotEmpty)
                        PieChart(
                          legend: dashboard.byPie!,
                          colorList: colorList,
                          data: data,
                          module: "ORDER",
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (dashboard.recentDelivered!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 5),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Сүүлд хүргэсэн',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Divider(),
                              Column(
                                children: dashboard.recentDelivered!
                                    .map(
                                      (data) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${data.receiverBusiness?.logo}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${data.receiverBusiness?.profileName}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(data
                                                                .deliveredDate!),
                                                        style: const TextStyle(
                                                          color: orderColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${data.receiverBusiness?.refCode}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12,
                                                            color: orderColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${Utils().formatCurrency("${data.orderAmount}")}₮',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
          : const SizedBox(),
    );
  }
}
