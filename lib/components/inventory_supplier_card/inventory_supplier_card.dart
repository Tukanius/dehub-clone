import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventorySupplierCard extends StatefulWidget {
  final Function()? onClick;
  final InventoryGoods? data;
  final int index;
  final bool? type;
  final bool startAnimation;
  InventorySupplierCard({
    required this.index,
    required this.startAnimation,
    this.data,
    this.type,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  _InventorySupplierCardState createState() => _InventorySupplierCardState();
}

class _InventorySupplierCardState extends State<InventorySupplierCard> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(width: 0.5, color: Color(0xffF2F2F2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          '${widget.data?.name}',
        ),
      ),
    );
  }
}
