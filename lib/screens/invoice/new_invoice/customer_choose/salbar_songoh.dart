import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SalbarSongoh extends StatefulWidget {
  static const routeName = '/salbarsongoh';
  const SalbarSongoh({super.key});

  @override
  State<SalbarSongoh> createState() => _SalbarSongohState();
}

class _SalbarSongohState extends State<SalbarSongoh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: buttonColor2,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Салбар сонгох',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        actions: [
          AddButton(
            onClick: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 70),
              color: white,
              height: 50,
              padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: grey3.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.search,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: grey3.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 8),
                      child: SvgPicture.asset(
                        'images/yuluur.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                for (var i = 0; i < 10; i++)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 15, top: 15),
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    image: AssetImage('images/map.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 16),
                                          child: Text(
                                            'Салбар №1: Түмэн дэлгүүр',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xff263238),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Дэлгэр сайхан ХХК  ТТД: 315466',
                                          style: TextStyle(
                                            color: Color(0xff263238),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Text(
                                      '+976 - 9999 9999',
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
