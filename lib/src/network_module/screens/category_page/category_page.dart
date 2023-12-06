import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/category_card/category_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = 'CategoryPage';
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> data = [
    "Товч тайлбар",
    "Баталсан дариу төлөх",
    "Баталсан сарын сүүлийн өдөр төлөх",
    "Баталсны дараа сарын Х-ны өдөр төлөх",
    "Тайлбар мэдээлэл",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        leading: CustomBackButton(color: networkColor),
        leadingWidth: 100,
        actions: [
          AddButton(
            color: networkColor,
            addColor: white,
            onClick: () {
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   useSafeArea: true,
              //   context: context,
              //   builder: (context) => buildSheet(),
              // );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Ангилал',
                style: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Харилцагчийн анги',
                style: TextStyle(
                  color: networkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            for (var i = 0; i < data.length; i++)
              CategoryCard(
                index: i,
                text: data[i],
              ),
          ],
        ),
      ),
    );
  }

  // Widget buildSheet() => DraggableScrollableSheet(
  //       minChildSize: 0.5,
  //       maxChildSize: 1,
  //       initialChildSize: 1,
  //       builder: (context, scrollController) => AddCategory(),
  //     );
}
