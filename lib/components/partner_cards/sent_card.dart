import 'package:dehub/models/invitation_received.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SentCard extends StatefulWidget {
  final Function()? onClick;
  final Invitation? data;
  final int index;
  final bool startAnimation;
  const SentCard({
    required this.index,
    required this.startAnimation,
    this.data,
    super.key,
    this.onClick,
  });

  @override
  SentCardState createState() => SentCardState();
}

class SentCardState extends State<SentCard> {
  invitationStatus() {
    switch (widget.data?.invitationStatus) {
      case "SENT":
        return 'Илгээсэн';
      case "DRAFT":
        return "Түр төлөв";
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
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : -MediaQuery.of(context).size.width,
            0,
            0),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(width: 0.5, color: const Color(0xffF2F2F2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.data?.receiver?.profileName}',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.data?.receiver?.refCode}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: grey3,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.data?.receiver?.partnerName}',
                          style: const TextStyle(fontSize: 12, color: grey3),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
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
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 12,
                                color: grey3,
                                fontFamily: 'Montserrat'),
                            children: [
                              TextSpan(
                                text:
                                    "${widget.data?.receiver?.staff?.firstName}, ",
                              ),
                              TextSpan(
                                text: widget.data?.receiver?.staff?.phone,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
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
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
