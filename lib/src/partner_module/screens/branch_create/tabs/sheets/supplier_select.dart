import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierSelect extends StatefulWidget {
  final List<dynamic> suppliers;
  const SupplierSelect({super.key, required this.suppliers});

  @override
  State<SupplierSelect> createState() => _SupplierSelectState();
}

class _SupplierSelectState extends State<SupplierSelect> {
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
            children: widget.suppliers.map((e) {
              int index = widget.suppliers.indexOf(e);
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.suppliers.removeAt(index);
                    source.selectSupplier(e);
                  });
                  if (widget.suppliers.isEmpty) {
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
