import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AdditionalInformationTab extends StatefulWidget {
  final InventoryGoods data;
  const AdditionalInformationTab({
    super.key,
    required this.data,
  });

  @override
  State<AdditionalInformationTab> createState() =>
      _AdditionalInformationTabState();
}

class _AdditionalInformationTabState extends State<AdditionalInformationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Категорийн мэдээлэл',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэмэлт мэдээлэл',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэмэлт',
                  style: TextStyle(color: productColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Бүтээгдэхүүний',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэмэлт мэдээлэл',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэмэлт',
                  style: TextStyle(color: productColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
