import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceRoleCard extends StatefulWidget {
  final User data;
  const FinanceRoleCard({
    super.key,
    required this.data,
  });

  @override
  State<FinanceRoleCard> createState() => _FinanceRoleCardState();
}

class _FinanceRoleCardState extends State<FinanceRoleCard> {
  General general = General();

  bank() {
    final res = general.bankNames!
        .firstWhere((element) => element.code == widget.data.bank);
    return res;
  }

  financeRole() {
    final res = general.financeRoleStatus!
        .firstWhere((element) => element.code == widget.data.financeRoleStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).userGeneral;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: grey,
                  image: widget.data.user?.avatar != null
                      ? DecorationImage(
                          image: NetworkImage(
                            '${widget.data.user?.avatar}',
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
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
                        '${widget.data.user?.lastName?[0]}. ${widget.data.user?.firstName}'),
                    Text(
                      widget.data.username ?? '-',
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${widget.data.user?.phone}',
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 45),
            child: Text(
              '${widget.data.user?.email}',
              style: const TextStyle(
                color: grey2,
                fontSize: 12,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage('${bank().icon}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text('${bank().name}'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Бизнес: -',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: userColor.withOpacity(0.1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  '${financeRole().name}',
                  style: const TextStyle(
                    color: userColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
