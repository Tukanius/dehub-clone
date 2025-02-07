import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BankAccountCard extends StatefulWidget {
  final Function()? onClick;
  final Function()? transactionClick;
  final Function()? statementClick;
  final Payment? data;
  const BankAccountCard({
    super.key,
    this.statementClick,
    this.transactionClick,
    this.data,
    this.onClick,
  });

  @override
  BankAccountCardState createState() => BankAccountCardState();
}

class BankAccountCardState extends State<BankAccountCard> {
  General general = General();
  User user = User();

  bankName() {
    var result = general.bankNames!
        .firstWhere((e) => e.code == widget.data?.bankName)
        .name;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).paymentGeneral;
    user = Provider.of<UserProvider>(context, listen: true).paymentMe;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: networkColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${widget.data?.icon}',
                            scale: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data?.number}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: grey2,
                          ),
                        ),
                        Text(
                          '${user.currentBusiness?.profileName}',
                          style: const TextStyle(color: grey2, fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Үндсэн',
                      style: TextStyle(
                        fontSize: 10,
                        color: grey2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    widget.data?.isDefault == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: networkColor),
                            child: const Text(
                              'Тийм',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: grey),
                            child: const Text(
                              'Үгүй',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Оноосон нэр',
                        style: TextStyle(
                          fontSize: 10,
                          color: grey2,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.data?.shortName}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: grey2,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (Permission().check(user, "PAY_TRX"))
                      GestureDetector(
                        onTap: widget.transactionClick,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/svg/transaction-history.svg'),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: widget.data?.bankName == "GOLOMT" ? 10 : 0,
                    ),
                    if (widget.data?.bankName == "GOLOMT" &&
                        Permission().check(user, "PAY_STM"))
                      GestureDetector(
                        onTap: widget.statementClick,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: networkColor.withOpacity(0.1),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/svg/dansnii-huulga.svg'),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
