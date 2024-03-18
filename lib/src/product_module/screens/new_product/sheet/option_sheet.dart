import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/add_option_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/option_select.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/version_control_sheet.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class OptionSheet extends StatefulWidget {
  const OptionSheet({super.key});

  @override
  State<OptionSheet> createState() => _OptionSheetState();
}

class _OptionSheetState extends State<OptionSheet> with AfterLayoutMixin {
  Result option = Result(rows: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    option = await InventoryApi().optionSelect(true, false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    return Column(
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
                  'Барааны хувилбар үүсгэх',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    builder: (context) => const VersionControlSheet(),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                  ),
                  child: const Text(
                    'Үүсгэх',
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Сонгосон хувилбар',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                        source.values.isEmpty
                            ? Container(
                                padding: const EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                color: white,
                                child: const Text(
                                  'Хувилбар сонгоогүй байна',
                                  style: TextStyle(color: grey2),
                                ),
                              )
                            : Column(
                                children: source.values
                                    .map(
                                      (data) => Container(
                                        color: white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.name}',
                                                  style: const TextStyle(
                                                      color: productColor),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: grey2,
                                                    ),
                                                    children: data.values!
                                                        .map(
                                                          (item) => item.id ==
                                                                  data.values
                                                                      ?.last.id
                                                              ? TextSpan(
                                                                  text:
                                                                      "${item.name}",
                                                                )
                                                              : TextSpan(
                                                                  text:
                                                                      "${item.name}, ",
                                                                ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                int index =
                                                    source.values.indexOf(data);
                                                source.remove(index);
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                color: transparent,
                                                child: SvgPicture.asset(
                                                  'assets/svg/close.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          grey2,
                                                          BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Хувилбараас сонгоно уу',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                        Column(
                          children: option.rows!
                              .map(
                                (data) => FieldCard(
                                  paddingHorizontal: 15,
                                  paddingVertical: 10,
                                  color: white,
                                  labelText: '${data.name}',
                                  secondText: '${data.values.length} хувилбар',
                                  secondTextColor: productColor,
                                  arrowColor: productColor,
                                  onClick: () {
                                    showModalBottomSheet(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) => OptionSelectSheet(
                                        data: data,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Сонголт тохирохгүй бол хувилбар нэмнэ үү',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                        CustomButton(
                          onClick: () async {
                            Navigator.of(context).pop();
                            await showModalBottomSheet(
                              context: context,
                              builder: (context) => const AddOptionSheet(),
                            );
                          },
                          labelText: 'Хувилбар нэмэх',
                          textColor: productColor,
                          borderColor: grey2.withOpacity(0.5),
                          labelColor: const Color(0xffE9E9EA),
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
    );
  }
}
