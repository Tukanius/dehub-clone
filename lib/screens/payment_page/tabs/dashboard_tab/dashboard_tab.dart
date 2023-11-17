import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

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
    "Top 100": 5,
    "Top 50": 3,
  };

  List<Color> colorList = [
    paymentColor,
    networkColor,
    userColor,
    partnerColor,
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
                DashboardCard(
                  onClick: () {},
                  boxColor: paymentColor.withOpacity(0.2),
                  padding: 8,
                  labelText: 'Захиалга хүргэлт',
                  svgColor: buttonColor,
                  svg: 'assets/svg/zahialga.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: paymentColor.withOpacity(0.2),
                  padding: 10,
                  labelText: 'Ачилт удирдлага',
                  svgColor: buttonColor,
                  svg: 'assets/svg/push.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: paymentColor.withOpacity(0.2),
                  padding: 10,
                  labelText: 'Захиалга нэгтгэл',
                  svgColor: buttonColor,
                  svg: 'assets/svg/push.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: paymentColor.withOpacity(0.2),
                  padding: 10,
                  labelText: 'Буцаалтын тооцоо',
                  svgColor: buttonColor,
                  svg: 'assets/svg/push.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: paymentColor.withOpacity(0.2),
                  padding: 10,
                  labelText: 'Лавлах мэдээлэл',
                  svgColor: buttonColor,
                  svg: 'assets/svg/map.svg',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: paymentColor,
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
                          child: Text(
                            'Харилцагч бизнесүүд',
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: transparent,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Бүгдийг",
                                  style: TextStyle(
                                    color: networkColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: networkColor,
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
                    SizedBox(
                      height: 10,
                    ),
                    PieChart(legend: legend, colorList: colorList, data: data),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Танай илгээсэн',
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: transparent,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Бүгдийг",
                                  style: TextStyle(
                                    color: networkColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: networkColor,
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())} - ',
                          style: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                          style: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                                        ? networkColor
                                        : grey2,
                            dataSource: legend,
                            xValueMapper: (gdp, _) => gdp.name,
                            yValueMapper: (gdp, _) => gdp.count,
                          )
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
