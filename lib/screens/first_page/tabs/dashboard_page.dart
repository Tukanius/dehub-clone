import 'package:dehub/components/invoice_status/invoice_status_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<InvoiceData> data = [
    InvoiceData('Jan', 2000),
    InvoiceData('Feb', 8000),
    InvoiceData('Mar', 6000),
    InvoiceData('Apr', 4000),
    InvoiceData('May', 10000),
    InvoiceData('Jun', 12000),
  ];

  List<InvoiceData> data2 = [
    InvoiceData('Jan', 10000),
    InvoiceData('Feb', 500),
    InvoiceData('Mar', 6500),
    InvoiceData('Apr', 2300),
    InvoiceData('May', 1000),
    InvoiceData('Jun', 12000),
  ];

  final List<InvoiceStatusCard> cardList = [
    InvoiceStatusCard(
      title: "Таны авах",
    ),
    InvoiceStatusCard(
      title: "Таны өгөх",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: cardList,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.65,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: SfCartesianChart(
                trackballBehavior: TrackballBehavior(),
                margin: const EdgeInsets.symmetric(vertical: 40),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: "Мөнгөн Урсгал"),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<InvoiceData, String>>[
                  LineSeries<InvoiceData, String>(
                    color: Color(0xffEBCA6F),
                    name: 'Зарлага',
                    dataSource: data2,
                    xValueMapper: (InvoiceData invoice, _) => invoice.month,
                    yValueMapper: (InvoiceData invoice, _) => invoice.invoice,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: false,
                    ),
                  ),
                  LineSeries<InvoiceData, String>(
                    color: Color(0xff75cccd),
                    name: 'Орлого',
                    dataSource: data,
                    xValueMapper: (InvoiceData invoice, _) => invoice.month,
                    yValueMapper: (InvoiceData invoice, _) => invoice.invoice,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceData {
  final String? month;
  final double? invoice;

  InvoiceData(this.month, this.invoice);
}
