import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/src/entry_point/menu/suppliers/tabs/all.dart';
import 'package:dehub/src/entry_point/menu/suppliers/tabs/contractual.dart';
import 'package:dehub/src/entry_point/menu/suppliers/tabs/not_contractual.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SuppliersPage extends StatefulWidget {
  static const routeName = '/SuppliersPage';
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: purpleButtonColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Нийлүүлэгчид',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            centerTitle: false,
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        color: white,
                        child: TabBar(
                          labelColor: purpleButtonColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: purpleButtonColor,
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: Text('Бүгд'),
                            ),
                            Container(
                              child: Text('Гэрээт'),
                            ),
                            Container(
                              child: Text('Гэрээт биш'),
                            ),
                          ],
                        ),
                      ),
                      SearchButton(
                        color: purpleButtonColor,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                All(),
                Contractual(),
                NotContractual(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
