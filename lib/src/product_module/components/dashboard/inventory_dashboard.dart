import 'package:dehub/components/pie_chart/pie_chart.dart';
import 'package:dehub/components/stats_card/stats_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryDashboard extends StatefulWidget {
  final InventoryGoods data;
  final Function()? onClick;
  const InventoryDashboard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<InventoryDashboard> createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboard> {
  Map<String, double> pieData = {};
  List<Color> colorList = [
    const Color(0xff15CAB8),
    const Color(0xff44A6E9),
    const Color(0xffFEC600),
    const Color(0xffFF8548),
    const Color(0xffE2362F),
  ];

  List<String?> svgs = [
    'assets/svg/multi_box.svg',
    'assets/svg/bx_timer.svg',
    'assets/svg/box.svg',
    null,
    null,
    null,
    null,
  ];

  @override
  void initState() {
    for (var i = 0; i < widget.data.mostSold!.length; i++) {
      pieData[widget.data.mostSold![i].nameMon!] =
          widget.data.mostSold![i].soldCount!;
    }
    for (var i = 0; i < widget.data.numberSurvey!.length; i++) {
      widget.data.numberSurvey![i].image = svgs[i];
    }
    super.initState();
  }

  User user = User();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 120,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 15),
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.numberSurvey!.length,
            itemBuilder: (context, index) => StatsCard(
              data: widget.data.numberSurvey![index],
              module: 'INVENTORY',
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        if (widget.data.mostSold!.isNotEmpty)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Өндөр борлуулалттай',
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
                          .pushNamed(ProductListPage.routeName);
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.symmetric(vertical: 5),
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
              PieChart(
                module: "INVENTORY",
                legend: widget.data.mostSold!,
                colorList: colorList,
                data: pieData,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        if (user.currentBusiness?.type == "SUPPLIER" &&
            widget.data.stockInfo!.isNotEmpty)
          Center(
            child: TextButton(
              onPressed: widget.onClick,
              child: const Text(
                textAlign: TextAlign.center,
                'Нөөцөд анхаарах бараа',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
