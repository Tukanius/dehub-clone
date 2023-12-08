import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SectorCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const SectorCard({
    required this.data,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<SectorCard> createState() => _SectorCardState();
}

class _SectorCardState extends State<SectorCard> {
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
                widget.data.branch?.logo != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage('${widget.data.branch?.logo}'),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/avatar.png'),
                      ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${widget.data.branch?.name}',
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${widget.data.branch?.business?.profileName}  ТТД: ${widget.data.branch?.business?.regNumber}',
                          style: TextStyle(
                            color: dark,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Утас: ${widget.data.branch?.business?.partnerPhone}',
                          style: TextStyle(
                            color: dark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
