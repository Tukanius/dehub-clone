import 'package:dehub/src/network_module/components/branch_card/branch_card.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SectorTab extends StatefulWidget {
  final List? data;
  const SectorTab({
    super.key,
    this.data,
  });

  @override
  State<SectorTab> createState() => _SectorTabState();
}

class _SectorTabState extends State<SectorTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.data!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Харилцдаг салбар',
                    style: TextStyle(color: grey3, fontWeight: FontWeight.w600),
                  ),
                ),
                Column(
                  children: widget.data!
                      .map(
                        (data) => BranchCard(
                          data: data,
                        ),
                      )
                      .toList(),
                ),
              ],
            )
          : const NotFound(
              module: "NETWORK",
              labelText: "Салбар тохируулаагүй байна",
            ),
    );
  }
}
