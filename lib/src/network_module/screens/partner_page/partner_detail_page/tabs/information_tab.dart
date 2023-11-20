import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InformationTab extends StatefulWidget {
  final BusinessNetwork? data;
  const InformationTab({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<InformationTab> createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Ерөнхий мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнерийн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.partnerName}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнерийн код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.partner?.refCode}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бизнесийн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.partner?.businessName}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бизнес код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.refCode}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүү ажилтан',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.financeStaff?.firstName}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүү и-мэйл',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.financeStaff?.email}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Санхүү утас',
                  style: TextStyle(color: dark),
                ),
                Text(
                  '${widget.data?.financeStaff?.phone}',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Статус',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff01D462).withOpacity(0.1),
                  ),
                  child: Text(
                    'Идэвхтэй',
                    style: TextStyle(
                      color: Color(0xff01D462),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
