import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventorySupplierCard extends StatefulWidget {
  final Function()? onClick;
  final InventoryGoods? data;
  final int index;
  final bool? type;
  final bool startAnimation;
  InventorySupplierCard({
    required this.index,
    required this.startAnimation,
    this.data,
    this.type,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  _InventorySupplierCardState createState() => _InventorySupplierCardState();
}

class _InventorySupplierCardState extends State<InventorySupplierCard> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(width: 0.5, color: Color(0xffF2F2F2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data?.logo == null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: grey,
                          backgroundImage: AssetImage('images/avatar.png'),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(
                            '${widget.data?.logo}',
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data?.profileName}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.data?.partner?.businessName}',
                          style: TextStyle(fontSize: 12, color: grey3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data!.refCode}',
                      style: TextStyle(
                        fontSize: 12,
                        color: grey3,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'ТТД: ',
                          style: TextStyle(color: grey3, fontSize: 10),
                        ),
                        Text(
                          '${widget.data?.regNumber}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: grey3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
