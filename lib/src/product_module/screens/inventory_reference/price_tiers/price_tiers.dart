import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/price_tiers/add_price_tiers.dart';
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

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
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
              child: Text('Бүртгэсэн жагсаалт'),
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
                                      style: TextStyle(color: productColor),
                                    )
                                  : Text(
                                      '.....',
                                      style: TextStyle(color: productColor),
                                    ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Price Tier ${general.tiers?.indexOf(data)}',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
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
                                colorFilter: ColorFilter.mode(
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
