import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TaxSheet extends StatefulWidget {
  const TaxSheet({
    super.key,
  });

  @override
  State<TaxSheet> createState() => _TaxSheetState();
}

class _TaxSheetState extends State<TaxSheet> {
  General general = General();
  double? taxPercent;

  bool? taxType;

  onSubmit() {
    final res = Provider.of<InventoryProvider>(context, listen: false);
    if (taxType == true) {
      if (taxPercent == null) {
        customScaffoldMessenger(context,
            color: productColor, labelText: 'Хувь оруулна уу');
      } else {
        res.taxType(taxType!, taxPercent!);
        Navigator.of(context).pop();
      }
    } else {
      res.taxType(taxType!, 0);
      Navigator.of(context).pop();
    }
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
            decoration: const BoxDecoration(
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
                const Expanded(
                  child: Text(
                    'НХАТ-тай эсэх',
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
                    child: const Text(
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
                    child: const Text(
                      'Мэдээлэллийг оруулаад "болсон" сонгоно уу',
                    ),
                  ),
                  Column(
                    children: [true, false]
                        .map(
                          (data) => GestureDetector(
                            onTap: () {
                              setState(() {
                                taxType = data;
                              });
                            },
                            child: Container(
                              color: transparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  taxType == data
                                      ? SvgPicture.asset(
                                          'assets/svg/check-square.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/svg/minus-square.svg',
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  data == true
                                      ? const Text("Тийм")
                                      : const Text("Үгүй"),
                                  if (data == true)
                                    Expanded(
                                      child: FormTextField(
                                        onChanged: (value) {
                                          setState(() {
                                            taxPercent = double.tryParse(value);
                                          });
                                        },
                                        initialValue: taxPercent != null
                                            ? taxPercent.toString()
                                            : "",
                                        inputType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textColor: productColor,
                                        textAlign: TextAlign.end,
                                        name: 'taxPercent',
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: productColor),
                                          hintText: 'Хувь оруул',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal: 0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
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
      ),
    );
  }
}
