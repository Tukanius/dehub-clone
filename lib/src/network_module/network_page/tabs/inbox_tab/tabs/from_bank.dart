import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/partner_cards/inbox_card.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
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
  ListenController listenController = ListenController();

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
  void initState() {
    listenController.addListener(() async {
      await list(page, limit);
    });
    super.initState();
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
            child: invitation.rows?.length != 0
                ? Column(
                    children: invitation.rows!
                        .map(
                          (item) => InboxCard(
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(InvitationDetailPage.routeName,
                                      arguments: InvitationDetailPageArguments(
                                        listenController: listenController,
                                        id: item.id,
                                      ));
                            },
                            data: item,
                          ),
                        )
                        .toList(),
                  )
                : NotFound(
                    module: "NETWORK",
                    labelText: 'Хоосон байна',
                  ),
          );
  }
}
