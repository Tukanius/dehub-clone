import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/components/additional_unit_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class AdditionalUnitSheet extends StatefulWidget {
  const AdditionalUnitSheet({
    super.key,
  });

  @override
  State<AdditionalUnitSheet> createState() => _AdditionalUnitSheetState();
}

class _AdditionalUnitSheetState extends State<AdditionalUnitSheet>
    with AfterLayoutMixin {
  General general = General();
  Result unit = Result(rows: []);
  List<InventoryGoods> list = [];
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    unit = await InventoryApi().unitSelect();
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    for (var i = 0; i < list.length; i++) {
      source.additinalUnit(list[i]);
    }
    Navigator.of(context).pop();
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
                    'Хэмжих нэгж сонгох',
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
            child: Container(
              color: backgroundColor,
              child: SingleChildScrollView(
                child: isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: productColor,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'Тохирох сонголт байхгүй бол "Лавлах мэдээлэл"-ийн хэмжих нэгжид нэмнэ үү.',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'Нэгжийн сонголт',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          Column(
                            children: unit.rows!
                                .map(
                                  (data) => AdditionalUnitCard(
                                    index: unit.rows!.indexOf(data),
                                    isSwitched: list.contains(data),
                                    onClick: () {
                                      if (list.contains(data)) {
                                        setState(() {
                                          list.removeWhere(
                                              (element) => element == data);
                                        });
                                      } else {
                                        setState(() {
                                          list.add(data);
                                        });
                                      }
                                    },
                                    buttonClick: (bool value) {
                                      if (list.contains(data)) {
                                        setState(() {
                                          list.removeWhere(
                                              (element) => element == data);
                                        });
                                      } else {
                                        setState(() {
                                          list.add(data);
                                        });
                                      }
                                    },
                                    data: data,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
