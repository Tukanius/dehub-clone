import 'package:dehub/models/business.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerBusinessCard extends StatefulWidget {
  final Function()? onClick;
  final Business? data;
  const BuyerBusinessCard({
    super.key,
    this.data,
    this.onClick,
  });

  @override
  BuyerBusinessCardState createState() => BuyerBusinessCardState();
}

class BuyerBusinessCardState extends State<BuyerBusinessCard> {
  bool isCheck = false;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data?.logo == null
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'images/avatar.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey,
                                image: DecorationImage(
                                  image: NetworkImage('${widget.data?.logo}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${widget.data?.profileName}, ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: black,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${widget.data?.refCode}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            color: grey3,
                                            decoration:
                                                TextDecoration.underline,
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
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${widget.data?.partnerName},',
                                          style: const TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 12,
                                              color: grey3),
                                        ),
                                        TextSpan(
                                          text:
                                              '${widget.data?.partner?.refCode}',
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: grey3,
                                            decoration:
                                                TextDecoration.underline,
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
                                const Text(
                                  'ТТД: ',
                                  style: TextStyle(color: grey3, fontSize: 10),
                                ),
                                Text(
                                  '${widget.data?.partner?.regNumber}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: grey3,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            widget.data?.staff?.avatar == null
                                                ? const CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor: grey,
                                                    backgroundImage: AssetImage(
                                                        'images/avatar.png'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        '${widget.data?.staff?.avatar}'),
                                                  ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${widget.data?.staff?.firstName}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${widget.data?.staff?.email}',
                                              style: const TextStyle(
                                                  color: grey3, fontSize: 10),
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              '${widget.data?.staff?.phone}',
                                              style: const TextStyle(
                                                  color: grey3, fontSize: 10),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: networkColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SvgPicture.asset('assets/svg/message_sent.svg'),
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
