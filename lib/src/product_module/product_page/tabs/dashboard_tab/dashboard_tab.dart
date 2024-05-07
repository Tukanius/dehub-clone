import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/dashboard_card/dashboard_card.dart';
import 'package:dehub/components/dashboard_screen/dashboard_screen.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/components/dashboard/inventory_dashboard.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/inventory_reference.dart';
import 'package:dehub/src/product_module/screens/price_group/price_group.dart';
import 'package:dehub/src/product_module/screens/product_list_page/product_list_page.dart';
import 'package:dehub/src/product_module/screens/supplier_list/supplier_list.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> with AfterLayoutMixin {
  User user = User();
  InventoryGoods dashboard =
      InventoryGoods(mostSold: [], stockInfo: [], numberSurvey: []);
  bool isLoading = false;

  @override
  afterFirstLayout(BuildContext context) async {
    if (user.currentBusiness?.type == "SUPPLIER" &&
        Permission().check(user, "ERP_DASH")) {
      setState(() {
        isLoading = true;
      });
      dashboard = await InventoryApi().dashboard(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 14))),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      setState(() {
        isLoading = false;
      });
    }
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
          isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: productColor,
                  ),
                )
              : Permission().check(user, "ERP_DASH") &&
                      user.currentBusiness?.type == "SUPPLIER"
                  ? InventoryDashboard(
                      data: dashboard,
                      onClick: () {
                        Navigator.of(context).pushNamed(
                          DashboardScreen.routeName,
                          arguments: DashboardScreenArguments(
                            data: dashboard.stockInfo!,
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
