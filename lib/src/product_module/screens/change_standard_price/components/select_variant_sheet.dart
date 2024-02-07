import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/change_standard_price/components/standard_price_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';

class SelectVariantSheet extends StatefulWidget {
  final Result variants;
  final List<InventoryGoods> selectedVariants;
  final ListenController listenController;
  const SelectVariantSheet({
    super.key,
    required this.listenController,
    required this.selectedVariants,
    required this.variants,
  });

  @override
  State<SelectVariantSheet> createState() => _SelectVariantSheetState();
}

class _SelectVariantSheetState extends State<SelectVariantSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 50, top: 20),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: widget.variants.rows!
              .map(
                (data) => StandardPriceCard(
                  isSelected: false,
                  data: data,
                  onClick: () {
                    setState(() {
                      widget.selectedVariants.add(data);
                      widget.variants.rows?.remove(data);
                    });
                    widget.listenController.changeVariable('add');
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
