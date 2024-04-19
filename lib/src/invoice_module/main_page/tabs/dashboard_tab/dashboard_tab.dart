import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/closed_invoice/closed_invoice_page.dart';
import 'package:dehub/src/invoice_module/screens/invoice_list/invoice_list.dart';
import 'package:dehub/src/invoice_module/screens/payment_register/payment_register.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';

class DashBoardTab extends StatefulWidget {
  const DashBoardTab({super.key});

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> with AfterLayoutMixin {
  User user = User();
  Map<String, double> data = {};
  Invoice dashboard = Invoice(numberSurvey: []);
  bool isLoading = true;
  List<Color> colorList = [
    neonGreen,
    pieYellow,
    orange,
    red,
    brown,
    eggPlant,
  ];

  @override
  afterFirstLayout(BuildContext context) async {
    if (Permission().check(user, "INV_DASH")) {
      dashboard = await InvoiceApi().dashboard(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      for (var i = 0; i < dashboard.numberSurvey!.length; i++) {
        dashboard.numberSurvey?[i].image = svgs[i];
        dashboard.numberSurvey?[i].changedCount =
            dashboard.numberSurvey?[i].changedAmount;
      }
      Map<String, double> pieData = {};
      for (var data in dashboard.overdue!) {
        pieData[data.name!] = data.amountToPay!;
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

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: const Text(
              'Нэхэмжлэх удирдлага',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                if (Permission().check(user, "INV_LIST"))
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(InvoiceListPage.routeName);
                    },
                    boxColor: invoiceColor.withOpacity(0.1),
                    padding: 10,
                    labelText: 'Нээлттэй нэхэмжлэх',
                    svgColor: invoiceColor,
                    svg: 'assets/svg/take_invoice.svg',
                  ),
                if (user.currentBusiness?.type == "SUPPLIER" &&
                    Permission().check(user, "INV_NOTE_PAY"))
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(PaymentRegister.routeName);
                    },
                    boxColor: invoiceColor.withOpacity(0.1),
                    padding: 10,
                    labelText: 'Төлөлт бүртгэх',
                    svgColor: invoiceColor,
                    svg: 'assets/svg/closed_invoice.svg',
                  ),
                if (Permission().check(user, "INV_CLOSED"))
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(ClosedInvoicePage.routeName);
                    },
                    boxColor: invoiceColor.withOpacity(0.1),
                    padding: 8,
                    labelText: 'Хаагдсан нэхэмжлэх',
                    svgColor: invoiceColor,
                    svg: 'assets/svg/report_off.svg',
                  ),
              ],
            ),
          ),
          if (Permission().check(user, "INV_DASH"))
            Column(
              children: [
                isLoading == true
                    ? Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: invoiceColor,
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 10),
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
                const SizedBox(
                  height: 25,
                ),
                if (isLoading == false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Хугацаа хэтрэлтийн мэдээлэл',
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(InvoiceListPage.routeName);
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Row(
                                children: [
                                  Text(
                                    "Бүгдийг",
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: invoiceColor,
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
                          legend: dashboard.overdue!,
                          colorList: colorList,
                          data: data,
                          module: "INVOICE",
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: user.currentBusiness?.type == "SUPPLIER"
                                ? const Text(
                                    'Баталсан нэхэмжлэх',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : const Text(
                                    'Танай илгээсэн',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(InvoiceListPage.routeName);
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Row(
                                children: [
                                  Text(
                                    "Бүгдийг",
                                    style: TextStyle(
                                      color: invoiceColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: invoiceColor,
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
                            ColumnSeries<Invoice, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) =>
                                  invoiceColor.withOpacity(0.5),
                              dataSource: dashboard.confirmed!,
                              xValueMapper: (gdp, _) => gdp.date,
                              yValueMapper: (gdp, _) => gdp.confirmedAmount,
                            ),
                            ColumnSeries<Invoice, String>(
                              borderRadius: BorderRadius.circular(5),
                              pointColorMapper: (datum, index) => invoiceColor,
                              dataSource: dashboard.confirmed!,
                              xValueMapper: (gdp, _) => gdp.date,
                              yValueMapper: (gdp, _) => gdp.paidAmount,
                            ),
                          ],
                          primaryXAxis: CategoryAxis(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
              ],
            )
        ],
      ),
    );
  }
}
