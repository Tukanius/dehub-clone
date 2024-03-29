import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: CustomButton(
              labelText: 'Calendar',
              textColor: black,
              onClick: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Calendar();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Card extends StatefulWidget {
  const Card({super.key});

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: SizedBox(
        height: 600,
        width: 350,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              bottom: isExpanded ? 80 : 100,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: black,
                ),
                height: 400,
                width: isExpanded ? 350 : 300,
              ),
            ),
            AnimatedPositioned(
              curve: Curves.ease,
              bottom: isExpanded ? 130 : 100,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {},
                onPanUpdate: onPanUpdate,
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.symmetric(
          horizontal: 15, vertical: MediaQuery.of(context).size.height * 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {
                  int year = int.parse(this.year);
                  int month = int.parse(this.month);
                  if (month > 1) {
                    setState(() {
                      month -= 1;
                      this.month = month.toString();
                    });
                  } else {
                    setState(() {
                      month = 12;
                      year -= 1;
                      this.month = month.toString();
                      this.year = year.toString();
                    });
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: Text(
                  "$year-$month",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  int year = int.parse(this.year);
                  int month = int.parse(this.month);
                  if (month < 12) {
                    setState(() {
                      month += 1;
                      this.month = month.toString();
                    });
                  } else {
                    setState(() {
                      month = 1;
                      year += 1;
                      this.month = month.toString();
                      this.year = year.toString();
                    });
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            shrinkWrap: true,
            children: [
              1,
              2,
              3,
              4,
              5,
              6,
              7,
              8,
              9,
              10,
              11,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              21,
              22,
              23,
              24,
              25,
              26,
              27,
              28,
              month != '2' || (int.parse(year) % 4) == 0 ? 29 : null,
              month != '2' ? 30 : null,
              month == "1" ||
                      month == "3" ||
                      month == "5" ||
                      month == "7" ||
                      month == "8" ||
                      month == "10" ||
                      month == "12"
                  ? 31
                  : null,
            ]
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = e.toString();
                      });
                    },
                    child: e != null
                        ? Container(
                            color: transparent,
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected == e.toString()
                                    ? invoiceColor
                                    : transparent,
                              ),
                              child: Center(
                                child: Text(
                                  "$e",
                                  style: TextStyle(
                                    color:
                                        selected == e.toString() ? white : null,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
