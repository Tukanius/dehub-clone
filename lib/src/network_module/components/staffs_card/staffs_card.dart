import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class StaffsCard extends StatefulWidget {
  final BusinessNetwork data;
  const StaffsCard({
    super.key,
    required this.data,
  });

  @override
  State<StaffsCard> createState() => _StaffsCardState();
}

class _StaffsCardState extends State<StaffsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      color: white,
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: grey,
            radius: 20,
            backgroundImage: widget.data.avatar != null
                ? NetworkImage("${widget.data.avatar}")
                : null,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.lastName != null
                    ? '${widget.data.lastName?[0]}. ${widget.data.firstName}'
                    : "${widget.data.firstName}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: dark,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${widget.data.email}',
                  style: const TextStyle(
                    color: dark,
                  ),
                ),
              ),
              Text(
                '${widget.data.phone}',
                style: const TextStyle(
                  color: dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
