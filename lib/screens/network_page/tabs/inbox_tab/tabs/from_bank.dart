import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class FromBank extends StatefulWidget {
  const FromBank({Key? key}) : super(key: key);

  @override
  _FromBankState createState() => _FromBankState();
}

class _FromBankState extends State<FromBank> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  Result invitation = Result(count: 0, rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    var res = await BusinessApi()
        .funder(ResultArguments(filter: filter, offset: offset));
    setState(() {
      invitation = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: networkColor,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: invitation.rows!
                  .map(
                    (item) => InboxCard(
                      onClick: () {},
                      data: item,
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
