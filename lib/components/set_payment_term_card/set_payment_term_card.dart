import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SetPaymentTermCard extends StatefulWidget {
  final bool startAnimation;
  final BusinessNetwork? data;
  final int index;
  final Function()? onClick;
  const SetPaymentTermCard({
    Key? key,
    this.onClick,
    this.data,
    required this.index,
    required this.startAnimation,
  }) : super(key: key);

  @override
  State<SetPaymentTermCard> createState() => _SetPaymentTermCardState();
}

class _SetPaymentTermCardState extends State<SetPaymentTermCard> {
  General general = General();

  getPaymentTerm(String? condition) {
    var res = general.paymentTermConditions!
        .firstWhere((element) => element.code == condition)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;

    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: grey,
                        radius: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data?.partner?.businessName}',
                              style: TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data?.refCode}',
                              style: TextStyle(
                                color: dark,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: networkColor,
                  size: 18,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Төлбөрийн хэлбэр:',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/note.svg',
                            colorFilter:
                                ColorFilter.mode(networkColor, BlendMode.srcIn),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: widget.data?.paymentTerm?.description != null
                                ? Text(
                                    getPaymentTerm(widget
                                            .data?.paymentTerm?.condition
                                            .toString())
                                        .toString(),
                                    style: TextStyle(
                                      color: networkColor,
                                      fontSize: 12,
                                    ),
                                  )
                                : Text(
                                    '-',
                                    style: TextStyle(
                                      color: networkColor,
                                      fontSize: 12,
                                    ),
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Төлбөрийн нөхцөл',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      widget.data?.paymentTerm?.refCode != null
                          ? Text(
                              '${widget.data?.paymentTerm?.refCode}',
                              style: TextStyle(
                                color: networkColor,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              '-',
                              style: TextStyle(
                                color: networkColor,
                                fontSize: 12,
                              ),
                            ),
                      widget.data?.paymentTerm?.description != null
                          ? Text(
                              '${widget.data?.paymentTerm?.description}',
                              style: TextStyle(
                                color: dark,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              '-',
                              style: TextStyle(
                                color: dark,
                                fontSize: 12,
                              ),
                            ),
                    ],
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