import 'package:dehub/screens/account_info_page/tabs/tabs/all.dart';
import 'package:dehub/screens/account_info_page/tabs/tabs/expenditure.dart';
import 'package:dehub/screens/account_info_page/tabs/tabs/income.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Index1 extends StatefulWidget {
  const Index1({Key? key}) : super(key: key);

  @override
  _Index1State createState() => _Index1State();
}

class _Index1State extends State<Index1> with SingleTickerProviderStateMixin {
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  int currentIndex = 0;

  late TabController tabController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        pickDateRange();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: grey2.withOpacity(0.5), width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${start.year} - ${start.month} - ${start.day}',
                              style: TextStyle(color: grey2),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 15,
                              color: paymentColor,
                            ),
                            Text(
                              '${end.year} - ${end.month} - ${end.day}',
                              style: TextStyle(color: grey2),
                            ),
                            SvgPicture.asset('images/calendar.svg')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changePage(0);
                          },
                          child: Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: tabController.index == 0
                                  ? paymentColor
                                  : white,
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                tabController.index != 0
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    : BoxShadow(),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Бүгд',
                                style: TextStyle(
                                  color:
                                      tabController.index == 0 ? white : grey2,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(1);
                          },
                          child: Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: tabController.index == 1
                                  ? paymentColor
                                  : white,
                              boxShadow: [
                                tabController.index != 1
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    : BoxShadow(),
                              ],
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Text(
                                'Орлого',
                                style: TextStyle(
                                  color:
                                      tabController.index == 1 ? white : grey2,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changePage(2);
                          },
                          child: Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: tabController.index == 2
                                  ? paymentColor
                                  : white,
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                tabController.index != 2
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    : BoxShadow(),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Зарлага',
                                style: TextStyle(
                                  color:
                                      tabController.index == 2 ? white : grey2,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              All(),
              Income(),
              Expenditure(),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: paymentColor,
              onPrimary: Colors.white,
              onSurface: paymentColor,
            ),
          ),
          child: child!,
        );
      },
      errorFormatText: 'Сүүлийн 6-н сар сонгоно уу!!!',
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (newDateRange == null) return;
    setState(() {
      dateTimeRange = newDateRange;
    });
  }
}
