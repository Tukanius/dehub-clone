import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as chart;

class PieChart extends StatefulWidget {
  final Map<String, double> data;
  final List<Color> colorList;
  final List legend;
  final String module;
  const PieChart({
    super.key,
    required this.module,
    required this.legend,
    required this.colorList,
    required this.data,
  });

  @override
  State<PieChart> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  List legend = [];

  @override
  void initState() {
    if (widget.legend.length > 5) {
      for (var i = 0; i < 5; i++) {
        legend.add(widget.legend[i]);
      }
    } else {
      for (var i = 0; i < widget.legend.length; i++) {
        legend.add(widget.legend[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
            children: legend
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
                                .elementAt(legend.indexOf(data)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            widget.module == "FINANCE"
                                ? '${data.amount != null ? data.amount.toInt() : 0}'
                                : widget.module == "INVOICE"
                                    ? '${data.name}'
                                    : widget.module == "ORDER"
                                        ? '${Utils().formatCurrency("${data.amount}")}₮'
                                        : widget.module == "PAYMENT"
                                            ? '${Utils().formatCurrency("${data.amount}")}₮'
                                            : widget.module == "INVENTORY"
                                                ? "${Utils().formatCurrency("${data.standardPrice}")}₮"
                                                : '${data.count}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.module == 'FINANCE'
                                ? "${data.count}"
                                : widget.module == "INVOICE"
                                    ? "${data.invoiceCount}"
                                    : widget.module == "ORDER"
                                        ? '${data.ordersCount.toInt()}'
                                        : widget.module == "PAYMENT"
                                            ? "${data.percent.toInt()}%"
                                            : widget.module == "INVENTORY"
                                                ? '${data.soldCount.toInt()}'
                                                : '${(100 * data.count / legend.fold(0, (previousValue, element) => previousValue + element.count!)).toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(
                            widget.module == "FINANCE"
                                ? "${data.name}"
                                : widget.module == "INVOICE"
                                    ? '${Utils().formatCurrency("${data.amountToPay}")}₮'
                                    : widget.module == "ORDER"
                                        ? '${data.name}'
                                        : widget.module == "PAYMENT"
                                            ? "${data.name}"
                                            : widget.module == "INVENTORY"
                                                ? "${data.nameMon}"
                                                : '${data.profileName}',
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
