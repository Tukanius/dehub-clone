import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/sheets/buyer_sheet.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/sheets/partner_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import '../sheets/supplier_sheet.dart';

class VariantSuppliersSheet extends StatefulWidget {
  final InventoryGoods? data;
  const VariantSuppliersSheet({
    super.key,
    this.data,
  });

  @override
  State<VariantSuppliersSheet> createState() => _VariantSuppliersSheetState();
}

class _VariantSuppliersSheetState extends State<VariantSuppliersSheet>
    with AfterLayoutMixin {
  General general = General();
  bool isDefault = false;
  bool backorderable = false;
  bool isDropShipping = false;
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);
    if (widget.data != null) {
      source.product.buyerBusiness?.id = widget.data?.buyerBusinessId;
      source.product.supplierBusiness?.id = widget.data?.supplierBusinessId;
      source.product.merchStaffId = widget.data?.merchStaffId;
      source.product.supplierBusiness?.profileName = widget.data?.supplierName;
      source.product.partnerBusiness?.businessName = widget.data?.partnerName;
    } else {
      source.clearBusiness();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: productColor),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(3),
                    color: transparent,
                    child: SvgPicture.asset(
                      'assets/svg/square-x.svg',
                      colorFilter: const ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Татан авалтын мэдээлэл',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.data == null) {
                      source.variantSupplier(
                        InventoryGoods(
                          isDefault: isDefault,
                          isDropshipping: isDropShipping,
                          buyerBusinessId: source.product.buyerBusiness?.id,
                          supplierBusinessId:
                              source.product.supplierBusiness?.id,
                          merchStaffId:
                              source.product.supplierBusiness?.merchStaff?.id,
                          supplierName:
                              source.product.supplierBusiness?.profileName,
                          partnerName:
                              source.product.partnerBusiness?.businessName,
                          backorderable: backorderable,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        widget.data?.isDefault = isDefault;
                        widget.data?.isDropshipping = isDropShipping;
                        widget.data?.backorderable = backorderable;
                        widget.data?.buyerBusinessId =
                            source.product.buyerBusiness?.id;
                        widget.data?.supplierBusinessId =
                            source.product.supplierBusiness?.id;
                        widget.data?.merchStaffId =
                            source.product.supplierBusiness?.merchStaff?.id;
                        widget.data?.supplierName =
                            source.product.supplierBusiness?.profileName;
                        widget.data?.partnerName =
                            source.product.partnerBusiness?.businessName;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: productColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Болсон',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading == true
                ? const SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Тохиргоо хийх',
                            style: TextStyle(color: grey2),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 3, top: 3),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Default эсэх'),
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: isDefault,
                                  activeColor: productColor,
                                  onChanged: (value) {
                                    setState(() {
                                      isDefault = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          labelText: "Манай Buyer бизнес",
                          secondText:
                              source.product.buyerBusiness?.profileName ?? 'Сонгох',
                          secondTextColor: productColor,
                          onClick: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              builder: (context) => const BuyerSheet(),
                            );
                          },
                          arrowColor: productColor,
                          color: white,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          labelText: "Нийлүүлэгч партнер",
                          secondText:
                              source.product.partnerBusiness?.businessName ?? 'Сонгох',
                          secondTextColor: productColor,
                          onClick: source.product.buyerBusiness?.id == null
                              ? () {}
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => PartnerSheet(
                                      id: source.product.buyerBusiness!.id!,
                                    ),
                                  );
                                },
                          arrowColor: productColor,
                          color: white,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          labelText: "Нийлүүлэгч бизнес",
                          secondText:
                              source.product.supplierBusiness?.profileName ?? 'Сонгох',
                          secondTextColor: productColor,
                          onClick: source.product.partnerBusiness?.id == null
                              ? () {}
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => SupplierSheet(
                                      buyerBusinessId:
                                          source.product.buyerBusiness!.id!,
                                      partnerId:
                                          source.product.partnerBusiness!.id!,
                                    ),
                                  );
                                },
                          arrowColor: productColor,
                          color: white,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          labelText: "Хариуцсан ажилтан",
                          secondText: source.product.supplierBusiness?.merchStaff
                                  ?.firstName ?? 'Авто гарах',
                          secondTextColor: productColor,
                          color: white,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Борлуулах үнийн мэдээлэл',
                            style: TextStyle(color: grey2),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 3, top: 3),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Backorder хийх эсэх'),
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: backorderable,
                                  activeColor: productColor,
                                  onChanged: (value) {
                                    setState(() {
                                      backorderable = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 3, top: 3),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Dropship хийх эсэх'),
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: isDropShipping,
                                  activeColor: productColor,
                                  onChanged: (value) {
                                    setState(() {
                                      isDropShipping = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
