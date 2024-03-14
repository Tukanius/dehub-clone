import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/order_pie_chart.dart';
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
  Order confirmed = Order();
  bool isLoading = true;
  PageController pageController = PageController();
  int currentPage = 0;

  List<Color> colorList = [];

  List<String> svgs = [
    'assets/svg/income_review.svg',
    'assets/svg/expenditure_review.svg',
    'assets/svg/finance_review.svg',
    'assets/svg/paid_review.svg',
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    Map<String, double> pieData = {};
    dashboard = await OrderApi().dashboard(
      DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    for (var i = 0; i < dashboard.byPie!.length; i++) {
      setState(() {
        pieData[dashboard.byPie![i].name!] =
            dashboard.byPie![i].amount!.toDouble();
        colorList.add(
          Color(
            int.parse(dashboard.byPie![i].color!.substring(1, 7), radix: 16) +
                0xff000000,
          ),
        );
      });
    }
    for (var i = 0; i < dashboard.numberSurvey!.length; i++) {
      dashboard.numberSurvey![i].image = svgs[i];
    }
    setState(() {
      data = pieData;
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
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(OrderCustomers.routeName);
                        },
                        boxColor: orderColor.withOpacity(0.2),
                        padding: 9,
                        labelText: 'Гэрээт харилцагч',
                        svgColor: buttonColor,
                        svg: 'assets/svg/order_customer.svg',
                      ),
                      if (user.currentBusiness?.type == "SUPPLIER")
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
                      if (user.currentBusiness?.type == "SUPPLIER")
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
                        labelText: 'Захиалга хүргэлт',
                        svgColor: buttonColor,
                        svg: 'assets/svg/zahialga.svg',
                      ),
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
                      DashboardCard(
                        onClick: () {},
                        boxColor: orderColor.withOpacity(0.2),
                        padding: 10,
                        labelText: 'Лавлах мэдээлэл',
                        svgColor: buttonColor,
                        svg: 'assets/svg/map.svg',
                      ),
                    ],
                  ),
                ),
                isLoading == true
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageController.animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: currentPage == 0
                                      ? Colors.grey
                                      : Colors.grey.shade300,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageController.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: currentPage == 1
                                      ? Colors.grey
                                      : Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ];
      },
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                        OrderPieChart(
                            legend: dashboard.byPie!,
                            colorList: colorList,
                            data: data),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'images/golomt.png',
                                      ),
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
                                          const Expanded(
                                            child: Text(
                                              'Hunnu Air',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            style: const TextStyle(
                                              color: orderColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'SU-100000',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: orderColor,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '20,000₮',
                                            style: TextStyle(
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                        OrderPieChart(
                            legend: dashboard.byPie!,
                            colorList: colorList,
                            data: data),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
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
                                    (data) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
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
                                                      style: const TextStyle(
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
                                                      style: const TextStyle(
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
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
