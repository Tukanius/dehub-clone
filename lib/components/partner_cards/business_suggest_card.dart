import 'package:dehub/models/business.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BusinessSuggestCard extends StatefulWidget {
  final List<String>? receiverIds;
  final Business? data;
  const BusinessSuggestCard({
    this.receiverIds,
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  _BusinessSuggestCardState createState() => _BusinessSuggestCardState();
}

class _BusinessSuggestCardState extends State<BusinessSuggestCard> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        border: Border.all(width: 0.5, color: Color(0xffF2F2F2)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                    color: networkColor,
                    width: 2,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: networkColor,
                value: isCheck,
                onChanged: (value) {
                  setState(() {
                    isCheck = !isCheck;
                  });
                  if (isCheck == true) {
                    widget.receiverIds?.add(widget.data!.id!);
                  } else {
                    widget.receiverIds!
                        .removeWhere((element) => element == widget.data!.id);
                  }
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.data?.partner?.businessName},',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.data?.refCode}',
                          style: TextStyle(
                            fontSize: 12,
                            color: grey3,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.data?.partnerName},',
                          style: TextStyle(fontSize: 12, color: grey3),
                        ),
                        Text(
                          '${widget.data?.partner?.refCode}',
                          style: TextStyle(
                            fontSize: 12,
                            color: grey3,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'ТТД: ',
                          style: TextStyle(color: grey3, fontSize: 10),
                        ),
                        Text(
                          '${widget.data?.partner?.regNumber}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: grey3,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            widget.data?.staff?.avatar == null
                                ? CircleAvatar(
                                    radius: 12,
                                    backgroundColor: grey,
                                    backgroundImage:
                                        AssetImage('images/avatar.png'),
                                  )
                                : CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                        '${widget.data?.staff?.avatar}'),
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Text(
                                '${widget.data?.staff?.firstName}',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${widget.data?.staff?.email}',
                              style: TextStyle(color: grey3, fontSize: 10),
                            ),
                            Text(
                              '${widget.data?.staff?.phone}',
                              style: TextStyle(color: grey3, fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
