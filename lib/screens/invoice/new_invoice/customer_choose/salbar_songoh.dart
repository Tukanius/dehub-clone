import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/sector_card/sector_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: invoiceColor,
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
            color: Colors.orange,
            onClick: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 70),
              child: SearchButton(),
            ),
            Column(
              children: [
                for (var i = 0; i < 10; i++)
                  SectorCard(
                    onClick: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
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
