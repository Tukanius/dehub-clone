import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BankCard extends StatefulWidget {
  final User data;
  final Function()? onClick;
  const BankCard({
    super.key,
    required this.data,
    this.onClick,
  });

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  General general = General();

  financeRoleStatus() {
    final res = general.financeRoleStatus!.firstWhere((element) =>
        element.code == widget.data.financeRole?.financeRoleStatus);
    return res.name;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage('${widget.data.icon}'),
                      fit: BoxFit.cover,
                    ),
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
                        '${widget.data.name}',
                        style: const TextStyle(
                          color: userColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.data.businessName}, ${widget.data.regNumber}',
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.data.financeRole == null
                        ? userColor.withOpacity(0.1)
                        : lightGrey,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/cloud_lock.svg',
                    colorFilter: ColorFilter.mode(
                        widget.data.financeRole == null ? userColor : grey,
                        BlendMode.srcIn),
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
                      'Банканд нээлттэй: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    CustomSwitch(
                      isDefault: widget.data.financeRole != null,
                      color: userColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Статус: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    if (widget.data.financeRole != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Text(
                          '${financeRoleStatus()}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      )
                    else
                      const Text(
                        '-',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (widget.data.financeRole?.user != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const Divider(
                      color: grey2,
                      thickness: 0.5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: grey,
                          backgroundImage:
                              widget.data.financeRole?.user?.avatar != null
                                  ? NetworkImage(
                                      '${widget.data.financeRole?.user?.avatar}',
                                    )
                                  : null,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.financeRole?.user?.lastName?[0]}. ${widget.data.financeRole?.user?.firstName}',
                              ),
                              Text(
                                "${widget.data.financeRole?.user?.registerNo}",
                                style: const TextStyle(
                                  color: grey2,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Username: ${widget.data.financeRole?.username ?? '-'}',
                          style: const TextStyle(
                            color: grey2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.data.financeRole?.user?.email}, ${widget.data.financeRole?.user?.phone}',
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
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
