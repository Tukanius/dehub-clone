import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stast_card/stats_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/customers/customers.dart';
import 'package:dehub/src/order_module/screens/delivery_management/delivery_management.dart';
import 'package:dehub/src/order_module/screens/dropship_order/dropship_order.dart';
import 'package:dehub/src/order_module/screens/order_delivery/order_delivery.dart';
import 'package:dehub/src/order_module/screens/order_shipping/order_shipping.dart';
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
  Order dashboard = Order();
  Map<String, double> data = {};
  List<Order> legend = [];
  Order confirmed = Order();
  bool isLoading = true;
  Map<String, dynamic> pieChart = {
    "Ангилал №1": 3,
    "Ангилал №2": 3,
    "Ангилал №3": 3,
    "Ангилал №4": 3,
    "Бусад ангилал": 3,
  };

  List<Color> colorList = [
    orderColor,
    pieBlue,
    pieYellow,
    pieOrange,
    pieRed,
  ];

  List<String> svgs = [
    'assets/svg/income_review.svg',
    'assets/svg/expenditure_review.svg',
    'assets/svg/finance_review.svg',
    'assets/svg/paid_review.svg',
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        Order(
          count: value,
          profileName: key,
        ),
      );
    });
    dashboard = await OrderApi().dashboard(
      DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
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
    return SingleChildScrollView(
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
                    Navigator.of(context).pushNamed(OrderCustomers.routeName);
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
                      Navigator.of(context).pushNamed(OrderShipping.routeName);
                    },
                    boxColor: orderColor.withOpacity(0.2),
                    padding: 7,
                    labelText: 'Ачилт удирдлага',
                    svgColor: buttonColor,
                    svg: 'assets/svg/assign.svg',
                  ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(OrderDelivery.routeName);
                  },
                  boxColor: orderColor.withOpacity(0.2),
                  padding: 8,
                  labelText: 'Захиалга хүргэлт',
                  svgColor: buttonColor,
                  svg: 'assets/svg/zahialga.svg',
                ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(DropshipOrder.routeName);
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
              ? const Center(
                  child: CircularProgressIndicator(
                    color: orderColor,
                  ),
                )
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
                            index.indexChange(2);
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
                    PieChart(legend: legend, colorList: colorList, data: data),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'MIAT Mongolian Airlines',
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
                                            'PR-100022',
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
        ],
      ),
    );
  }
}
