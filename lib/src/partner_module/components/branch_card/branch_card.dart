import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BranchCard extends StatefulWidget {
  final Partner data;
  final int index;
  final Function()? onClick;
  final bool startAnimation;
  const BranchCard({
    super.key,
    required this.startAnimation,
    required this.index,
    this.onClick,
    required this.data,
  });

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  General general = General();

  branchType() {
    final res = general.branchTypes!
        .firstWhere((element) => element.code == widget.data.type);
    return res;
  }

  branchStatus() {
    final res = general.branchStatus!
        .firstWhere((element) => element.code == widget.data.branchStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedOpacity(
        opacity: widget.startAnimation ? 1 : 0,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300 + (widget.index * 200)),
          transform: Matrix4.translationValues(
              widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
              0,
              0),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: white,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data.logo != null
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage('${widget.data.logo}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(5),
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
                            color: partnerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.refCode}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: grey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: partnerColor.withOpacity(0.2),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/edit_rounded.svg',
                      colorFilter:
                          const ColorFilter.mode(partnerColor, BlendMode.srcIn),
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
                      "Бүртгэсэн: ${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!)}",
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      '${branchStatus().name}',
                      style: const TextStyle(
                        color: Colors.blue,
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
                    child: Text(
                      "Ажилтан: ${widget.data.regUser?.lastName?[0]}. ${widget.data.regUser?.firstName}, ${widget.data.regUser?.phone}",
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Төрөл: ${branchType().name}",
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
                children: [
                  const Text(
                    'Үндсэн: ',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.data.isDefault == true
                          ? partnerColor
                          : grey2.withOpacity(0.3),
                    ),
                    child: Text(
                      widget.data.isDefault == true ? 'Тийм' : "Үгүй",
                      style: const TextStyle(
                        color: white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
