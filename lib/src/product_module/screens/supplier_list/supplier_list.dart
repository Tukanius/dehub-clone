import 'package:dehub/src/product_module/screens/supplier_list/tabs/contracted_tab.dart';
import 'package:dehub/src/product_module/screens/supplier_list/tabs/non_contracted_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SupplierList extends StatefulWidget {
  static const routeName = '/SupplierList';
  const SupplierList({super.key});

  @override
  State<SupplierList> createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          surfaceTintColor: white,
          backgroundColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: productColor),
          title: const Text(
            'Нийлүүлэгчид',
            style: TextStyle(
                color: productColor, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            dividerColor: transparent,
            labelColor: productColor,
            indicatorColor: productColor,
            overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
            tabs: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('Гэрээт'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('Гэрээт биш'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ContractedTab(),
            NonContractedTab(),
          ],
        ),
      ),
    );
  }
}
