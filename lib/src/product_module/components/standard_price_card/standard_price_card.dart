import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class StandardPriceCard extends StatefulWidget {
  final InventoryGoods data;
  final bool? isSelected;
  final Function()? onClick;
  final String? perType;
  final String? perValue;
  const StandardPriceCard({
    super.key,
    this.onClick,
    this.perType,
    this.perValue,
    this.isSelected,
    required this.data,
  });

  @override
  State<StandardPriceCard> createState() => _StandardPriceCardState();
}

class _StandardPriceCardState extends State<StandardPriceCard> {
  General general = General();
  GlobalKey<FormBuilderState> asdf = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: FormBuilder(
        key: asdf,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.data.image}',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                        color: grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data.nameMon}',
                        style: const TextStyle(
                          color: productColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'SKU: ${widget.data.skuCode}',
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isSelected != null)
                  GestureDetector(
                    onTap: widget.onClick,
                    child: Container(
                      height: 30,
                      width: 30,
                      padding:
                          EdgeInsets.all(widget.isSelected == true ? 6 : 0),
                      decoration: BoxDecoration(
                        color: productColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: widget.isSelected == true
                          ? SvgPicture.asset(
                              'assets/svg/trash_can.svg',
                              colorFilter: const ColorFilter.mode(
                                  productColor, BlendMode.srcIn),
                            )
                          : const Icon(
                              Icons.add,
                              color: productColor,
                            ),
                    ),
                  ),
              ],
            ),
            if (widget.isSelected == null && widget.data.tiers != null)
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 5),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.data.tiers!
                        .where((element) => element.isSet == true)
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                title("${e.name}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  e.price != null
                                      ? '${Utils().formatCurrency(e.price.toString())}₮'
                                      : "-",
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            if (widget.isSelected == true)
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 5),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title('Стандарт үнэ'),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 100,
                          child: FormTextField(
                            inputType: TextInputType.number,
                            fontSize: 12,
                            name: '1',
                            initialValue:
                                "${widget.data.standardPrice?.toInt()}",
                            onChanged: (value) {
                              setState(() {
                                widget.data.standardPrice =
                                    double.tryParse(value);
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: grey2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 15),
                              isDense: true,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна уу'),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[0].name ??
                            'Tier ${general.tiers?[0].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[0].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '2',
                                  initialValue:
                                      '${widget.data.tier1Price != null ? widget.data.tier1Price?.toInt() : ''}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier1Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[1].name ??
                            'Tier ${general.tiers?[1].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[1].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '3',
                                  initialValue:
                                      '${widget.data.tier2Price != null ? widget.data.tier2Price?.toInt() : ''}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier2Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[2].name ??
                            'Tier ${general.tiers?[2].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[2].isSet == true
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '4',
                                  initialValue:
                                      '${widget.data.tier3Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier3Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[3].name ??
                            'Tier ${general.tiers?[3].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[3].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '5',
                                  initialValue:
                                      '${widget.data.tier4Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier4Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[4].name ??
                            'Tier ${general.tiers?[4].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[4].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '6',
                                  initialValue:
                                      '${widget.data.tier5Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier5Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[5].name ??
                            'Tier ${general.tiers?[5].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[5].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '7',
                                  initialValue:
                                      '${widget.data.tier6Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier6Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[6].name ??
                            'Tier ${general.tiers?[6].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[6].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '8',
                                  initialValue:
                                      '${widget.data.tier7Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier7Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[7].name ??
                            'Tier ${general.tiers?[7].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[7].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '9',
                                  initialValue:
                                      '${widget.data.tier8Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier8Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(general.tiers?[8].name ??
                            'Tier ${general.tiers?[8].tierNo}'),
                        const SizedBox(
                          height: 5,
                        ),
                        general.tiers?[8].name != null
                            ? SizedBox(
                                width: 100,
                                child: FormTextField(
                                  inputType: TextInputType.number,
                                  fontSize: 12,
                                  name: '0',
                                  initialValue:
                                      '${widget.data.tier9Price?.toInt()}',
                                  onChanged: (value) {
                                    setState(() {
                                      widget.data.tier9Price =
                                          double.tryParse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: grey2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    isDense: true,
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Заавал оруулна уу'),
                                  ]),
                                ),
                              )
                            : const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget title(String? value) {
    return Text(
      "$value",
      style: const TextStyle(
        fontSize: 14,
        color: grey2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget text(String? value, {required String name}) {
    return value != "-"
        ? SizedBox(
            width: 100,
            child: FormTextField(
              inputType: TextInputType.number,
              fontSize: 12,
              name: name,
              initialValue: value,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: grey2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                isDense: true,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Заавал оруулна уу'),
              ]),
            ),
          )
        : Text(
            "$value",
            style: const TextStyle(
              fontSize: 14,
              color: grey2,
            ),
          );
  }
}
