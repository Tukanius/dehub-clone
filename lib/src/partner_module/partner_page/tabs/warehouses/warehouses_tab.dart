import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/partner_module/partner_page/tabs/warehouses/components/warehouse_card.dart';
import 'package:dehub/src/partner_module/screens/warehouse_create/warehouse_create.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WarehousesTab extends StatefulWidget {
  const WarehousesTab({super.key});

  @override
  State<WarehousesTab> createState() => _WarehousesTabState();
}

class _WarehousesTabState extends State<WarehousesTab> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  Result warehouse = Result(rows: [], count: 0);
  bool isLoading = true;
  ListenController listenController = ListenController();
  final RefreshController refreshController = RefreshController();

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    warehouse = await PartnerApi()
        .warehouse(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      limit = 10;
      isLoading = true;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
    refreshController.loadComplete();
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      await list(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: partnerColor,
        backgroundColor: partnerColor,
        title: const Text(
          "Агуулахууд",
          style: TextStyle(
            color: white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: white),
        actions: [
          AddButton(
            addColor: partnerColor,
            color: white,
            onClick: () {
              Navigator.of(context).pushNamed(
                WarehouseCreate.routeName,
                arguments: WarehouseCreateArguments(
                  data: null,
                  listenController: listenController,
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: partnerColor,
              ),
            )
          : Refresher(
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              color: partnerColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: warehouse.rows!
                          .map(
                            (data) => WarehouseCard(
                              editClick: () {
                                Navigator.of(context).pushNamed(
                                  WarehouseCreate.routeName,
                                  arguments: WarehouseCreateArguments(
                                    data: data,
                                    listenController: listenController,
                                  ),
                                );
                              },
                              data: data,
                              border: warehouse.rows?.last.id != data.id,
                              deleteClick: () async {
                                await PartnerApi().warehouseDelete(data.id);
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
