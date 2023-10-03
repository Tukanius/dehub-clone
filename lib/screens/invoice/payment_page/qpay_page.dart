// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/qpay-urls.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QpayPageArguments {
  Invoice data;
  Color color;
  QpayPageArguments({
    required this.color,
    required this.data,
  });
}

class QpayPage extends StatefulWidget {
  final Color color;
  final Invoice data;
  static const routeName = "QPayPage";
  const QpayPage({
    required this.color,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  QpayPageState createState() => QpayPageState();
}

class QpayPageState extends State<QpayPage> with AfterLayoutMixin<QpayPage> {
  bool loading = true;
  Invoice qpay = Invoice();
  Invoice data = Invoice();

  @override
  void afterFirstLayout(BuildContext context) async {
    try {
      data = widget.data;
      data.method = "QPAY";
      qpay = await PaymentApi().qpay(data);
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint('======err======');
      debugPrint(e.toString());
      debugPrint('======err======');
    }
  }

  Future<void> _launchInBrowser(String url, Urls link) async {
    try {
      if (!await launch("${url}")) throw 'Could not launch $url';
    } catch (e) {
      String storeLink = "";
      if (Platform.isIOS) {
        storeLink =
            "https://apps.apple.com/mn/app/${getDeepLink("${link.name}")}/id${getCode('${link.name}')}";
      } else {
        storeLink =
            "https://play.google.com/store/search?q=${"${link.name}"}&c=apps";
      }
      await launch(storeLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: widget.color),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Qpay-р төлөх',
          style: TextStyle(color: black),
        ),
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: widget.color,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      color: backgroundColor,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 20),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Text(
                      'Төлөлт хийх заавах',
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text(
                        'Та доорх QR кодыг банк апп-р уншуулах эсвэл банкаа сонгож АПП-р төлнө уу.',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.memory(
                        base64Decode('${qpay.qr_image?.substring(22)}'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Банкны апп дуудаж төлөх',
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: qpay.urls!
                            .map(
                              (item) => GestureDetector(
                                onTap: () {
                                  _launchInBrowser(item.link.toString(), item);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: NetworkImage('${item.logo}'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      item.description ==
                                              "Үндэсний хөрөнгө оруулалтын банк"
                                          ? Text(
                                              'ҮХОБ',
                                              style: TextStyle(
                                                color: grey2,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          : Text(
                                              '${item.description}',
                                              style: TextStyle(
                                                color: grey2,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      labelColor: widget.color,
                      labelText: "Төлбөр шалгах",
                      onClick: () {},
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

String getDeepLink(String name) {
  switch (name) {
    case "qPay wallet":
      return "qpay-wallet";
    case "Khan bank":
      return "khan-bank";
    case "State bank":
      return "state-bank";
    case "Xac bank":
      return "xacbank";
    case "Trade and Development bank":
      return "tdb-online";
    case "Most money":
      return "mostmoney";
    case "National investment bank":
      return "nibank";
    case "Chinggis khaan bank":
      return "smartbank-ckbank";
    case "Capitron bank":
      return "capitron-digital-bank";
    case "Bogd bank":
      return "bogd-mobile";
    case "Trans bank":
      return "transbаnk";
    case "M bank":
      return "%D0%BC-bank";
    case "Ard App":
      return "ard-app";
    case "Arig bank":
      return "arig-online";
    default:
      return "";
  }
}

String? getCode(String name) {
  switch (name) {
    case "qPay wallet":
      return "1501873159";
    case "Khan bank":
      return "1555908766";
    case "State bank":
      return "703343972";
    case "Xac bank":
      return "1534265552";
    case "Trade and Development bank":
      return "1458831706";
    case "Most money":
      return "487144325";
    case "National investment bank":
      return "882075781";
    case "Chinggis khaan bank":
      return "1180620714";
    case "Capitron bank":
      return "1612591322";
    case "Bogd bank":
      return "1475442374";
    case "Trans bank":
      return "1604334470";
    case "M bank":
      return "1455928972";
    case "Ard App":
      return "6444296485";
    case "Arig bank":
      return "6444022675";
    default:
      return "";
  }
}
