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

class MerchStaffSheet extends StatefulWidget {
  const MerchStaffSheet({
    super.key,
  });

  @override
  State<MerchStaffSheet> createState() => _MerchStaffSheetState();
}

class _MerchStaffSheetState extends State<MerchStaffSheet>
    with AfterLayoutMixin {
  bool isLoading = true;
  General general = General();
  Result merchStaff = Result(rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    merchStaff = await InventoryApi().merchStaffSelect();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<InventoryProvider>(context, listen: false);
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
                  'Ажилтан сонгох',
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
                                  res.merchStaff(data);
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
                                      Row(
                                        children: [
                                          if (data.avatar != null)
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor: grey,
                                              backgroundImage: NetworkImage(
                                                  '${data.avatar}'),
                                            ),
                                          Text(
                                              "${data.lastName != null ? '${data.lastName[0]}.' : ''} ${data.firstName}"),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/double-check.svg',
                                        colorFilter: ColorFilter.mode(
                                            res.product.taxType == data
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
