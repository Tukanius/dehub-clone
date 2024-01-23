import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as chart;

class PieChart extends StatefulWidget {
  final Map<String, double> data;
  final List<Color> colorList;
  final List legend;
  const PieChart({
    super.key,
    required this.legend,
    required this.colorList,
    required this.data,
  });

  @override
  State<PieChart> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
        children: [
          chart.PieChart(
            dataMap: widget.data,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 35,
            chartRadius: 220,
            colorList: widget.colorList,
            initialAngleInDegree: 0,
            chartType: chart.ChartType.ring,
            ringStrokeWidth: 50,
            legendOptions: const chart.LegendOptions(
              showLegendsInRow: false,
              legendPosition: chart.LegendPosition.bottom,
              showLegends: false,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(fontSize: 10),
            ),
            chartValuesOptions: const chart.ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
            ),
          ),
          const SizedBox(
            height: 37,
          ),
          Column(
            children: widget.legend
                .map(
                  (data) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: widget.colorList
                                .elementAt(widget.legend.indexOf(data)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${data.count}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${(100 * data.count / widget.legend.fold(0, (previousValue, element) => previousValue + element.count!)).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 11,
                          child: Text(
                            '${data.profileName}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
