import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/zoning_card/zoning_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ZoningPage extends StatefulWidget {
  static const routeName = '/ZoningPage';
  const ZoningPage({super.key});

  @override
  State<ZoningPage> createState() => _ZoningPageState();
}

class _ZoningPageState extends State<ZoningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: networkColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: networkColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        actions: [
          AddButton(
            addColor: white,
            color: networkColor,
            onClick: () {
              // showModalBottomSheet(
              //   useSafeArea: true,
              //   isScrollControlled: true,
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
                'Бүсчлэл',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'Борлуулалт, түгээлт',
                style: TextStyle(
                  color: networkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            for (var i = 0; i < 4; i++)
              ZoningCard(
                index: i,
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
  //       builder: (context, scrollController) => AddZoning(),
  //     );
}
