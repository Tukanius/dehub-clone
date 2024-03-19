import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/models/stats.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
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
  List<Payment> legend = [];
  bool isLoading = true;
  Payment dashboard = Payment(revenueStructure: [], byInterval: []);
  int currentPage = 0;
  PageController pageController = PageController();

  List<Color> colorList = [
    networkColor,
    networkDashboard1,
    networkDashboard2,
    networkDashboard3,
    networkDashboard4,
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    Map<String, double> pieData = {};
    dashboard = await PaymentApi().dashboard(
      DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 7))),
      DateFormat('yyyy-MM-dd').format(DateTime.now()),
      DateFormat('yyyy-MM').format(DateTime.now()),
    );
    for (var data in dashboard.revenueStructure!) {
      pieData[data.name!] = data.amount!;
      legend.add(data);
    }
    setState(() {
      data = pieData;
      isLoading = false;
    });
  }

  List<Payment> asdf = [
    Payment(
      date: 'III.11',
      incomeAmount: 150,
    ),
    Payment(
      date: 'III.12',
      incomeAmount: 26,
    ),
    Payment(
      date: 'III.13',
      incomeAmount: 64,
    ),
    Payment(
      date: 'III.14',
      incomeAmount: 123,
    ),
    Payment(
      date: 'III.15',
      incomeAmount: 123,
    ),
    Payment(
      date: 'III.16',
      incomeAmount: 65,
    ),
    Payment(
      date: 'III.17',
      incomeAmount: 23,
    ),
  ];

  List<Stats> reviewData = [
    Stats(
      image: 'assets/svg/income_review.svg',
      name: 'ОРЛОГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
      percent: 12,
    ),
    Stats(
      image: 'assets/svg/expenditure_review.svg',
      name: 'ЗАРЛАГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
      percent: -12,
    ),
    Stats(
      image: 'assets/svg/finance_review.svg',
      name: 'САНХҮҮЖИЛТ АВСАН',
      amount: 238232000,
      percent: 12,
    ),
    Stats(
      image: 'assets/svg/paid_review.svg',
      name: 'САНХҮҮЖИЛТ ТӨЛСӨН',
      amount: 238232000,
      percent: -12,
    ),
  ];

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: paymentColor,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 15, top: 10, bottom: 10),
                            child: const Text(
                              'Төлбөр тооцоо удирдлага',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 120,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: reviewData.length,
                              itemBuilder: (context, index) => StatsCard(
                                data: reviewData[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
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
                              duration: const Duration(milliseconds: 300),
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
              ],
            ),
          ),
        ];
      },
      body: isLoading == true
          ? const SizedBox()
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
                              'Орлогын бүтэц',
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
                              child: const Row(
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
                      const SizedBox(
                        height: 10,
                      ),
                      PieChart(
                        legend: legend,
                        colorList: colorList,
                        data: data,
                        module: "PAYMENT",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Орлогын гүйлгээ',
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
                              child: const Row(
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
                            ColumnSeries<Payment, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) => paymentColor,
                              dataSource: asdf,
                              xValueMapper: (gdp, _) => gdp.date,
                              yValueMapper: (gdp, _) => gdp.incomeAmount,
                            ),
                          ],
                          primaryXAxis: CategoryAxis(),
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
                              'Орлогын бүтэц',
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
                              child: const Row(
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
                      const SizedBox(
                        height: 10,
                      ),
                      PieChart(
                        legend: legend,
                        colorList: colorList,
                        data: data,
                        module: "PAYMENT",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Орлогын гүйлгээ',
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
                              child: const Row(
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
                            ColumnSeries<Payment, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) => paymentColor,
                              dataSource: dashboard.byInterval!,
                              xValueMapper: (gdp, _) => gdp.date,
                              yValueMapper: (gdp, _) =>
                                  user.currentBusiness?.type == "SUPPLIER"
                                      ? gdp.incomeAmount
                                      : gdp.outcomeAmount,
                            ),
                          ],
                          primaryXAxis: CategoryAxis(),
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
