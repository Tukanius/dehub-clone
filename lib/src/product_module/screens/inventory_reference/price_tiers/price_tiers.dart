import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/price_tiers/add_price_tiers.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventoryPriceTiers extends StatefulWidget {
  static const routeName = '/InventoryPriceTiers';
  const InventoryPriceTiers({super.key});

  @override
  State<InventoryPriceTiers> createState() => InventoryPriceTiersState();
}

class InventoryPriceTiersState extends State<InventoryPriceTiers> {
  General general = General();
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Үнийн бүлэг',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text('Бүртгэсэн жагсаалт'),
            ),
            Column(
              children: general.tiers!
                  .map(
                    (data) => Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data.name != null
                                  ? Text(
                                      '${data.name}',
                                      style:
                                          const TextStyle(color: productColor),
                                    )
                                  : const Text(
                                      '.....',
                                      style: TextStyle(color: productColor),
                                    ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Price Tier ${general.tiers?.indexOf(data)}',
                                style: const TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                          if (Permission()
                              .check(user, "ERP_REF_TIE", boolean: 'isEdit'))
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) => AddPriceTiers(
                                    data: data,
                                  ),
                                );
                              },
                              child: Container(
                                color: transparent,
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/svg/edit_rounded.svg',
                                  colorFilter: const ColorFilter.mode(
                                      productColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
