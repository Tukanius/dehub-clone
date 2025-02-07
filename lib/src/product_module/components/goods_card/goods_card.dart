import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/product_module/screens/new_product/new_product.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GoodsCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? priceClick;
  final Function()? warehouseClick;
  final InventoryGoods data;
  final bool startAnimation;
  final int index;
  final Function()? inActiveClick;
  final ListenController listenController;
  const GoodsCard({
    super.key,
    required this.listenController,
    this.warehouseClick,
    this.priceClick,
    this.inActiveClick,
    required this.index,
    required this.startAnimation,
    required this.data,
    this.onClick,
  });

  @override
  State<GoodsCard> createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  User user = User();

  onSubmit(String id, String status) async {
    await InventoryApi().statusChange(
      InventoryGoods(
        status: status,
        inactiveTypeId: '',
      ),
      id,
    );
    widget.listenController.changeVariable('active');
    showCustomDialog(
      context,
      'Амжилттай',
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
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
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.data.image != null
                        ? FadeInImage(
                            placeholder: const NetworkImage(
                                'https://repository-images.githubusercontent.com/193885464/14ad0b00-9819-11e9-995e-66a1e3651912'),
                            image: NetworkImage('${widget.data.image}'),
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('images/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.data.nameApp}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: productColor,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.data.refCode}',
                              style: const TextStyle(color: productColor),
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.data.variantStatus == "ACTIVE"
                    ? Permission().check(user, "ERP_GDS_PRICE_SET")
                        ? GestureDetector(
                            onTap: widget.inActiveClick,
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
                                  colorFilter: const ColorFilter.mode(
                                      productColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                    : widget.data.variantStatus == "DRAFT"
                        ? GestureDetector(
                            onTap: () {
                              if (Permission()
                                  .check(user, "ERP_GDS", boolean: 'isEdit')) {
                                Navigator.of(context).pushNamed(
                                  NewProduct.routeName,
                                  arguments: NewProductArguments(
                                    initialIndex: 1,
                                    data: widget.data,
                                  ),
                                );
                              } else {
                                showCustomDialog(context,
                                    "Хандах эрх хүрэлцэхгүй байна", false);
                              }
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
                                  'assets/svg/edit_rounded.svg',
                                  colorFilter: ColorFilter.mode(
                                    widget.data.isWarehouseSet == false
                                        ? productColor
                                        : productColor.withOpacity(0.4),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              if (Permission().check(user, "ERP_GDS_WRH_SET"))
                                GestureDetector(
                                  onTap: widget.warehouseClick,
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
                              if (Permission().check(user, "ERP_GDS_PRICE_SET"))
                                GestureDetector(
                                  onTap: widget.priceClick,
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
                              if (Permission().check(user, "ERP_GDS_STATUS"))
                                GestureDetector(
                                  onTap: widget.data.isPriceSet == true &&
                                          widget.data.isWarehouseSet == true
                                      ? () {
                                          Navigator.of(context).pushNamed(
                                            PinCheckScreen.routeName,
                                            arguments: PinCheckScreenArguments(
                                              onSubmit: () {
                                                onSubmit(widget.data.variantId!,
                                                    "ACTIVE");
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
                                                    widget.data
                                                            .isWarehouseSet ==
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
