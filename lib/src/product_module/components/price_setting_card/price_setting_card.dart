import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PriceSettingCard extends StatefulWidget {
  final InventoryGoods data;
  final List<InventoryGoods>? list;
  final Function()? onChange;
  final Function()? onClick;
  const PriceSettingCard({
    super.key,
    this.onClick,
    this.onChange,
    this.list,
    required this.data,
  });

  @override
  State<PriceSettingCard> createState() => _PriceSettingCardState();
}

class _PriceSettingCardState extends State<PriceSettingCard> {
  int? index;
  User user = User();

  @override
  Widget build(BuildContext context) {
    index = widget.list?.indexWhere((element) => element.id == widget.data.id);
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data.logo != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(widget.data.logo.toString()),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/avatar.png'),
                      ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data.profileName}',
                        style: const TextStyle(
                          color: productColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${widget.data.refCode}, ${widget.data.partner?.refCode}',
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.list != null && widget.onChange != null)
                  Checkbox(
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: productColor,
                        width: 2,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: productColor,
                    value: index! > -1,
                    onChanged: (value) {
                      widget.onChange!();
                    },
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
                    'ТТД: ${widget.data.regNumber}',
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
                        'Үнэ тохиргоо:',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSwitch(
                        isDefault: widget.data.isPriceSet,
                        color: productColor,
                      ),
                    ],
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
                    widget.data.priceStartDate != null
                        ? 'Эхлэх огноо: ${DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(widget.data.priceStartDate!),
                          )}'
                        : 'Эхлэх огноо: -',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.data.priceStartDate != null
                        ? 'Дуусах огноо: ${DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(widget.data.priceEndDate!),
                          )}'
                        : 'Дуусах огноо: -',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const Divider(
              color: lightGrey,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Менежер:',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Санхүү:',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
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
                  child: widget.data.coBusinessStaff != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: grey,
                              backgroundImage:
                                  widget.data.coBusinessStaff?.avatar != null
                                      ? NetworkImage(
                                          "${widget.data.coBusinessStaff?.avatar}",
                                        )
                                      : null,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.data.coBusinessStaff?.firstName}',
                                    style: const TextStyle(
                                      color: grey2,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${widget.data.coBusinessStaff?.email}',
                                    style: const TextStyle(
                                      color: grey2,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          '-',
                          style: TextStyle(color: grey2, fontSize: 10),
                        ),
                ),
                Expanded(
                  child: widget.data.coBusinessFinStaffs!.isNotEmpty
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: grey,
                              backgroundImage: widget.data.coBusinessFinStaffs
                                          ?.first.avatar !=
                                      null
                                  ? NetworkImage(
                                      "${widget.data.coBusinessFinStaffs?.first.avatar}",
                                    )
                                  : null,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data.coBusinessFinStaffs?.first
                                            .firstName ??
                                        '-',
                                    style: const TextStyle(
                                      color: grey2,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.data.coBusinessFinStaffs?.first
                                            .email ??
                                        '-',
                                    style: const TextStyle(
                                      color: grey2,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          '-',
                          style: TextStyle(color: grey2, fontSize: 10),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
