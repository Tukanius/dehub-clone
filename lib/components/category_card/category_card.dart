import 'package:dehub/screens/network_page/tabs/dashboard_tab/category_page/category_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String? text;
  final int? index;
  CategoryCard({
    Key? key,
    this.index,
    this.text,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.text == 'Товч тайлбар') {
          Navigator.of(context).pushNamed(CategoryDetailPage.routeName);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
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
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    '${widget.index! + 1}',
                    style: TextStyle(
                      color: grey3,
                      fontSize: 12,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ангилал нэр, код',
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
                      'Харилцагчийн ангилал',
                      style: TextStyle(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.text}',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: grey2,
            )
          ],
        ),
      ),
    );
  }
}
