import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
    );
  }
}
