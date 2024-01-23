import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdditionalUnitCard extends StatefulWidget {
  final bool? isSwitched;
  final InventoryGoods data;
  final Function() onClick;
  final Function()? closeClick;
  final Function(bool value)? buttonClick;
  final int index;
  const AdditionalUnitCard({
    super.key,
    required this.index,
    this.buttonClick,
    required this.onClick,
    required this.data,
    this.closeClick,
    this.isSwitched,
  });

  @override
  State<AdditionalUnitCard> createState() => _AdditionalUnitCardState();
}

class _AdditionalUnitCardState extends State<AdditionalUnitCard> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return GestureDetector(
      onTap: widget.onClick,
      child: widget.isSwitched != null
          ? Container(
              padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.data.name}',
                    style: const TextStyle(fontSize: 14, color: grey2),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      activeColor: paymentColor,
                      value: widget.isSwitched as bool,
                      onChanged: widget.buttonClick,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.closeClick,
                        child: SvgPicture.asset(
                          'assets/svg/square-x.svg',
                          colorFilter: ColorFilter.mode(
                              dark.withOpacity(0.5), BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.data.name}',
                        style: const TextStyle(color: dark),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      source.product.additionalUnits?[widget.index]
                                  .convertValue ==
                              null
                          ? const Text(
                              'Тохируулах',
                              style: TextStyle(color: productColor),
                            )
                          : const Text(
                              'Тохируулсан',
                              style: TextStyle(color: productColor),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: productColor,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
