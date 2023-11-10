import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/rank_card/rank_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  static const routeName = '/RankPage';
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: CustomBackButton(color: networkColor),
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
                'Зэрэглэл',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'Харилцагчийн ангилал',
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
              RankCard(
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
  //       builder: (context, scrollController) => AddRank(),
  //     );
}
