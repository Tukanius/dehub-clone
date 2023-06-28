import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose_tabs/gereet_bish.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerChooseArguments {
  ListenController listenController;
  ListenController partnerListenController;
  CustomerChooseArguments({
    required this.listenController,
    required this.partnerListenController,
  });
}

class CustomerChoose extends StatefulWidget {
  final ListenController listenController;
  final ListenController partnerListenController;

  static const routeName = '/customerchoose';
  const CustomerChoose({
    Key? key,
    required this.partnerListenController,
    required this.listenController,
  }) : super(key: key);

  @override
  State<CustomerChoose> createState() => _CustomerChooseState();
}

class _CustomerChooseState extends State<CustomerChoose> {
  // @override
  // void initState() {
  //   widget.listenController.addListener(() {});
  //   super.initState();
  // }

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
            backgroundColor: invoiceColor,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: invoiceColor,
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
                          labelColor: invoiceColor,
                          unselectedLabelColor: grey3,
                          indicatorColor: invoiceColor,
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
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Bugd(
                  listenController: widget.listenController,
                  partnerListenController: widget.partnerListenController,
                ),
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
