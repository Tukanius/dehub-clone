import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleCard extends StatefulWidget {
  final User data;
  final Function()? onClick;
  final int index;
  const RoleCard({
    super.key,
    this.onClick,
    required this.index,
    required this.data,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  General general = General();

  accessLevel() {
    final res = general.accessLevels!
        .firstWhere((element) => element.code == widget.data.accessLevel);
    return res.name;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${widget.index + 1}'),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.refCode}',
                      style: const TextStyle(
                        color: userColor,
                      ),
                    ),
                    Text('${widget.data.profileName}'),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.data.roles!.map(
                    (role) {
                      return Container(
                        color: transparent,
                        child: Row(
                          children: [
                            Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  color: userColor,
                                  width: 2,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: userColor,
                              value: true,
                              onChanged: (value) {},
                            ),
                            Text(
                              '${role.name}',
                              style: const TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Text('Өгөгдлийн түвшин: ${accessLevel()}'),
        ],
      ),
    );
  }
}
