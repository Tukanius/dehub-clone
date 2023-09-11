import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final bool? isOwnChat;
  final String? chat;
  const ChatCard({
    Key? key,
    this.chat,
    this.isOwnChat,
  }) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
          left: widget.isOwnChat == true ? 150 : 0,
          right: widget.isOwnChat == false ? 150 : 0),
      child: Column(
        crossAxisAlignment: widget.isOwnChat == false
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isOwnChat == false
                  ? Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey,
                      ),
                    )
                  : SizedBox(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: chatGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
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
                    '${widget.chat}',
                    textAlign: widget.isOwnChat == true
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                ),
              ),
              widget.isOwnChat == true
                  ? Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: widget.isOwnChat == false ? 40 : 0,
                right: widget.isOwnChat == true ? 40 : 0),
            child: Text(
              '2021-12-24',
              style: TextStyle(
                  color: saaral, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
