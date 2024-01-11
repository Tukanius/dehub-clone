import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SupplierTypeSheet extends StatefulWidget {
  const SupplierTypeSheet({
    super.key,
  });

  @override
  State<SupplierTypeSheet> createState() => _SupplierTypeSheetState();
}

class _SupplierTypeSheetState extends State<SupplierTypeSheet> {
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
          decoration: BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ханган нийлүүлэгч сонгоно уу',
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
                  children: general.supplierTypes!
                      .map(
                        (data) => InkWell(
                          onTap: () {
                            source.supplierType(data.name!, data.code!);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data.name}",
                                ),
                                SvgPicture.asset(
                                  'assets/svg/double-check.svg',
                                  colorFilter: ColorFilter.mode(
                                    source.product.manufacturerCountryName ==
                                            data.name
                                        ? productColor
                                        : Color(0xff9BACB2),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
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
