import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/add_button/add_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/partner_module/components/warehouse_card/warehouse_card.dart';
import 'package:dehub/src/partner_module/screens/warehouse_create/warehouse_create.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  Partner user = Partner();

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
  afterFirstLayout(BuildContext context) async {
    if (Permission().partnerCheck(user, "PRT_WRH")) {
      await list(page, limit);
    }
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
    final load = Provider.of<LoadingProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return Scaffold(
      backgroundColor: backgroundColor,
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
          if (Permission().partnerCheck(user, "PRT_WRH", boolean: "isCreate"))
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
      body: Permission().partnerCheck(user, "PRT_WRH")
          ? isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: partnerColor,
                  ),
                )
              : Refresher(
                  refreshController: refreshController,
                  onLoading: warehouse.rows!.length == warehouse.count
                      ? null
                      : onLoading,
                  onRefresh: onRefresh,
                  color: partnerColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: warehouse.rows!
                              .map(
                                (data) => WarehouseCard(
                                    editClick: Permission().partnerCheck(
                                            user, "PRT_WRH", boolean: "isEdit")
                                        ? () {
                                            Navigator.of(context).pushNamed(
                                              WarehouseCreate.routeName,
                                              arguments:
                                                  WarehouseCreateArguments(
                                                data: data,
                                                listenController:
                                                    listenController,
                                              ),
                                            );
                                          }
                                        : null,
                                    data: data,
                                    border: warehouse.rows?.last.id != data.id,
                                    deleteClick: Permission().partnerCheck(
                                            user, "PRT_WRH",
                                            boolean: 'isdelete')
                                        ? () async {
                                            load.loading(true);
                                            await PartnerApi()
                                                .warehouseDelete(data.id);
                                            load.loading(false);
                                          }
                                        : () {}),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                )
          : const NotFound(
              module: "PARTNER",
              labelText: 'Хандах эрх хүрэхгүй байна',
            ),
    );
  }
}
