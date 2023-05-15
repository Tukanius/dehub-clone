import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SectorCard extends StatefulWidget {
  final Function()? onClick;
  const SectorCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<SectorCard> createState() => _SectorCardState();
}

class _SectorCardState extends State<SectorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Салбар №1: Түмэн дэлгүүр',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: dark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Дэлгэр сайхан ХХК  ТТД: 315466',
                            style: TextStyle(
                              color: dark,
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
                          color: dark,
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
    );
  }
}
