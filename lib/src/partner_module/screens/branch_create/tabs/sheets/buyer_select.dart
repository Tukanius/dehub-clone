import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyerSelect extends StatefulWidget {
  final List<dynamic> buyers;
  const BuyerSelect({super.key, required this.buyers});

  @override
  State<BuyerSelect> createState() => _BuyerSelectState();
}

class _BuyerSelectState extends State<BuyerSelect> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: backgroundColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: widget.buyers.map((e) {
              int index = widget.buyers.indexOf(e);
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.buyers.removeAt(index);
                    source.selectBuyer(e);
                  });
                  if (widget.buyers.isEmpty) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text('${e.refCode} / ${e.profileName}'),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
