import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WarehouseCard extends StatefulWidget {
  final Partner data;
  final bool border;
  final Function()? editClick;
  final Function()? deleteClick;
  const WarehouseCard({
    super.key,
    this.editClick,
    this.deleteClick,
    required this.border,
    required this.data,
  });

  @override
  State<WarehouseCard> createState() => _WarehouseCardState();
}

class _WarehouseCardState extends State<WarehouseCard> {
  General general = General();

  district() {
    if (widget.data.district != null) {
      final res = general.zipCodes!
          .firstWhere((element) => element.code == widget.data.district);
      return res.name;
    } else {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return GestureDetector(
      onTap: widget.editClick,
      child: Container(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 9),
        decoration: BoxDecoration(
          color: white,
          border: Border(
            bottom: BorderSide(
              color: widget.border ? lightGrey : transparent,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    '${widget.data.name}',
                    style: const TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    '#${widget.data.refCode}',
                    style: const TextStyle(
                      color: partnerColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
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
                    'Бүртгэсэн: ${DateFormat('yyyy-MM-dd').format(widget.data.createdAt!)}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: widget.data.warehouseStatus == "ACTIVE"
                            ? green
                            : grey2,
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Text(
                    widget.data.warehouseStatus == "ACTIVE"
                        ? 'Идэвхтэй'
                        : "Идэвхгүй",
                    style: TextStyle(
                      color: widget.data.warehouseStatus == "ACTIVE"
                          ? green
                          : grey2,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    "Дүүрэг: ${district()}",
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Үндсэн: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: widget.data.isDefault == true
                              ? partnerColor
                              : grey3.withOpacity(.3),
                        ),
                        child: Text(
                          widget.data.isDefault == true ? "Тийм" : 'Үгүй',
                          style: const TextStyle(
                            color: white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: grey,
                              backgroundImage: widget
                                          .data.warehouseUser?.avatar !=
                                      null
                                  ? NetworkImage(
                                      "${widget.data.warehouseUser?.avatar}")
                                  : null,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.warehouseUser?.lastName != null
                                      ? '${widget.data.warehouseUser?.lastName?[0]}. ${widget.data.warehouseUser?.firstName}'
                                      : '${widget.data.warehouseUser?.firstName}',
                                ),
                                Text(
                                  "${widget.data.warehouseUser?.phone}",
                                  style: const TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      if (widget.deleteClick != null)
                        GestureDetector(
                          onTap: widget.deleteClick,
                          child: Container(
                            height: 35,
                            width: 35,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: red.withOpacity(0.2),
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/trash_can.svg',
                              colorFilter:
                                  const ColorFilter.mode(red, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: partnerColor.withOpacity(0.2),
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/edit_rounded.svg',
                          colorFilter: const ColorFilter.mode(
                              partnerColor, BlendMode.srcIn),
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
}
