import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NumberUnitSheet extends StatefulWidget {
  const NumberUnitSheet({
    super.key,
  });

  @override
  State<NumberUnitSheet> createState() => _NumberUnitSheetState();
}

class _NumberUnitSheetState extends State<NumberUnitSheet> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: const BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Жин сонгоно уу',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  color: transparent,
                  child: SvgPicture.asset('assets/svg/square-x.svg'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: general.unitWeightLabels!
                      .map(
                        (data) => InkWell(
                          onTap: () {
                            source.unitWeightLabel(data.name!, data.code!);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "${data.name}",
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
