import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PartnerCard extends StatefulWidget {
  final Invoice data;
  const PartnerCard({
    super.key,
    required this.data,
  });

  @override
  State<PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.data.logo != null
                  ? Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: lightGrey,
                        image: DecorationImage(
                          image: NetworkImage(
                            '${widget.data.logo}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: grey,
                        image: const DecorationImage(
                          image: AssetImage(
                            'images/avatar.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '${widget.data.profileName}',
                style: const TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.w500,
                ),
              )),
              const Icon(
                Icons.arrow_forward_ios,
                color: grey3,
                size: 18,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.data.partner?.refCode}',
                style: const TextStyle(
                  color: grey2,
                ),
              ),
              Text(
                '${widget.data.refCode}',
                style: const TextStyle(color: invoiceColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
