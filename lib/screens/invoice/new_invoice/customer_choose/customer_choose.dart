import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerChoose extends StatefulWidget {
  static const routeName = '/customerchoose';
  const CustomerChoose({super.key});

  @override
  State<CustomerChoose> createState() => _CustomerChooseState();
}

class _CustomerChooseState extends State<CustomerChoose> {
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
            backgroundColor: brownButtonColor,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: brownButtonColor,
                padding: const EdgeInsets.all(13),
                child: SvgPicture.asset(
                  'images/close.svg',
                  height: 30,
                ),
              ),
            ),
            title: Text(
              'Харилцагч сонгох',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            actions: [
              AddButton(
                color: Colors.orange,
                onClick: () {},
              ),
            ],
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
                          labelColor: brownButtonColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: brownButtonColor,
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
                      SearchButton(),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Bugd(),
                Gereet(),
                GereetBish(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
