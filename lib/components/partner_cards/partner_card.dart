import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnerCard extends StatefulWidget {
  final Function()? onClick;
  final BusinessNetwork data;
  final int index;
  final bool? type;
  final bool startAnimation;
  const PartnerCard({
    required this.index,
    required this.startAnimation,
    required this.data,
    this.type,
    super.key,
    this.onClick,
  });

  @override
  PartnerCardState createState() => PartnerCardState();
}

class PartnerCardState extends State<PartnerCard> {
  General general = General();

  status() {
    final status = general.businessStatus!
        .firstWhere((element) => element.code == widget.data.businessStatus)
        .name;
    return status;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(width: 0.5, color: const Color(0xffF2F2F2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data.logo == null
                          ? const CircleAvatar(
                              radius: 20,
                              backgroundColor: grey,
                              backgroundImage: AssetImage('images/avatar.png'),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundColor: grey,
                              backgroundImage:
                                  NetworkImage('${widget.data.logo}')),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data.profileName}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              '${widget.data.partnerName}',
                              style:
                                  const TextStyle(fontSize: 12, color: grey3),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            widget.data.paymentTerm?.description != null
                                ? Text(
                                    '${widget.data.paymentTerm?.description}',
                                    style: const TextStyle(
                                        fontSize: 12, color: grey3),
                                  )
                                : const Text(
                                    '-',
                                    style:
                                        TextStyle(fontSize: 12, color: grey3),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data.refCode}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: grey3,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Text(
                              'ТТД: ',
                              style: TextStyle(color: grey3, fontSize: 10),
                            ),
                            Text(
                              '${widget.data.regNumber}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: grey3),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        if (widget.type == true || widget.type == null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffEDF4E9),
                            ),
                            child: Text(
                              '${status()}',
                              style: const TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
