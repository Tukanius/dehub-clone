import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/screens/invoice/new_invoice/new_invoice.dart';
import 'package:dehub/screens/invoice/tabs/give.dart';
import 'package:dehub/screens/invoice/tabs/take.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  static const routeName = '/invoicepage';
  final int? index;
  const InvoicePage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: invoiceColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(fontSize: 17, color: invoiceColor),
              )
            ],
          ),
        ),
        actions: [
          AddButton(
            color: invoiceColor,
            onClick: () {
              Navigator.of(context).pushNamed(NewInvoice.routeName);
            },
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: white,
              height: 50.0,
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                unselectedLabelColor: grey3,
                indicatorColor: invoiceColor,
                labelColor: invoiceColor,
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              TakePage(),
              GivePage(),
            ],
          ),
        ),
      ),
    );
  }
}
