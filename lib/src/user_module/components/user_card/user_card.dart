import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  final User data;
  final Function()? onClick;
  final Function()? onPress;
  const UserCard({
    super.key,
    this.onPress,
    this.onClick,
    required this.data,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  General general = General();

  userStatus() {
    final res = general.userStatus!
        .firstWhere((element) => element.code == widget.data.userStatus);
    return res;
  }

  registerStatus() {
    final res = general.userRegisterStatus!
        .firstWhere((element) => element.code == widget.data.registerStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(5),
                    image: widget.data.avatar != null
                        ? DecorationImage(
                            image: NetworkImage(
                              '${widget.data.avatar}',
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
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
                        widget.data.lastName != null
                            ? '${widget.data.lastName?[0]}. ${widget.data.firstName}, ${widget.data.registerNo}'
                            : widget.data.registerNo != null
                                ? '${widget.data.firstName}, ${widget.data.registerNo}'
                                : '${widget.data.firstName}',
                        style: const TextStyle(
                          color: userColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.data.username ?? ''}${widget.data.username != null ? ', ' : ''}${widget.data.phone}",
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onClick != null)
                  Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: userColor.withOpacity(0.2),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/edit_rounded.svg',
                      colorFilter:
                          const ColorFilter.mode(userColor, BlendMode.srcIn),
                    ),
                  ),
                if (widget.data.registerStatus != "SUCCESS" &&
                    widget.onPress != null)
                  GestureDetector(
                    onTap: widget.onPress,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 35,
                      width: 35,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: userColor.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/message_sent.svg',
                        colorFilter:
                            const ColorFilter.mode(userColor, BlendMode.srcIn),
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
                    'Ургын овог: ${widget.data.familyName ?? "-"}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'И-мэйл: ${widget.data.email ?? '-'}',
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
                      'Хэрэглэгч: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.data.userStatus == "ACTIVE"
                            ? green.withOpacity(0.1)
                            : grey2.withOpacity(0.1),
                      ),
                      child: Text(
                        "${userStatus().name}",
                        style: TextStyle(
                          color: widget.data.userStatus == "ACTIVE"
                              ? green
                              : grey2,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Бүртгэл: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(int.parse(
                                  registerStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000),
                        ),
                      ),
                      child: Text(
                        "${registerStatus().name}",
                        style: TextStyle(
                          color: Color(int.parse(
                                  registerStatus().color.substring(1, 7),
                                  radix: 16) +
                              0xff000000),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Харьяалал: ${widget.data.departmentUnit?.name ?? '-'} / ${widget.data.departmentSubUnit?.name ?? '-'}',
              style: const TextStyle(
                color: grey2,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Албан тушаал: ${widget.data.employeeUnit?.name ?? '-'}',
                style: const TextStyle(
                  color: grey2,
                  fontSize: 12,
                ),
              ),
            ),
            // if (widget.data.userRoles!.isNotEmpty)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const SizedBox(
            //         height: 5,
            //       ),
            //       const Text(
            //         'Хэрэглэгчийн роль:',
            //         style: TextStyle(
            //           color: depBrown,
            //           fontSize: 12,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: ListView(
            //           scrollDirection: Axis.horizontal,
            //           children: widget.data.userRoles!
            //               .map(
            //                 (e) => Container(
            //                   padding: const EdgeInsets.symmetric(vertical: 10),
            //                   child: Container(
            //                     height: 20,
            //                     margin: const EdgeInsets.only(right: 7),
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 10),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(10),
            //                       border: Border.all(color: userColor),
            //                     ),
            //                     child: Text(
            //                       "${e.name}",
            //                       style: const TextStyle(
            //                         color: userColor,
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               )
            //               .toList(),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
