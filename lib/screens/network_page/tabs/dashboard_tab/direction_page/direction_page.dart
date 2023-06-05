import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/direction_card/direction_card.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/direction_page/add_direction.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DirectionPage extends StatefulWidget {
  static const routeName = 'DirectionPage';
  const DirectionPage({super.key});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
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
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => buildSheet(),
              );
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
                'Чиглэл',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (var i = 0; i < 4; i++)
              DirectionCard(
                index: i,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) => AddDirection(),
      );
}
