import 'package:dehub/api/order_api.dart';
import 'package:dehub/src/order_module/screens/dropship_create/dropship_card/dropship_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropshipCreateArguments {
  String id;
  List<Order> lines;
  DropshipCreateArguments({
    required this.id,
    required this.lines,
  });
}

class DropshipCreate extends StatefulWidget {
  static const routeName = '/DropshipCreate';
  final String id;
  final List<Order> lines;
  const DropshipCreate({
    super.key,
    required this.id,
    required this.lines,
  });

  @override
  State<DropshipCreate> createState() => _DrosShipCreateState();
}

class _DrosShipCreateState extends State<DropshipCreate> {
  dropshipCreate() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      List<Order> lines = [];
      loading.loading(true);
      for (var data in widget.lines) {
        lines.add(
          Order(
            variantId: data.variantId,
            buyerBusinessId: data.buyerBusiness?.id,
            supplierBusinessId: data.supplierBusiness?.id,
          ),
        );
      }
      await OrderApi().dropshipCreate(
        Order(
          orderId: widget.id,
          lines: lines,
        ),
      );
      loading.loading(false);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showCustomDialog(context, "Амжилттай Dropship захиаллаа", true);
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: orderColor),
        surfaceTintColor: white,
        backgroundColor: white,
        title: const Text(
          'Захиалгаас салгах',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: widget.lines
                  .map(
                    (e) => DropshipCard(data: e),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 4,
                  child: CustomButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    labelText: 'Болих',
                    borderColor: orderColor,
                    labelColor: white,
                    textColor: orderColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 6,
                  child: CustomButton(
                    onClick: dropshipCreate,
                    labelText: 'Захиалга салгах',
                    labelColor: orderColor,
                    textColor: white,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
