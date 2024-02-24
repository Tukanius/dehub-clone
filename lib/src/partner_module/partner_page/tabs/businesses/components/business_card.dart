import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BusinessCard extends StatefulWidget {
  final Function()? onClick;
  final Partner data;
  const BusinessCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  General general = General();

  businessStatus() {
    final res = general.businessStatus!
        .firstWhere((element) => element.code == widget.data.businessStatus)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        color: white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.data.logo}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data.profileName}',
                        style: const TextStyle(
                          color: partnerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.data.refCode}',
                        style: const TextStyle(color: grey2, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: partnerColor.withOpacity(0.2),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/edit_rounded.svg',
                    colorFilter:
                        const ColorFilter.mode(partnerColor, BlendMode.srcIn),
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
                  child: Text(
                    'Партнер: ${widget.data.partnerName}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${businessStatus()}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
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
                  child: Text(
                    'Сектор: ${widget.data.businessSector?.name}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Дэд сектор: ${widget.data.businessSubSector?.name}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
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
