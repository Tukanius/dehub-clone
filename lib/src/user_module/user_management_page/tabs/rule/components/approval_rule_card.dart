import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApprovalRuleCard extends StatefulWidget {
  final User data;
  const ApprovalRuleCard({
    super.key,
    required this.data,
  });

  @override
  State<ApprovalRuleCard> createState() => _ApprovalRuleCardState();
}

class _ApprovalRuleCardState extends State<ApprovalRuleCard> {
  General general = General();

  action() {
    final res = general.actions!
        .firstWhere((element) => element.code == widget.data.systemAction);
    return res;
  }

  module() {
    final res = general.modules!
        .firstWhere((element) => element.code == widget.data.module);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${widget.data.business?.profileName}, ',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: userColor,
                ),
              ),
              Text(
                '${widget.data.business?.refCode}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
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
                  'Салбар: ${widget.data.branch?.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(
                  "${action().name}",
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(
                  "${module().name}",
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
              Expanded(
                child: Text(
                  'Нэр: ${widget.data.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                  textAlign: TextAlign.end,
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
                  'Тохируулсан: ${widget.data.regUser?.lastName?[0]}. ${widget.data.regUser?.firstName}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Үе шат: ${widget.data.level}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: grey2,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
