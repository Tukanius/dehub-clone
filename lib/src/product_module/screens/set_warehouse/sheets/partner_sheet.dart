import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class PartnerSheet extends StatefulWidget {
  final String id;
  const PartnerSheet({
    super.key,
    required this.id,
  });

  @override
  State<PartnerSheet> createState() => _PartnerSheetState();
}

class _PartnerSheetState extends State<PartnerSheet> with AfterLayoutMixin {
  bool isLoading = true;
  General general = General();
  Result merchStaff = Result(rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    merchStaff = await InventoryApi().warehousePartner(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Нийлүүлэгч партнер сонгох',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
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
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: productColor,
                    ),
                  )
                : Column(
                    children: [
                      Column(
                        children: merchStaff.rows!
                            .map(
                              (data) => InkWell(
                                onTap: () {
                                  source.partner(data);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  color: transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${data.businessName}"),
                                      SvgPicture.asset(
                                        'assets/svg/double-check.svg',
                                        colorFilter: ColorFilter.mode(
                                            source.product.taxType == data
                                                ? productColor
                                                : grey3,
                                            BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
