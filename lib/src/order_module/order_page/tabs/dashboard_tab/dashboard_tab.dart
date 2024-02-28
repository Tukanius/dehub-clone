import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/customers/customers.dart';
import 'package:dehub/src/order_module/screens/delivery_management/delivery_management.dart';
import 'package:dehub/src/order_module/screens/order_delivery/order_delivery.dart';
import 'package:dehub/src/order_module/screens/order_shipping/order_shipping.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  User user = User();

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

  @override
  afterFirstLayout(BuildContext context) {
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
                  onClick: () {},
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
          const SizedBox(
            height: 25,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Захиалгын дүн',
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
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())} - ',
                          style: const TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd").format(DateTime.now()),
                          style: const TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 180,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      child: SfCartesianChart(
                        series: <ChartSeries>[
                          BarSeries<Order, String>(
                            borderRadius: BorderRadius.circular(5),
                            pointColorMapper: (datum, index) =>
                                datum.name == "Зөвшөөрсөн"
                                    ? networkDashboard2
                                    : datum.name == "Илгээсэн"
                                        ? orderColor
                                        : grey2,
                            dataSource: legend,
                            xValueMapper: (gdp, _) => gdp.profileName,
                            yValueMapper: (gdp, _) => gdp.count,
                          )
                        ],
                        primaryXAxis: CategoryAxis(),
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
