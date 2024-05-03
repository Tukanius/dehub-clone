import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreenArguments {
  List data;
  DashboardScreenArguments({
    required this.data,
  });
}

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  final List data;
  const DashboardScreen({
    super.key,
    required this.data,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      floatingActionButton: const CustomCloseButton(
        svgColor: productColor,
      ),
      body: SafeArea(
        child: Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Column(
              children: [
                Expanded(
                  child: SfCartesianChart(
                    series: <ChartSeries>[
                      BarSeries<dynamic, String>(
                        borderRadius: BorderRadius.circular(5),
                        pointColorMapper: (datum, index) => productColor,
                        dataSource: widget.data,
                        xValueMapper: (gdp, _) => gdp.name,
                        yValueMapper: (gdp, _) => gdp.minQuantity,
                      ),
                      BarSeries<dynamic, String>(
                        borderRadius: BorderRadius.circular(5),
                        pointColorMapper: (datum, index) =>
                            productColor.withOpacity(0.5),
                        dataSource: widget.data,
                        xValueMapper: (gdp, _) => gdp.name,
                        yValueMapper: (gdp, _) => gdp.availableQuantity,
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
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: productColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Заавал байх үлдэгдэл'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: productColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Бодит үлдэгдэл'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
