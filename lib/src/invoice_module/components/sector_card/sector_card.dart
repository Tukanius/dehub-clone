import 'package:dehub/models/invoice.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SectorCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const SectorCard({
    required this.data,
    super.key,
    this.onClick,
  });

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
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/avatar.png'),
                      ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.data.branch?.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: dark,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${widget.data.branch?.business?.profileName}  ТТД: ${widget.data.branch?.business?.regNumber}',
                          style: const TextStyle(
                            color: dark,
                          ),
                        ),
                      ),
                      Text(
                        'Утас: ${widget.data.branch?.business?.partnerPhone}',
                        style: const TextStyle(
                          color: dark,
                        ),
                      ),
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
