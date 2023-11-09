import 'dart:async';

import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/responsible_staff_card/responsible_staff_card.dart';
import 'package:dehub/components/search_button/search_button.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/screens/client_staffs/client_staff_detail/client_staff_detail.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class ClientStaffs extends StatefulWidget {
  static const routeName = '/ClientStaffs';
  const ClientStaffs({Key? key}) : super(key: key);

  @override
  State<ClientStaffs> createState() => _ClientStaffsState();
}

class _ClientStaffsState extends State<ClientStaffs> with AfterLayoutMixin {
  bool startAnimation = false;
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result network = Result(count: 0, rows: []);
  Timer? timer;

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit, '');
  }

  list(page, limit, String query) async {
    Filter filter = Filter(query: query);
    Offset offset = Offset(page: page, limit: limit);
    var res = await BusinessApi()
        .networkList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      network = res;
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(Duration(milliseconds: 400), () {
      setState(() {
        isLoading = true;
      });
      list(page, limit, query);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: networkColor,
        iconTheme: IconThemeData(color: white),
        centerTitle: true,
        title: Text(
          "Хариуцсан ажилтнууд",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchButton(
              textColor: networkColor,
              color: networkColor,
              onChange: (query) {
                onChange(query);
              },
            ),
            SizedBox(
              height: 5,
            ),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(color: networkColor),
                  )
                : network.rows?.length != 0
                    ? Column(
                        children: network.rows!
                            .map(
                              (data) => Column(
                                children: [
                                  ResponsibleStaffCard(
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        ClientStaffDetail.routeName,
                                        arguments: ClientStaffDetailArguments(
                                          id: data.id,
                                        ),
                                      );
                                    },
                                    index: network.rows!.indexOf(data),
                                    startAnimation: startAnimation,
                                    data: data,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : NotFound(
                        module: "NETWORK",
                        labelText: 'Хоосон байна',
                      ),
          ],
        ),
      ),
    );
  }
}
