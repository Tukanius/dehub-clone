import 'package:dehub/screens/network_page/tabs/dashboard_tab/zoning_page/zoning_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ZoningCard extends StatefulWidget {
  final int? index;
  ZoningCard({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<ZoningCard> createState() => _ZoningCardState();
}

class _ZoningCardState extends State<ZoningCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ZoningDetailPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(
            color: Color(0xffF2F2F2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.index! + 1}',
                  style: TextStyle(
                    color: grey3,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Бүсийн нэр, код',
                      style: TextStyle(
                        color: networkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Борлуулалт түгээлт',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 270,
                      child: Text(
                        'Товч тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар тайлбар',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grey2,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
