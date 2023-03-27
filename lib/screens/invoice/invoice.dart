import 'package:dehub/screens/invoice/tabs/give.dart';
import 'package:dehub/screens/invoice/tabs/take.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  static const routeName = '/invoicepage';
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  var menu = [
    'Таны авах',
    'Таны өгөх',
  ];
  click(item) {
    switch (item) {
      case 'Таны авах':
        return print('12');
      case 'Таны өгөх':
        return currentIndex = 1;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: white,
            height: 50.0,
            child: TabBar(
              unselectedLabelColor: grey3,
              indicatorColor: buttonColor2,
              labelColor: buttonColor2,
              tabs: [
                Tab(
                  child: Container(
                    child: Text(
                      'Таны авах',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Таны өгөх',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TakePage(),
            GivePage(),
          ],
        ),
      ),
    );
  }
}
