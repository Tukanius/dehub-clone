import 'package:dehub/screens/menu/tabs/purchase_page.dart';
import 'package:dehub/screens/menu/tabs/sales_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  static const routeName = '/menupage';
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleButtonColor,
        elevation: 0,
        title: Text(
          'Буцах',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: TabBar(
                  labelColor: purpleButtonColor,
                  unselectedLabelColor: grey3,
                  indicatorColor: purpleButtonColor,
                  tabs: [
                    Container(
                      alignment: Alignment.center,
                      height: 48,
                      child: Text('Худалдан авалт'),
                    ),
                    Container(
                      child: Text('Борлуулалт'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              PurchasePage(),
              SalesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
