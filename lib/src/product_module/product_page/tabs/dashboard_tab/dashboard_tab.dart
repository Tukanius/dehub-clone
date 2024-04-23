import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inventory_reference.dart';
import 'package:dehub/src/product_module/screens/price_group/price_group.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/src/product_module/screens/supplier_list/supplier_list.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
// import 'package:dehub/components/pie_chart/pie_chart.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

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
    productColor,
    userColor,
    partnerColor,
  ];

  @override
  afterFirstLayout(BuildContext context) {
    if (Permission().check(user, "ERP_DASH")) {
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
      });
    }
    setState(() {
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
            child: const Text(
              'Бараа удирдлага',
              style: TextStyle(
                  color: grey3, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                if (user.currentBusiness?.type == "SUPPLIER" &&
                    Permission().check(user, "ERP_GDS", boolean: 'isView'))
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context).pushNamed(
                        ProductListPage.routeName,
                      );
                    },
                    boxColor: productColor.withOpacity(0.1),
                    padding: 9,
                    labelText: "Барааны жагсаалт",
                    svgColor: productColor,
                    svg: 'assets/svg/grid1.svg',
                  ),
                if (user.currentBusiness?.type == "BUYER" &&
                    Permission().check(user, "ERP_STORE"))
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context).pushNamed(SupplierList.routeName);
                    },
                    boxColor: productColor.withOpacity(0.1),
                    padding: 9,
                    labelText: 'Нийлүүлэгчдийн бараа',
                    svgColor: productColor,
                    svg: 'assets/svg/grid1.svg',
                  ),

                // DashboardCard(
                //   onClick: () {},
                //   boxColor: productColor.withOpacity(0.1),
                //   padding: 8,
                //   labelText: 'Ажил, үйлчилгээ',
                //   svgColor: productColor,
                //   svg: 'assets/svg/headset.svg',
                // ),
                DashboardCard(
                  onClick: () {
                    Navigator.of(context).pushNamed(PriceGroupPage.routeName);
                  },
                  boxColor: productColor.withOpacity(0.1),
                  padding: 7,
                  labelText: 'Үнийн бодлого',
                  svgColor: productColor,
                  svg: 'assets/svg/receipt_tax.svg',
                ),
                if (user.currentBusiness?.type == "SUPPLIER")
                  DashboardCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(InventoryReferencePage.routeName);
                    },
                    boxColor: productColor.withOpacity(0.1),
                    padding: 9,
                    labelText: 'Лавлах мэдээлэл',
                    svgColor: productColor,
                    svg: 'assets/svg/multi_box.svg',
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          if (Permission().check(user, "ERP_DASH"))
            isLoading == true
                ? const Center(
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
                      //                 color: productColor,
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w500,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 10,
                      //             ),
                      //             Icon(
                      //               Icons.arrow_forward_ios,
                      //               color: productColor,
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (user.currentBusiness?.type == "SUPPLIER")
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: const Text(
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: const Row(
                                      children: [
                                        Text(
                                          "Бүгдийг",
                                          style: TextStyle(
                                            color: productColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: productColor,
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
                              height: 180,
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                              ),
                              child: SfCartesianChart(
                                series: <ChartSeries>[
                                  BarSeries<InventoryGoods, String>(
                                    borderRadius: BorderRadius.circular(5),
                                    pointColorMapper: (datum, index) => datum
                                                .profileName ==
                                            "Эден"
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
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
        ],
      ),
    );
  }
}
