import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderBranchCard extends StatefulWidget {
  final Order? data;
  final isCheck;
  final Function()? onClick;
  const OrderBranchCard({
    this.isCheck,
    this.onClick,
    Key? key,
    this.data,
  }) : super(key: key);

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
                  // Transform.scale(
                  //   scale: 1.4,
                  //   child: Checkbox(
                  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     side: MaterialStateBorderSide.resolveWith(
                  //       (Set<MaterialState> states) {
                  //         if (states.contains(MaterialState.selected)) {
                  //           return const BorderSide(width: 0, color: transparent);
                  //         }
                  //         return const BorderSide(width: 1, color: grey);
                  //       },
                  //     ),
                  //     shape: CircleBorder(),
                  //     activeColor: orderColor,
                  //     value: isCheck,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         isCheck = !isCheck;
                  //       });
                  //     },
                  //   ),
                  // ),
                  widget.data?.logo != null || widget.data?.logo != ''
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
                          decoration: BoxDecoration(
                            color: grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data?.branchAddress}',
                          style: TextStyle(color: buttonColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.data?.name}',
                          style: TextStyle(
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
              color: orderColor,
            ),
          ],
        ),
      ),
    );
  }
}
