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
            surfaceTintColor: purpleButtonColor,
            backgroundColor: purpleButtonColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: white,
              ),
            ),
            title: const Text(
              'Нийлүүлэгчид',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: white,
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
                      const SizedBox(height: 10),
                      Material(
                        color: white,
                        child: TabBar(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          labelColor: purpleButtonColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: purpleButtonColor,
                          tabs: [
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: const Text('Бүгд'),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: const Text('Гэрээт'),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: const Text('Гэрээт биш'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SearchButton(
                        color: purpleButtonColor,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
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
