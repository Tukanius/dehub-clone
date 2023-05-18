import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/invoice_condition_card/invoice_condition_card.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/invoice_condition_detail_page.dart';
import 'package:dehub/screens/network_page/tabs/dashboard_tab/invoice_condition_page/new_condition_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InvoiceConditionPage extends StatefulWidget {
  static const routeName = 'InvoiceConditionPage';
  const InvoiceConditionPage({super.key});

  @override
  State<InvoiceConditionPage> createState() => _InvoiceConditionPageState();
}

class _InvoiceConditionPageState extends State<InvoiceConditionPage> {
  List<String> labelText = [
    'INV_NET_10',
    'INV_COD',
    'INV_EOM',
    'INV_MF_X',
    'INV_SOM',
  ];
  List<String> description = [
    'Баталснаас хойш 10 хоногт төлөх',
    "Баталсан дариу төлөх",
    "Баталсан сарын сүүлийн өдөр төлөх",
    "Баталсны дараа Х-ны өдөр төлөх",
    "Тайлбар мэдээлэл",
  ];

  // List<Object> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: networkColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: networkColor,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        actions: [
          AddButton(
            addColor: white,
            color: networkColor,
            onClick: () {
              Navigator.of(context).pushNamed(NewConditionPage.routeName);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Нэхэмжлэх нөхцөл',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Төлбөрийн нөхцөл',
              style: TextStyle(
                color: networkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          for (var i = 0; i < labelText.length; i++)
            InvoiceConditionCard(
              onClick: () {
                Navigator.of(context)
                    .pushNamed(InvoiceConditionDetailPage.routeName);
              },
              index: i,
              labelText: labelText[i],
              description: description[i],
            ),
          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     var data = labelText[index];
          //     var des = description[index];
          //     return InvoiceConditionCard(
          //       labelText: data,
          //       description: des,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
