import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/staffs_card/staffs_card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class StaffsTab extends StatefulWidget {
  final List? staffs;
  const StaffsTab({
    Key? key,
    this.staffs,
  }) : super(key: key);

  @override
  State<StaffsTab> createState() => _StaffsTabState();
}

class _StaffsTabState extends State<StaffsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.staffs?.length != 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
                  child: Text(
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
          : NotFound(
              module: "NETWORK",
              labelText: 'Ажилтан тохируулаагүй байна',
            ),
    );
  }
}
