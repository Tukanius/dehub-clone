import 'package:dehub/components/dashboard_card/dashboard_card.dart';
// import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/src/product_module/screens/supplier_list/supplier_list.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  User user = User();

  Map<String, double> data = {};
  List<InventoryGoods> legend = [];
  InventoryGoods confirmed = InventoryGoods();
  bool isLoading = true;
  Map<String, dynamic> pieChart = {
    "Сэнгүр": 5,
    "Боргио": 2,
    "Сэрүүн": 3,
    "Касс": 7,
    "Эден": 10,
  };
  List<Color> colorList = [
    productColor,
    networkColor,
    userColor,
    partnerColor,
  ];

  @override
  afterFirstLayout(BuildContext context) {
    Map<String, double> pieData = {};
    pieChart.forEach((key, value) {
      pieData[key] = double.parse(value.toString());
      legend.add(
        InventoryGoods(
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

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).inventoryMe;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              'Бараа удирдлага',
              style: TextStyle(
                  color: grey3, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                user.currentBusiness?.type == "SUPPLIER"
                    ? DashboardCard(
                        onClick: () {
                          Navigator.of(context).pushNamed(
                            ProductListPage.routeName,
                            arguments: ProductListPageArguments(
                              id: '',
                            ),
                          );
                        },
                        boxColor: productColor.withOpacity(0.1),
                        padding: 9,
                        labelText: "Барааны жагсаалт",
                        svgColor: productColor,
                        svg: 'assets/svg/grid1.svg',
                      )
                    : DashboardCard(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(SupplierList.routeName);
                        },
                        boxColor: productColor.withOpacity(0.1),
                        padding: 9,
                        labelText: 'Нийлүүлэгчдийн бараа',
                        svgColor: productColor,
                        svg: 'assets/svg/grid1.svg',
                      ),
                DashboardCard(
                  onClick: () {},
                  boxColor: productColor.withOpacity(0.1),
                  padding: 9,
                  labelText: 'Ажил, үйлчилгээ',
                  svgColor: productColor,
                  svg: 'assets/svg/push.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: productColor.withOpacity(0.1),
                  padding: 7,
                  labelText: 'Үнийн бодлого',
                  svgColor: productColor,
                  svg: 'assets/svg/bag.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: productColor.withOpacity(0.1),
                  padding: 9,
                  labelText: 'Хөнгөлөлт, урамшуулал',
                  svgColor: productColor,
                  svg: 'assets/svg/map.svg',
                ),
                DashboardCard(
                  onClick: () {},
                  boxColor: productColor.withOpacity(0.1),
                  padding: 9,
                  labelText: 'Лавлах мэдээлэл',
                  svgColor: productColor,
                  svg: 'assets/svg/map.svg',
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
                    color: productColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       margin: const EdgeInsets.only(left: 15),
                    //       child: Text(
                    //         'Өндөр борлуулалттай',
                    //         style: TextStyle(
                    //           color: black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //         color: transparent,
                    //         padding: const EdgeInsets.symmetric(vertical: 5),
                    //         child: Row(
                    //           children: [
                    //             Text(
                    //               "Бүгдийг",
                    //               style: TextStyle(
                    //                 color: networkColor,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             Icon(
                    //               Icons.arrow_forward_ios,
                    //               color: networkColor,
                    //               size: 16,
                    //             ),
                    //             SizedBox(
                    //               width: 15,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // PieChart(legend: legend, colorList: colorList, data: data),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Нөөцөд анхаарах бараа',
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
                          BarSeries<InventoryGoods, String>(
                            borderRadius: BorderRadius.circular(5),
                            pointColorMapper: (datum, index) =>
                                datum.profileName == "Эден"
                                    ? green
                                    : datum.profileName == "Касс"
                                        ? pieYellow
                                        : datum.profileName == "Сэрүүн"
                                            ? pieOrange
                                            : datum.profileName == "Боргио"
                                                ? pieRed
                                                : brown,
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
                  ],
                ),
        ],
      ),
    );
  }
}
