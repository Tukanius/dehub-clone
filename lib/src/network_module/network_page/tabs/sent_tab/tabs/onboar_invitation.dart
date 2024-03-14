import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/src/network_module/components/partner_cards/invitation_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/sent_invitation_detail/sent_invitation_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OnboarInvitation extends StatefulWidget {
  const OnboarInvitation({super.key});

  @override
  OnboarInvitationState createState() => OnboarInvitationState();
}

class OnboarInvitationState extends State<OnboarInvitation>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result invitation = Result(rows: [], count: 0);
  bool isLoading = true;
  bool startAnimation = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(type: "ONBOARDING");
    invitation = await BusinessApi().listSent(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      isLoading = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  @override
  afterFirstLayout(BuildContext context) async {
    list(page, limit);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: networkColor,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading:
                invitation.rows!.length == invitation.count ? null : _onLoading,
            onRefresh: _onRefresh,
            color: networkColor,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    invitation.rows!.isNotEmpty
                        ? Column(
                            children: invitation.rows!
                                .map(
                                  (item) => InvitationCard(
                                    send: true,
                                    data: item,
                                    startAnimation: startAnimation,
                                    index: invitation.rows!.indexOf(item),
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        SentInvitationDetail.routeName,
                                        arguments:
                                            SentInvitationDetailArguments(
                                                id: item.id),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : const NotFound(
                            module: 'NETWORK',
                            labelText: "Урилга олдсонгүй",
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
