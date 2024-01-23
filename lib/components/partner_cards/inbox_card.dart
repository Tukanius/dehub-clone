import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InboxCard extends StatefulWidget {
  final Function()? onClick;
  final Invitation? data;
  const InboxCard({
    this.data,
    this.onClick,
    super.key,
  });

  @override
  InboxCardState createState() => InboxCardState();
}

class InboxCardState extends State<InboxCard> {
  invitationStatus() {
    switch (widget.data?.invitationStatus) {
      case "DRAFT":
        return "Түр төлөв";
      case "SENT":
        return "Илгээгдсэн";
      case "ACCEPTED":
        return "Зөвшөөрсөн";
      case "REJECTED":
        return "Цуцлагдсан";
      default:
    }
  }

  invitationStatusColor() {
    switch (widget.data?.invitationStatus) {
      case "SENT":
        return orange;
      case "DRAFT":
        return grey;
      case "ACCEPTED":
        return green;
      case "REJECTED":
        return red;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.data?.type == "NETWORK"
                              ? [
                                  Text(
                                    '${widget.data?.sender?.profileName}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data?.sender?.partnerName}',
                                    style: const TextStyle(
                                        fontSize: 12, color: grey3),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data?.sender?.staff?.firstName}, ${widget.data?.sender?.staff?.phone}',
                                    style: const TextStyle(
                                        fontSize: 12, color: grey3),
                                  ),
                                ]
                              : [
                                  Text(
                                    '${widget.data?.bankName}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data?.senderUserName}',
                                    style: const TextStyle(
                                        fontSize: 12, color: grey3),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.data?.toMessage}',
                                    style: const TextStyle(
                                        fontSize: 12, color: grey3),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.data?.sender?.refCode}',
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
                              'Урилга №: ',
                              style: TextStyle(color: grey3, fontSize: 10),
                            ),
                            Text(
                              '${widget.data?.refCode}',
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            border: Border.all(color: invitationStatusColor()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            invitationStatus(),
                            style: TextStyle(
                              color: invitationStatusColor(),
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
