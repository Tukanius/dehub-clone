import 'package:dehub/components/sector_card/sector_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SectorTab extends StatefulWidget {
  const SectorTab({super.key});

  @override
  State<SectorTab> createState() => _SectorTabState();
}

class _SectorTabState extends State<SectorTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Харилцдаг салбар',
              style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
            ),
          ),
          SectorCard(),
          SectorCard(),
          SectorCard(),
        ],
      ),
    );
  }
}
