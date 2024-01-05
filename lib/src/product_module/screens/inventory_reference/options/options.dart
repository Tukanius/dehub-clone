import 'package:dehub/src/product_module/screens/inventory_reference/options/tabs/product_tab.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/options/tabs/work_service_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  static const routeName = '/Options';
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: TabBarView(
          children: [
            ProductTab(),
            WorkServiceTab(),
          ],
        ),
      ),
    );
  }
}
