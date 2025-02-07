import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatefulWidget {
  final Order? data;
  final bool? isOwnChat;
  const ChatCard({
    this.isOwnChat,
    super.key,
    this.data,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  bool startAnimation = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(
          !startAnimation ? MediaQuery.of(context).size.width : 0, 0, 0),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: widget.isOwnChat == false
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: widget.isOwnChat == true
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isOwnChat == false
                  ? widget.data?.user?.avatar == null
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          height: 36,
                          width: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey,
                            image: DecorationImage(
                              image: AssetImage('images/avatar.png'),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(right: 5),
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  NetworkImage('${widget.data?.user?.avatar}'),
                            ),
                          ),
                        )
                  : const SizedBox(),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5),
                decoration: BoxDecoration(
                  color: chatGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomRight:
                        Radius.circular(widget.isOwnChat == true ? 0 : 20),
                    bottomLeft:
                        Radius.circular(widget.isOwnChat == true ? 20 : 0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 13,
                ),
                child: Text(
                  '${widget.data?.text}',
                  textAlign: widget.isOwnChat == true
                      ? TextAlign.end
                      : TextAlign.start,
                ),
              ),
              widget.isOwnChat == true
                  ? widget.data?.user?.avatar == null
                      ? Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 36,
                          width: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey,
                            image: DecorationImage(
                              image: AssetImage('images/avatar.png'),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: grey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${widget.data?.user?.avatar}',
                                  scale: 1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: widget.isOwnChat == false ? 40 : 0,
                right: widget.isOwnChat == true ? 40 : 0),
            child: Text(
              DateFormat('yyyy-MM-dd HH:mm').format(widget.data!.createdAt!),
              style: const TextStyle(
                  color: saaral, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
