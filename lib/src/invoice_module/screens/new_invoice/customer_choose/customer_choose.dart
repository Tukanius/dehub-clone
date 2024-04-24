import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose_tabs/bugd.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerChoose extends StatefulWidget {
  static const routeName = '/customerchoose';
  const CustomerChoose({
    super.key,
  });

  @override
  State<CustomerChoose> createState() => _CustomerChooseState();
}

class _CustomerChooseState extends State<CustomerChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: invoiceColor,
        backgroundColor: invoiceColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: invoiceColor,
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              'assets/svg/close.svg',
              height: 30,
            ),
          ),
        ),
        title: const Text(
          'Харилцагч сонгох',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: white),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          AddButton(
            color: Colors.orange,
            onClick: () {},
          ),
        ],
      ),
      body: const Bugd(),
    );
  }
}
