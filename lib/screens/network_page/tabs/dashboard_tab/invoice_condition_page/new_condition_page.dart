import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewConditionPage extends StatefulWidget {
  static const routeName = 'NewConditionPage';
  const NewConditionPage({super.key});

  @override
  State<NewConditionPage> createState() => _NewConditionPageState();
}

List<String> options = [
  'Баталснаас хойш 10 хоногт төлөх',
  "Баталсан дариу төлөх",
  "Баталсан сарын сүүлийн өдөр төлөх",
  "Баталсны дараа Х-ны өдөр төлөх",
  "Тайлбар мэдээлэл",
];

class _NewConditionPageState extends State<NewConditionPage> {
  String currentOption = options[0];

  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: IconThemeData(color: networkColor),
        title: Text(
          'Нэхэмжлэх - шинэ нөхцөл',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Нөхцөлийг сонгоно уу',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Column(
            //   children: options
            //       .map((e) => ListTile(
            //             tileColor: white,
            //             title: Text('${e}'),
            //             leading: Radio(
            //               value: options,
            //               groupValue: currentOption,
            //               onChanged: (value) {
            //                 setState(() {
            //                   currentOption = value.toString();
            //                 });
            //               },
            //             ),
            //           ))
            //       .toList(),
            // )
            for (var i = 0; i < options.length; i++)
              ListTile(
                tileColor: white,
                title: Text(
                  '${options[i]}',
                  style: TextStyle(
                    color: dark,
                    fontSize: 14,
                  ),
                ),
                leading: Radio(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => networkColor),
                  value: options[i],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                      index = i;
                    });
                  },
                ),
              ),
            // index == 0
            //     ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Нэмэлт тохиргоо',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: white,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Болсон',
                                  style: TextStyle(color: networkColor),
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 30,
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      this.index = index;
                                      print(index);
                                    });
                                  },
                                  children: [
                                    for (var i = 1; i < 31; i++)
                                      Center(
                                        child: Text('${i}'),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Хоногийн тоо',
                          style: TextStyle(color: dark),
                        ),
                        Row(
                          children: [
                            this.index == null
                                ? Text(
                                    '0',
                                    style: TextStyle(color: networkColor),
                                  )
                                : Text(
                                    '${this.index! + 1}',
                                    style: TextStyle(color: networkColor),
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'images/edit.svg',
                              color: networkColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // : index == 4
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             margin: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 10),
            //             child: Text(
            //               'Нэмэлт тохиргоо',
            //               style: TextStyle(
            //                 color: grey3,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               showCupertinoModalPopup(
            //                 context: context,
            //                 builder: (context) {
            //                   return Container(
            //                     color: white,
            //                     height: MediaQuery.of(context).size.height *
            //                         0.4,
            //                     child: Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.end,
            //                       children: [
            //                         TextButton(
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                           },
            //                           child: Text(
            //                             'Болсон',
            //                             style:
            //                                 TextStyle(color: networkColor),
            //                           ),
            //                         ),
            //                         Expanded(
            //                           child: CupertinoPicker(
            //                             itemExtent: 30,
            //                             onSelectedItemChanged: (index) {
            //                               setState(() {
            //                                 this.index = index;
            //                               });
            //                             },
            //                             children: [
            //                               for (var i = 1; i < 31; i++)
            //                                 Center(
            //                                   child: Text('${i}'),
            //                                 ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   );
            //                 },
            //               );
            //             },
            //             child: Container(
            //               color: white,
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 15, vertical: 10),
            //               child: Row(
            //                 mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     'Хоногийн тоо',
            //                     style: TextStyle(color: dark),
            //                   ),
            //                   Row(
            //                     children: [
            //                       this.index == null
            //                           ? Text(
            //                               '0',
            //                               style: TextStyle(
            //                                   color: networkColor),
            //                             )
            //                           : Text(
            //                               '${this.index! + 1}',
            //                               style: TextStyle(
            //                                   color: networkColor),
            //                             ),
            //                       SizedBox(
            //                         width: 5,
            //                       ),
            //                       SvgPicture.asset(
            //                         'images/edit.svg',
            //                         color: networkColor,
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     : SizedBox(),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: networkColor),
                    ),
                    child: CustomButton(
                      labelText: 'Буцах',
                      labelColor: backgroundColor,
                      textColor: networkColor,
                      onClick: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2.5, right: 10),
                    child: CustomButton(
                      labelColor: networkColor,
                      labelText: 'Хадгалах',
                      onClick: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
