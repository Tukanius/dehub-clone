import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SystemUsersPage extends StatefulWidget {
  const SystemUsersPage({super.key});

  @override
  State<SystemUsersPage> createState() => _SystemUsersPageState();
}

class _SystemUsersPageState extends State<SystemUsersPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          for (var i = 0; i < 10; i++)
            Column(
              children: [
                Container(
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
                            margin: const EdgeInsets.only(left: 15, top: 15),
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
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Bolormaa.Ch',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0xff263238),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: grey3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'System admin',
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 16,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1),
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xff33A853).withOpacity(0.4),
                                      border: Border.all(
                                        color: grey3.withOpacity(0.4),
                                      ),
                                    ),
                                    child: Text(
                                      'Идэвхтэй',
                                      style:
                                          TextStyle(color: green, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  '9999-9999, bolormaa@gmail.com',
                                  style: TextStyle(
                                    color: Color(0xff636E72),
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
                SizedBox(
                  height: 5,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
