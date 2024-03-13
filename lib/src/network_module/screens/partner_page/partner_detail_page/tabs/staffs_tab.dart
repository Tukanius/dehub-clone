import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/network_module/components/staffs_card/staffs_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class StaffsTab extends StatefulWidget {
  final List? staffs;
  const StaffsTab({
    super.key,
    this.staffs,
  });

  @override
  State<StaffsTab> createState() => _StaffsTabState();
}

class _StaffsTabState extends State<StaffsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.staffs!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
                  child: const Text(
                    'Ажилтнууд',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  children: widget.staffs!
                      .map(
                        (data) => StaffsCard(
                          data: data,
                        ),
                      )
                      .toList(),
                )
              ],
            )
          : const NotFound(
              module: "NETWORK",
              labelText: 'Ажилтан тохируулаагүй байна',
            ),
    );
  }
}
