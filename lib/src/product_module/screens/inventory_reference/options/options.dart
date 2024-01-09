import 'package:dehub/src/product_module/screens/inventory_reference/options/tabs/work_service_tab.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/options/tabs/product_tab.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/add_option_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  static const routeName = '/Options';
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 3,
        shadowColor: Colors.grey.shade300,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
          'Хувилбарын төрөл',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
          indicatorColor: productColor,
          labelColor: productColor,
          tabs: [
            Tab(
              text: 'Бараа бүтээгдэхүүн',
            ),
            Tab(
              text: 'Ажил үйлчилгээ',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddOptionSheet(
              isService: tabController.index == 0 ? false : true,
              isGoods: tabController.index == 1 ? false : true,
            ),
          );
        },
        backgroundColor: productColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: white),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ProductTab(),
          WorkServiceTab(),
        ],
      ),
    );
  }
}
