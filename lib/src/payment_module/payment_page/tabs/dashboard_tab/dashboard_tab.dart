import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/permission.dart';
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

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "PAY_DASH")) {
      Map<String, double> pieData = {};
      dashboard = await PaymentApi().dashboard(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM').format(DateTime.now()),
        DateFormat('yyyy-MM').format(DateTime.now()),
      );
      for (var data in dashboard.revenueStructure!) {
        pieData[data.name!] = data.amount!;
        legend.add(data);
      }
      for (var i = 0; i < dashboard.numberSurvey!.length; i++) {
        dashboard.numberSurvey?[i].image = svgs[i];
      }
      setState(() {
        data = pieData;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  List<String> svgs = [
    'assets/svg/income_review.svg',
    'assets/svg/expenditure_review.svg',
    'assets/svg/finance_review.svg',
    'assets/svg/paid_review.svg',
  ];

  List<Color> colorList = [
    networkColor,
    networkDashboard1,
    networkDashboard2,
    networkDashboard3,
    networkDashboard4,
  ];

  List<Payment> asdf = [
    Payment(
      date: 'III.11',
      incomeAmount: 150,
      outcomeAmount: 300,
      amount: 150,
    ),
    Payment(
      date: 'III.12',
      incomeAmount: 26,
      outcomeAmount: 85,
      amount: 26,
    ),
    Payment(
      date: 'III.13',
      incomeAmount: 64,
      outcomeAmount: 13,
      amount: 64,
    ),
    Payment(
      date: 'III.14',
      incomeAmount: 123,
      outcomeAmount: 75,
      amount: 34,
    ),
    Payment(
      date: 'III.15',
      incomeAmount: 123,
      outcomeAmount: 138,
      amount: 123,
    ),
    Payment(
      date: 'III.16',
      incomeAmount: 65,
      outcomeAmount: 247,
      amount: 65,
    ),
    Payment(
      date: 'III.17',
      incomeAmount: 23,
      outcomeAmount: 143,
      amount: 23,
    ),
  ];

  Map<String, double> dummyPie = {
    "B2B тооцооны орлого": 2549800000,
    "SCF олголтын гүйлгээ": 1380284000,
  };

  List<Payment> dummyLegend = [
    Payment(
      amount: 2549800000,
      name: 'B2B тооцооны орлого',
      percent: 70,
    ),
    Payment(
      amount: 1380284000,
      name: 'SCF олголтын гүйлгээ',
      percent: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Permission().check(user, "PAY_DASH")
        ? NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                if (isLoading == false)
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                                itemCount: dashboard.numberSurvey!.length,
                                itemBuilder: (context, index) => StatsCard(
                                  data: dashboard.numberSurvey![index],
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
                      ],
                    ),
                  ),
              ];
            },
            body: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: paymentColor,
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                              legend: dummyLegend,
                              colorList: colorList,
                              data: dummyPie,
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                  DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now()),
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
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: SfCartesianChart(
                                      series: <ChartSeries>[
                                        ColumnSeries<Payment, String>(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          pointColorMapper: (datum, index) =>
                                              paymentColor,
                                          dataSource: asdf,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.incomeAmount,
                                        ),
                                        ColumnSeries<Payment, String>(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          pointColorMapper: (datum, index) =>
                                              const Color(0xffEEA47F),
                                          dataSource: asdf,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.outcomeAmount,
                                        ),
                                        LineSeries<Payment, String>(
                                          pointColorMapper: (datum, index) =>
                                              networkColor,
                                          dataSource: asdf,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) => gdp.amount,
                                        ),
                                        LineSeries<Payment, String>(
                                          pointColorMapper: (datum, index) =>
                                              const Color(0xffEEA47F),
                                          dataSource: asdf,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.outcomeAmount,
                                        ),
                                      ],
                                      primaryXAxis: CategoryAxis(),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: networkColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Орлогын гүйлгээ',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffEEA47F),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Зарлагын гүйлгээ',
                                              style: TextStyle(
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: networkColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Орлогын гүйлгээ тоо',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 15,
                                              color: const Color(0xffEEA47F),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Зарлагын гүйлгээ тоо',
                                              style: TextStyle(
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                  DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now()),
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
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: SfCartesianChart(
                                      series: <ChartSeries>[
                                        ColumnSeries<Payment, String>(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          pointColorMapper: (datum, index) =>
                                              paymentColor,
                                          dataSource: dashboard.byInterval!,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.incomeAmount,
                                        ),
                                        ColumnSeries<Payment, String>(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          pointColorMapper: (datum, index) =>
                                              const Color(0xffEEA47F),
                                          dataSource: dashboard.byInterval!,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.outcomeAmount,
                                        ),
                                        LineSeries<Payment, String>(
                                          pointColorMapper: (datum, index) =>
                                              networkColor,
                                          dataSource: dashboard.byInterval!,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) => gdp.amount,
                                        ),
                                        LineSeries<Payment, String>(
                                          pointColorMapper: (datum, index) =>
                                              const Color(0xffEEA47F),
                                          dataSource: dashboard.byInterval!,
                                          xValueMapper: (gdp, _) => gdp.date,
                                          yValueMapper: (gdp, _) =>
                                              gdp.outcomeAmount,
                                        ),
                                      ],
                                      primaryXAxis: CategoryAxis(),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: networkColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Орлогын гүйлгээ',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffEEA47F),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Зарлагын гүйлгээ',
                                              style: TextStyle(
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                color: networkColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Орлогын гүйлгээ тоо',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 15,
                                              color: const Color(0xffEEA47F),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              'Зарлагын гүйлгээ тоо',
                                              style: TextStyle(
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
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          )
        : const NotFound(
            module: 'PAYMENT',
            labelText: 'Хандах эрх хүрэлцэхгүй байна',
          );
  }
}
