import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderBranchCard extends StatefulWidget {
  final Order? data;
  final bool? isCheck;
  final Function()? onClick;
  const OrderBranchCard({
    this.isCheck,
    this.onClick,
    super.key,
    this.data,
  });

  @override
  State<OrderBranchCard> createState() => _OrderBranchCardState();
}

class _OrderBranchCardState extends State<OrderBranchCard> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data?.logo != null && widget.data?.logo != ''
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: grey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage('${widget.data?.logo}'),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: grey,
                            shape: BoxShape.circle,
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
                          '${widget.data?.branchAddress}',
                          style: const TextStyle(color: buttonColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.data?.name}',
                          style: const TextStyle(
                            color: Color(0xff657786),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/svg/map.svg',
              colorFilter: const ColorFilter.mode(orderColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
