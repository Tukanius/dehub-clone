import 'package:dehub/screens/invoice/new_invoice/customer_choose/salbar_songoh.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bugd extends StatefulWidget {
  static const routeName = '/bugd';
  const Bugd({super.key});

  @override
  State<Bugd> createState() => _BugdState();
}

class _BugdState extends State<Bugd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++)
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => buildSheet(),
                      );
                    },
                    child: Container(
                      height: 100,
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
                                          margin:
                                              const EdgeInsets.only(top: 16),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                            color: grey3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'Партнерийн нэр',
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBar(
                                        itemSize: 12,
                                        initialRating: 3,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ratingWidget: RatingWidget(
                                          full: Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          half: Icon(
                                            Icons.star_half,
                                            color: Colors.yellow,
                                          ),
                                          empty: Icon(
                                            Icons.star_border,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Text(
                                        '(11248)',
                                        style: TextStyle(
                                          color: Color(0xff636E72),
                                        ),
                                      ),
                                    ],
                                  ),
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

  Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) => SalbarSongoh(),
      );
}
