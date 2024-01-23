import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/distributor_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/importer_country_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/manufacturer_country.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/manufacturer_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/brand_sheet.dart';
import 'package:dehub/src/product_module/screens/new_product/sheet/supplier_sheet.dart';

class BrandForm extends StatefulWidget {
  final BuildContext context;
  const BrandForm({
    super.key,
    required this.context,
  });

  @override
  State<BrandForm> createState() => _BrandFormState();
}

class _BrandFormState extends State<BrandForm> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);

    return Container(
      color: white,
      child: Column(
        children: [
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Брэндийн нэр",
            secondText: source.product.brandName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const BrandSheet();
                },
              );
            },
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Нийлүүлэгч",
            secondText: source.product.supplierName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const SupplierSheet();
                },
              );
            },
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Үйлдвэрлэгч",
            secondText: source.product.manufacturerName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const ManufacturerSheet();
                },
              );
            },
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Үйлдвэрлэгч улс",
            secondText: source.product.manufacturerCountryName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const ManufacturerCountrySheet();
                },
              );
            },
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Импортлогч улс",
            secondText: source.product.importerCountryName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const ImporterCountrySheet();
                },
              );
            },
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            labelText: "Дистрибютер",
            secondText: source.product.distributorName ?? 'Сонгох',
            secondTextColor: productColor,
            arrowColor: productColor,
            onClick: () {
              FocusScope.of(widget.context).unfocus();
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const DistributorSheet();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
