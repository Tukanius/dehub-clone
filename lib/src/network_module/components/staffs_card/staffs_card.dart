import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class StaffsCard extends StatefulWidget {
  final BusinessNetwork? data;
  const StaffsCard({
    super.key,
    this.data,
  });

  @override
  State<StaffsCard> createState() => _StaffsCardState();
}

class _StaffsCardState extends State<StaffsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      color: white,
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: grey,
            radius: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ажилтны нэр',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: dark,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'Ажилтны мэйл',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
              ),
              const Text(
                'Ажилтны утас',
                style: TextStyle(
                  color: dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
