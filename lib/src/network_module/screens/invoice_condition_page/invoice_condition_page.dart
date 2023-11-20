import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_condition_card/invoice_condition_card.dart';
import 'package:dehub/models/reference_information.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/network_module/screens/category_page/add_category.dart';
import 'package:dehub/src/network_module/screens/category_page/category_detail_page.dart';
import 'package:dehub/src/network_module/screens/direction_page/add_direction.dart';
import 'package:dehub/src/network_module/screens/direction_page/direction_detail_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/invoice_condition_detail_page.dart';
import 'package:dehub/src/network_module/screens/invoice_condition_page/new_condition_page.dart';
import 'package:dehub/src/network_module/screens/rank_page/add_rank.dart';
import 'package:dehub/src/network_module/screens/rank_page/rank_detail_page.dart';
import 'package:dehub/src/network_module/screens/zoning_page/add_zoning.dart';
import 'package:dehub/src/network_module/screens/zoning_page/zoning_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class InvoiceConditionPageArguments {
  ReferenceInformation data;
  InvoiceConditionPageArguments({
    required this.data,
  });
}

class InvoiceConditionPage extends StatefulWidget {
  final ReferenceInformation data;
  static const routeName = 'InvoiceConditionPage';
  const InvoiceConditionPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<InvoiceConditionPage> createState() => _InvoiceConditionPageState();
}

class _InvoiceConditionPageState extends State<InvoiceConditionPage>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result reference = Result(rows: [], count: 0);
  bool isLoading = true;
  ListenController listenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    switch (widget.data.type) {
      case "PAYMENT_TERM":
        return list(page, limit);
      case "DISTRIBUTION_AREA":
        return distributionAreaList(page, limit);
      case "CLIENT_CLASSIFICATION":
        return clientClassificationList(page, limit);
    }
  }

  @override
  void initState() {
    listenController.addListener(() async {
      switch (widget.data.type) {
        case "PAYMENT_TERM":
          return list(page, limit);
        case "DISTRIBUTION_AREA":
          return distributionAreaList(page, limit);
        case "CLIENT_CLASSIFICATION":
          return clientClassificationList(page, limit);
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  list(page, limit) async {
    Offset offset = Offset(limit: limit, page: page);
    Filter filter = Filter(condition: widget.data.listType);
    reference = await BusinessApi()
        .paymentTermList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  distributionAreaList(page, limit) async {
    Offset offset = Offset(limit: limit, page: page);
    Filter filter =
        Filter(isParent: widget.data.listType == "REGION" ? true : false);
    reference = await BusinessApi()
        .distributionAreaList(ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  clientClassificationList(page, limit) async {
    Offset offset = Offset(limit: limit, page: page);
    Filter filter = Filter(
        isParent: widget.data.listType == "CLIENT_CATEGORY" ? true : false);
    reference = await BusinessApi().clientClassificationList(
        ResultArguments(offset: offset, filter: filter));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 100,
        leading: CustomBackButton(color: networkColor),
        actions: [
          AddButton(
            addColor: white,
            color: networkColor,
            onClick: () {
              if (widget.data.listType == "INV_CONFIG") {
                Navigator.of(context).pushNamed(NewConditionPage.routeName,
                    arguments: NewConditionPageArguments(
                        listenController: listenController));
              } else if (widget.data.listType == "DIRECTION") {
                Navigator.of(context).pushNamed(AddDirection.routeName,
                    arguments: AddDirectionArguments(
                        listenController: listenController));
              } else if (widget.data.listType == "REGION") {
                Navigator.of(context).pushNamed(AddZoning.routeName,
                    arguments:
                        AddZoningArguments(listenController: listenController));
              } else if (widget.data.listType == "CLIENT_CATEGORY") {
                Navigator.of(context).pushNamed(AddCategory.routeName,
                    arguments: AddCategoryArguments(
                        listenController: listenController));
              } else if (widget.data.listType == "CLIENT_PRIORITY") {
                Navigator.of(context).pushNamed(AddRank.routeName,
                    arguments:
                        AddRankArguments(listenController: listenController));
              }
            },
          ),
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : reference.rows?.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          "${widget.data.name}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${widget.data.description}',
                          style: TextStyle(
                            color: networkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: reference.rows!
                            .map(
                              (e) => InvoiceConditionCard(
                                onClick: () {
                                  if (widget.data.listType == "INV_NET2") {
                                    Navigator.of(context).pushNamed(
                                      InvoiceConditionDetailPage.routeName,
                                      arguments:
                                          InvoiceConditionDetailPageArguments(
                                              id: e.id),
                                    );
                                  } else if (widget.data.listType == "REGION") {
                                    Navigator.of(context).pushNamed(
                                      ZoningDetailPage.routeName,
                                      arguments:
                                          ZoningDetailPageArguments(id: e.id),
                                    );
                                  } else if (widget.data.listType ==
                                      'CLIENT_CATEGORY') {
                                    Navigator.of(context).pushNamed(
                                      CategoryDetailPage.routeName,
                                      arguments:
                                          CategoryDetailPageArguments(id: e.id),
                                    );
                                  } else if (widget.data.listType ==
                                      "CLIENT_PRIORITY") {
                                    Navigator.of(context).pushNamed(
                                      RankDetailPage.routeName,
                                      arguments: RankDetailPageArguments(
                                        id: e.id,
                                      ),
                                    );
                                  } else if (widget.data.listType ==
                                      "DIRECTION") {
                                    Navigator.of(context).pushNamed(
                                      DirectionDetailPage.routeName,
                                      arguments: DirectionDetailPageArguments(
                                          id: e.id),
                                    );
                                  }
                                },
                                data: e,
                                index: reference.rows!.indexOf(e),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('images/invoice_empty.png'),
                        height: 250,
                        width: 250,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Хоосон байна!',
                      style: TextStyle(color: buttonColor, fontSize: 20),
                    )
                  ],
                ),
    );
  }
}

// Widget buildSheet() => DraggableScrollableSheet(
//       initialChildSize: 1,
//       minChildSize: 0.5,
//       maxChildSize: 1,
//       builder: (context, scrollController) => AddDirection(),
//     );
// Widget addInvoiceTerm(ListenController listenController) =>
//     DraggableScrollableSheet(
//       initialChildSize: 1,
//       minChildSize: 0.5,
//       maxChildSize: 1,
//       builder: (context, scrollController) => NewConditionPage(
//         listenController: listenController,
//       ),
//     );
// Widget addZoning() => DraggableScrollableSheet(
//       initialChildSize: 1,
//       minChildSize: 0.5,
//       maxChildSize: 1,
//       builder: (context, scrollController) => AddZoning(),
//     );
// Widget addCategory() => DraggableScrollableSheet(
//       initialChildSize: 1,
//       minChildSize: 0.5,
//       maxChildSize: 1,
//       builder: (context, scrollController) => AddCategory(),
//     );
// Widget addRank() => DraggableScrollableSheet(
//       initialChildSize: 1,
//       minChildSize: 0.5,
//       maxChildSize: 1,
//       builder: (context, scrollController) => AddRank(),
//     );
