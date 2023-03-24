import 'package:dehub/screens/invoice/tabs/give.dart';
import 'package:dehub/screens/invoice/tabs/take.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  ScrollController scrollController = ScrollController();

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
              indicatorColor: buttonColor,
              tabs: [
                Tab(
                  child: Container(
                    child: Text(
                      'Таны авах',
                      style: TextStyle(
                        color: buttonColor,
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
                        color: Colors.grey.shade400,
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
