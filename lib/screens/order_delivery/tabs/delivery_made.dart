import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class DeliveryMade extends StatefulWidget {
  const DeliveryMade({super.key});

  @override
  State<DeliveryMade> createState() => _DeliveryMadeState();
}

class _DeliveryMadeState extends State<DeliveryMade> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result pullSheet = Result(count: 0, rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(pullSheetStatus: "CONFIRMED");
    var res = await OrderApi()
        .pullSheet(ResultArguments(filter: filter, offset: offset));
    setState(() {
      pullSheet = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(color: orderColor),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SearchButton(
                  color: orderColor,
                  textColor: orderColor,
                ),
                SizedBox(
                  height: 5,
                ),
                pullSheet.rows?.length != 0
                    ? Column(
                        children: pullSheet.rows!
                            .map(
                              (e) => ShippingCard(
                                data: e,
                              ),
                            )
                            .toList(),
                      )
                    : NotFound(
                        module: "ORDER",
                        labelText: "Хоосон байна",
                      ),
              ],
            ),
          );
  }
}
