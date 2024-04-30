// import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/order_module/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/src/order_module/components/shipping_card/shipping_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PullSheetExpensesArguments {
  Order data;
  PullSheetExpensesArguments({
    required this.data,
  });
}

class PullSheetExpenses extends StatefulWidget {
  final Order data;
  static const routeName = '/PullSheetExpenses';
  const PullSheetExpenses({
    super.key,
    required this.data,
  });

  @override
  State<PullSheetExpenses> createState() => _PullSheetExpensesState();
}

class _PullSheetExpensesState extends State<PullSheetExpenses> {
  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await OrderApi().pullSheetConfirm(widget.data.id!);
      loading.loading(false);
      showCustomDialog(
        context,
        "Амжилттай хүлээн авлаа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: orderColor),
        backgroundColor: white,
        surfaceTintColor: white,
        title: const Text(
          'Ачилтын падаан',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ShippingCard(
                    startAnimation: true,
                    index: 1,
                    data: widget.data,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'БАРААНЫ МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        color: coolGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  OrderGoodsInfo(
                    data: widget.data.pullSheetLines,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    child: const Text(
                      'ПАДААНЫ ДҮН',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: "Нэр төрлийн тоо",
                    secondText: "${widget.data.pullSheetLines?.length}",
                    secondTextColor: blue,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: "Хүлээн авах барааны тоо",
                    secondTextColor: blue,
                    secondText:
                        "${widget.data.pullSheetLines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
                  ),
                ],
              ),
            ),
          ),
          if (widget.data.pullSheetStatus != "CONFIRMED")
            Container(
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: CustomButton(
                onClick: () {
                  onSubmit();
                },
                labelText: "Шалгаж хүлээн авлаа",
                labelColor: orderColor,
              ),
            )
        ],
      ),
    );
  }
}
