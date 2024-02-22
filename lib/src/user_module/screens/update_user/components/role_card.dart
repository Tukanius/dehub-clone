import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RoleCard extends StatefulWidget {
  final User data;
  final Function()? onClick;
  const RoleCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  General general = General();

  roleStatus() {
    final res = general.roleStatus!
        .firstWhere((element) => element.code == widget.data.role?.roleStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.data.business?.profileName}, ',
                        ),
                        TextSpan(
                          text: '#${widget.data.business?.refCode}',
                          style: const TextStyle(
                            color: userColor,
                          ),
                        ),
                      ],
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
                    'Роль: ${widget.data.role?.name}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Төлөв:  ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(int.parse(
                                    roleStatus().color.substring(1, 7),
                                    radix: 16) +
                                0xff000000)
                            .withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Text(
                        "${roleStatus().name}",
                        style: TextStyle(
                          color: Color(int.parse(
                                  roleStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    const Text(
                      'Төрөл:  ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: widget.data.business?.type == "SUPPLIER"
                              ? Colors.purple.shade100
                              : Colors.blue.shade200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Text(
                        widget.data.business?.type == "SUPPLIER"
                            ? "Нийлүүлэгч"
                            : "Худалдан авагч",
                        style: TextStyle(
                          color: widget.data.business?.type == "SUPPLIER"
                              ? Colors.purple
                              : Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        color: grey2,
                        fontFamily: "Montserrat",
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Хамрах хүрээ: ',
                        ),
                        TextSpan(
                          text: '${widget.data.branch?.name}',
                          style: const TextStyle(
                            color: userColor,
                          ),
                        ),
                      ],
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
                    'Үүссэн: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.data.createdAt!)}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Үүсгэсэн: ${widget.data.regUser?.lastName?[0]}. ${widget.data.regUser?.firstName}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Эхлэх: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    widget.data.startDate == null
                        ? SvgPicture.asset(
                            'assets/svg/infinity.svg',
                            height: 20,
                            width: 20,
                            colorFilter:
                                const ColorFilter.mode(grey2, BlendMode.srcIn),
                          )
                        : Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data.startDate!),
                            style: const TextStyle(
                              color: grey2,
                              fontSize: 12,
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Дуусах: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    widget.data.startDate == null
                        ? SvgPicture.asset(
                            'assets/svg/infinity.svg',
                            height: 20,
                            width: 20,
                            colorFilter:
                                const ColorFilter.mode(grey2, BlendMode.srcIn),
                          )
                        : Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data.endDate!),
                            style: const TextStyle(
                              color: grey2,
                              fontSize: 12,
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
