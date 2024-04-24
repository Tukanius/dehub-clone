import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InformationTab extends StatefulWidget {
  final BusinessNetwork? data;
  const InformationTab({
    super.key,
    this.data,
  });

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
            child: const Text(
              'Ерөнхий мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Партнерийн нэр',
            secondText: '${widget.data?.partnerName}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Партнерийн код',
            secondText: '${widget.data?.partner?.refCode}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Бизнесийн нэр',
            secondText: '${widget.data?.profileName}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Бизнес код',
            secondText: '${widget.data?.refCode}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Санхүү ажилтан',
            secondText: '${widget.data?.financeStaff?.firstName}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Санхүү и-мэйл',
            secondText: '${widget.data?.financeStaff?.email}',
            secondTextColor: networkColor,
          ),
          FieldCard(
            paddingHorizontal: 10,
            paddingVertical: 15,
            color: white,
            labelText: 'Санхүү утас',
            secondText: '${widget.data?.financeStaff?.phone}',
            secondTextColor: networkColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Статус',
                  style: TextStyle(color: dark),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff01D462).withOpacity(0.1),
                  ),
                  child: const Text(
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
