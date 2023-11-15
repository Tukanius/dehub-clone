import 'package:dehub/components/invoice_review_card/invoice_review_card.dart';
import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/invoice/tabs/dashboard_tab/closed_invoice/closed_invoice_page.dart';
import 'package:dehub/screens/invoice/tabs/dashboard_tab/invoice_list/give.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<Invoice> legend = [];
  Invoice confirmed = Invoice();
  bool isLoading = true;
  Map<String, dynamic> pieChart = {
    "Top 100": 3,
    "Top 50": 3,
    "Top 30": 3,
    "Top 10": 3,
    "Top 5": 3,
    "Top 1": 3,
  };
  List<Color> colorList = [
    neonGreen,
    pieYellow,
    orange,
    red,
    brown,
    eggPlant,
  ];

  @override
  afterFirstLayout(BuildContext context) {
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        Invoice(
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

  List<Invoice> reviewData = [
    Invoice(
      image: 'assets/svg/income_review.svg',
      firstName: 'ОРЛОГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
    ),
    Invoice(
      image: 'assets/svg/expenditure_review.svg',
      firstName: 'ЗАРЛАГЫН ГҮЙЛГЭЭ ДҮН',
      amount: 238232000,
    ),
    Invoice(
      image: 'assets/svg/finance_review.svg',
      firstName: 'САНХҮҮЖИЛТ АВСАН',
      amount: 238232000,
    ),
    Invoice(
      image: 'assets/svg/paid_review.svg',
      firstName: 'САНХҮҮЖИЛТ ТӨЛСӨН',
      amount: 238232000,
    ),
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
            child: Text(
              'Нэхэмжлэх удирдлага',
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemCount: reviewData.length,
              itemBuilder: (context, index) => InvoiceReviewCard(
                data: reviewData[index],
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(GivePage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: invoiceColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/take_invoice.svg',
                            colorFilter:
                                ColorFilter.mode(invoiceColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        user.currentBusiness?.type == "BUYER"
                            ? Text(
                                'Манай төлөх- нэхэмжлэл',
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w500),
                                softWrap: true,
                              )
                            : Text(
                                'Манай авах- нэхэмжлэл',
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w500),
                                softWrap: true,
                              ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ClosedInvoicePage.routeName);
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: invoiceColor.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/closed_invoice.svg',
                            colorFilter:
                                ColorFilter.mode(invoiceColor, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Хаагдсан нэхэмжлэх',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: invoiceColor.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/map.svg',
                          colorFilter:
                              ColorFilter.mode(invoiceColor, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Лавлах мэдээлэл',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
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
                    color: invoiceColor,
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
                          child: user.currentBusiness?.type == "SUPPLIER"
                              ? Text(
                                  'Баталсан нэхэмжлэх',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
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
                          BarSeries<Invoice, String>(
                            borderRadius: BorderRadius.circular(5),
                            pointColorMapper: (datum, index) =>
                                datum.name == "Зөвшөөрсөн"
                                    ? networkDashboard2
                                    : datum.name == "Илгээсэн"
                                        ? invoiceColor
                                        : grey2,
                            dataSource: legend,
                            xValueMapper: (gdp, _) => gdp.profileName,
                            yValueMapper: (gdp, _) => gdp.count,
                          )
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: grey,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Нээлттэй нэхэмжлэх',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2,740',
                                style: TextStyle(
                                  color: grey2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: neonGreen.withOpacity(0.2),
                                ),
                                child: Text(
                                  '+2,4%',
                                  style: TextStyle(
                                    color: neonGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
