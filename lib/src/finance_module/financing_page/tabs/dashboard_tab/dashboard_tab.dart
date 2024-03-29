import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/finance_module/screens/buyer_proposal/buyer_proposal.dart';
import 'package:dehub/src/finance_module/screens/program_page/program_page.dart';
import 'package:dehub/src/finance_module/screens/funding_request_page/funding_request_page.dart';
import 'package:dehub/src/finance_module/screens/recalled_page/recalled_page.dart';
import 'package:dehub/src/finance_module/screens/repayment_page/repayment_page.dart';
import 'package:dehub/src/finance_module/screens/received_funding_page/received_funding_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

class DashBoardTab extends StatefulWidget {
  const DashBoardTab({super.key});

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> with AfterLayoutMixin {
  Map<String, double> dummyData = {};
  Map<String, double> data = {};
  List<Finance> legend = [];
  Finance dashboard = Finance(numberSurvey: [], byInterval: [], byProgram: []);
  Result programs = Result(rows: []);
  bool isLoading = true;
  User user = User();
  PageController pageController = PageController();
  int currentPage = 0;

  Map<String, dynamic> pieChart = {
    "Санхүүжилт авсан": 3,
    "Санхүүжилт хүссэн": 3,
    "Олголт хүлээж буй": 3,
    "Боломжит лимит": 3,
    "Үлдэгдэл лимит": 3,
  };

  List<Color> colorList = [
    orderColor,
    pieBlue,
    pieYellow,
    pieOrange,
    pieRed,
  ];

  main(String url, String? programId) async {
    dashboard = await FinanceApi().dashboardMain(
      url,
      DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(hours: 8))),
      DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 7))),
      DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(hours: 8))),
      programId ?? '',
    );
    for (var data in dashboard.numberSurvey!) {
      this.data[data.name!] = data.amount ?? 0;
    }
    for (var i = 0; i < dashboard.numberSurvey!.length; i++) {
      dashboard.numberSurvey?[i].image = svgs[i];
    }
  }

  List<String> svgs = [
    'assets/svg/income_review.svg',
    'assets/svg/expenditure_review.svg',
    'assets/svg/finance_review.svg',
    'assets/svg/paid_review.svg',
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    programs = await FinanceApi().programSelect(source.url);
    await main(source.url, null);
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        Finance(
          count: value,
          name: key,
        ),
      );
    });
    setState(() {
      dummyData = pieData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).financeUser;
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
                    'Санхүүжилт удирдлага',
                    style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
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
                              .pushNamed(ProgramPage.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 10,
                        labelText: 'Боломжит нэхэмжлэх',
                        svgColor: source.currentColor,
                        svg: 'assets/svg/available_invoice.svg',
                      ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(FundingRequestPage.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 10,
                        labelText: 'Санхүүжих хүсэлт',
                        svgColor: source.currentColor,
                        svg: 'assets/svg/sanhuujiltS.svg',
                      ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(ReceivedFundingPage.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 10,
                        labelText: 'Авсан санхүүжилт',
                        svgColor: source.currentColor,
                        svg: 'assets/svg/camera.svg',
                      ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context).pushNamed(RePayment.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 10,
                        labelText: 'Эргэн төлөлтүүд',
                        svgColor: source.currentColor,
                        svg: 'assets/svg/payback.svg',
                      ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(ReCalledPage.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 10,
                        labelText: 'Буцаан дуудсан',
                        svgColor: source.currentColor,
                        svg: 'assets/svg/return.svg',
                      ),
                      DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(BuyerProposal.routeName);
                        },
                        boxColor: source.currentColor.withOpacity(0.1),
                        padding: 8,
                        labelText: user.currentBusiness?.type == "SUPPLIER"
                            ? 'Buyer-ийн санал'
                            : "Supplier-ийн санал",
                        svgColor: source.currentColor,
                        svg: 'assets/svg/writing.svg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
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
          ? Center(
              child: CircularProgressIndicator(
                color: source.currentColor,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Хөтөлбөрийн лимит',
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
                                      color: source.currentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: source.currentColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
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
                      if (dummyData.isNotEmpty)
                        PieChart(
                          legend: legend,
                          colorList: colorList,
                          data: dummyData,
                          module: "FINANCE",
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
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
                                      color: source.currentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: source.currentColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
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
                            BarSeries<Finance, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) =>
                                  datum.profileName == "Зөвшөөрсөн"
                                      ? networkDashboard2
                                      : datum.profileName == "Илгээсэн"
                                          ? source.currentColor
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
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Хөтөлбөрийн лимит',
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
                                      color: source.currentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: source.currentColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
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
                          legend: dashboard.byProgram!,
                          colorList: colorList,
                          data: data,
                          module: "FINANCE",
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
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
                                      color: source.currentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: source.currentColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
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
                            BarSeries<Finance, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) =>
                                  datum.profileName == "Зөвшөөрсөн"
                                      ? networkDashboard2
                                      : datum.profileName == "Илгээсэн"
                                          ? source.currentColor
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
                ),
              ],
            ),
    );
  }
}
