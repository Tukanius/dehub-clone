import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CheckboxField extends StatefulWidget {
  final int index;
  final int fieldIndex;
  final InventoryGoods data;
  const CheckboxField({
    Key? key,
    required this.data,
    required this.fieldIndex,
    required this.index,
  }) : super(key: key);

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${widget.data.name}'),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: source.product.sections?[widget.index]
                          .fields?[widget.fieldIndex].checked !=
                      null
                  ? source.product.sections![widget.index]
                      .fields![widget.fieldIndex].checked!
                  : false,
              activeColor: productColor,
              onChanged: (value) {
                source.checkBoxField(value, widget.index, widget.fieldIndex);
              },
            ),
          )
        ],
      ),
    );
  }
}
