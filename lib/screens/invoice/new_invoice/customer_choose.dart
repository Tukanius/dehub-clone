import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: buttonColor2,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close_rounded,
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
                          labelColor: buttonColor2,
                          unselectedLabelColor: grey3,
                          indicatorColor: buttonColor2,
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
                      Container(
                        color: white,
                        height: 50,
                        padding: const EdgeInsets.only(
                            left: 16, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: grey3.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.search),
                            ),
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: grey3.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
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
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
