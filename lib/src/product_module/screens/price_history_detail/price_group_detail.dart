import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/product_module/components/standard_price_card/standard_price_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PriceGroupDetailArguments {
  String id;
  String type;
  PriceGroupDetailArguments({
    required this.id,
    required this.type,
  });
}

class PriceGroupDetail extends StatefulWidget {
  static const routeName = '/PriceGroupDetail';
  final String id;
  final String type;
  const PriceGroupDetail({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  State<PriceGroupDetail> createState() => _PriceGroupDetailState();
}

class _PriceGroupDetailState extends State<PriceGroupDetail>
    with AfterLayoutMixin {
  InventoryGoods get = InventoryGoods(variants: [], tiers: []);
  bool isLoading = true;
  General general = General();

  @override
  afterFirstLayout(BuildContext context) async {
    get = await InventoryApi().priceGroupGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  groupStatus() {
    final res = general.priceGroupStatus!
        .firstWhere((element) => element.code == get.priceGroupStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          "Үнийн жагсаалтын мэдээлэл",
          style: TextStyle(
            color: productColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Үнийн код',
                    secondText: get.refCode,
                    secondTextColor: productColor,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус',
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: green),
                          ),
                          child: Text(
                            '${groupStatus().name}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Жагсаалтын нэр',
                    secondText: get.name,
                    secondTextColor: productColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Тайлбар',
                    secondText: get.description,
                    secondTextColor: productColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Эхлэх огноо',
                    secondText: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(get.startDate!),
                    ),
                    secondTextColor: productColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    color: white,
                    labelText: 'Эхлэх огноо',
                    secondText: get.endDate != null
                        ? DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(get.endDate!),
                          )
                        : '-',
                    secondTextColor: productColor,
                  ),
                  if (get.variants!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        'Бараанууд',
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Column(
                    children: get.variants!
                        .map(
                          (e) => StandardPriceCard(data: e),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
