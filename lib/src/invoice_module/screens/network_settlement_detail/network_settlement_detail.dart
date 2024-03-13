import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/src/invoice_module/components/network_settlement_card/partner_card.dart';
import 'package:dehub/src/invoice_module/screens/network_settlement_detail/tabs/closed_tab.dart';
import 'package:dehub/src/invoice_module/screens/network_settlement_detail/tabs/pending_tab.dart';
import 'package:dehub/src/invoice_module/screens/network_settlement_detail/tabs/open_tab.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class NetworkSettlementDetailArguments {
  Invoice data;
  NetworkSettlementDetailArguments({
    required this.data,
  });
}

class NetworkSettlementDetail extends StatefulWidget {
  static const routeName = '/NetworkSettlementDetail';
  final Invoice data;
  const NetworkSettlementDetail({
    super.key,
    required this.data,
  });

  @override
  State<NetworkSettlementDetail> createState() =>
      _NetworkSettlementDetailState();
}

class _NetworkSettlementDetailState extends State<NetworkSettlementDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: white,
          surfaceTintColor: white,
          leading: const CustomBackButton(
            color: invoiceColor,
          ),
          leadingWidth: 130,
        ),
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: white,
                      child: TabBar(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.grey.shade100),
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                        ),
                        labelColor: invoiceColor,
                        indicatorColor: invoiceColor,
                        unselectedLabelColor: grey2,
                        tabs: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Нээлттэй'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Батлах'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text('Хаагдсан'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        'Харилцагч',
                        style: TextStyle(
                            color: grey3, fontWeight: FontWeight.w600),
                      ),
                    ),
                    PartnerCard(
                      data: widget.data,
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OpenTab(
                data: widget.data,
              ),
              PendingTab(
                data: widget.data,
              ),
              ClosedTab(
                data: widget.data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
