import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessSelectSheet extends StatefulWidget {
  final List data;
  final Function() api;
  const BusinessSelectSheet({
    super.key,
    required this.api,
    required this.data,
  });

  @override
  State<BusinessSelectSheet> createState() => BusinessSelectSheetState();
}

class BusinessSelectSheetState extends State<BusinessSelectSheet> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: true);

    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.data
                .map(
                  (e) => InkWell(
                    onTap: () async {
                      await source.selectBusiness(e);
                      widget.api();
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      color: transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.profileName} / ${e.refCode}'),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
