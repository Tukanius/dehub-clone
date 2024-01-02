import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/product_module/screens/set_price/set_price.dart';
import 'package:dehub/src/product_module/screens/set_warehouse/set_warehouse.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoodsCard extends StatefulWidget {
  final Function()? onClick;
  final InventoryGoods data;
  final bool startAnimation;
  final int index;
  const GoodsCard({
    Key? key,
    required this.index,
    required this.startAnimation,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<GoodsCard> createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  onSubmit(String id, String status) async {
    await InventoryApi().statusChange(
      InventoryGoods(
        status: status,
        inactiveTypeId: widget.data.inactiveTypeId ?? 'null',
      ),
      id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 48,
                  width: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage('${widget.data.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.data.nameMon}',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: productColor,
                            size: 18,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.data.refCode}',
                              style: TextStyle(color: productColor),
                            ),
                          ),
                          Text('${widget.data.skuCode}')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${widget.data.category?.name}',
                style: TextStyle(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.data.variantStatus == "ACTIVE"
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PinCheckScreen.routeName,
                            arguments: PinCheckScreenArguments(
                              onSubmit: () {
                                onSubmit(widget.data.id!, "INACTIVE");
                              },
                              color: productColor,
                              labelText: "Бараа идэвхижүүлэх",
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: productColor.withOpacity(0.1),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svg/stop-sign.svg',
                              colorFilter: ColorFilter.mode(
                                  productColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      )
                    : widget.data.variantStatus == "DRAFT"
                        ? GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: productColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/svg/edit.svg',
                                  colorFilter: ColorFilter.mode(
                                      widget.data.isWarehouseSet == false
                                          ? productColor
                                          : productColor.withOpacity(0.4),
                                      BlendMode.srcIn),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: widget.data.isWarehouseSet == false
                                    ? () {
                                        Navigator.of(context).pushNamed(
                                          SetWarehouse.routeName,
                                          arguments: SetWarehouseArguments(
                                              data: widget.data),
                                        );
                                      }
                                    : () {},
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: productColor.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/svg/in-home.svg',
                                      colorFilter: ColorFilter.mode(
                                          widget.data.isWarehouseSet == false
                                              ? productColor
                                              : productColor.withOpacity(0.4),
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.data.isPriceSet == false
                                    ? () {
                                        Navigator.of(context).pushNamed(
                                          SetPrice.routeName,
                                          arguments: SetPriceArguments(
                                            data: widget.data,
                                          ),
                                        );
                                      }
                                    : () {},
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: productColor.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/svg/double-pin.svg',
                                      colorFilter: ColorFilter.mode(
                                          widget.data.isPriceSet == false
                                              ? productColor
                                              : productColor.withOpacity(0.4),
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.data.isPriceSet == true &&
                                        widget.data.isWarehouseSet == true
                                    ? () {
                                        Navigator.of(context).pushNamed(
                                          PinCheckScreen.routeName,
                                          arguments: PinCheckScreenArguments(
                                            onSubmit: () {
                                              onSubmit(
                                                  widget.data.id!, "ACTIVE");
                                            },
                                            color: productColor,
                                            labelText: "Бараа идэвхижүүлэх",
                                          ),
                                        );
                                      }
                                    : () {},
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: productColor.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/svg/double-check.svg',
                                      colorFilter: ColorFilter.mode(
                                          widget.data.isPriceSet == true &&
                                                  widget.data.isWarehouseSet ==
                                                      true
                                              ? productColor
                                              : productColor.withOpacity(0.4),
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
