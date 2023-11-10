import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BranchCard extends StatefulWidget {
  final Function()? onClick;
  final BusinessNetwork? data;
  const BranchCard({
    this.data,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 2),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data?.logo != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: grey,
                        backgroundImage: NetworkImage('${widget.data?.logo}'),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/empty-avatar.webp'),
                      ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              '${widget.data?.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: dark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Дэлгэр сайхан ХХК  ТТД: 315466',
                            style: TextStyle(
                              color: dark,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        '+976 - 9999 9999',
                        style: TextStyle(
                          color: dark,
                        ),
                      ),
                    )
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
