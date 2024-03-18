import 'package:dehub/models/business.dart';
import 'package:dehub/providers/index_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NetworkHorizontalChart extends StatefulWidget {
  final Business data;
  final String labelText;
  final int index;
  const NetworkHorizontalChart({
    super.key,
    required this.index,
    required this.labelText,
    required this.data,
  });

  @override
  State<NetworkHorizontalChart> createState() => _NetworkHorizontalChartState();
}

class _NetworkHorizontalChartState extends State<NetworkHorizontalChart> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = Provider.of<IndexProvider>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                widget.labelText,
                style: const TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectedIndex.indexChange(widget.index);
              },
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
              '${DateFormat("yyyy-MM-dd").format(widget.data.start!)} - ',
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
              DateFormat("yyyy-MM-dd").format(widget.data.end!),
              style: const TextStyle(
                color: grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
          ),
          child: SfCartesianChart(
            series: <ChartSeries>[
              BarSeries<Business, String>(
                borderRadius: BorderRadius.circular(5),
                pointColorMapper: (datum, index) => index == 1
                    ? networkDashboard2
                    : index == 0
                        ? networkColor
                        : grey2,
                dataSource: widget.data.stats!,
                xValueMapper: (gdp, _) => gdp.name,
                yValueMapper: (gdp, _) => gdp.count,
              ),
            ],
            primaryXAxis: CategoryAxis(),
          ),
        ),
      ],
    );
  }
}
