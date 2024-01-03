import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VatSheet extends StatefulWidget {
  final InventoryGoods? data;
  const VatSheet({
    super.key,
    this.data,
  });

  @override
  State<VatSheet> createState() => _VatSheetState();
}

class _VatSheetState extends State<VatSheet> {
  General general = General();
  String? vatType;
  double? vatPercent;

  onSubmit() {
    final res = Provider.of<InventoryProvider>(context, listen: false);
    if (vatType == "STANDARD_RATED") {
      if (vatPercent != null) {
        res.vatType(vatType!, vatPercent!);
        Navigator.of(context).pop();
      } else {
        CustomScaffoldMessenger(
          context,
          color: productColor,
          labelText: 'Хувь оруулна уу',
        );
      }
    } else {
      res.vatType(vatType!, 0);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    vatType = widget.data?.vatType;
    vatPercent = widget.data?.vatPercent?.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: productColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
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
                Expanded(
                  child: Text(
                    'НӨАТ-ын төрөл сонгоно уу',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onSubmit();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                    ),
                    child: Text(
                      'Болсон',
                      style: TextStyle(
                        color: productColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      'Мэдээлэллийг оруулаад "болсон" сонгоно уу',
                    ),
                  ),
                  Column(
                    children: general.vatTypes!
                        .map(
                          (data) => GestureDetector(
                            onTap: () {
                              setState(() {
                                vatType = data.code.toString();
                              });
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  vatType == data.code
                                      ? SvgPicture.asset(
                                          'assets/svg/check-square.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/svg/minus-square.svg',
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("${data.name}"),
                                  data.code == "STANDARD_RATED"
                                      ? Expanded(
                                          child: FormTextField(
                                            readOnly:
                                                !(vatType == "STANDARD_RATED"),
                                            onChanged: (value) {
                                              setState(() {
                                                vatPercent =
                                                    double.tryParse(value);
                                              });
                                            },
                                            initialValue:
                                                "${vatPercent != null ? vatPercent?.toInt() : ''}",
                                            inputType: TextInputType.number,
                                            textColor: productColor,
                                            textAlign: TextAlign.end,
                                            name: 'vatPercent',
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: productColor),
                                              hintText: 'Хувь оруул',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 0,
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
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
      ),
    );
  }
}
