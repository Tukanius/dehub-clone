import 'dart:async';
import 'package:dehub/src/product_module/components/product_card/grid_view_product_card.dart';
import 'package:dehub/src/product_module/components/product_card/product_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/not_found/not_found.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/models/result.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class SupplierProductListArguments {
  String id;
  SupplierProductListArguments({
    required this.id,
  });
}

class SupplierProductList extends StatefulWidget {
  static const routeName = '/SupplierProductList';
  final String id;
  const SupplierProductList({
    super.key,
    required this.id,
  });

  @override
  State<SupplierProductList> createState() => _SupplierProductListState();
}

class _SupplierProductListState extends State<SupplierProductList>
    with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result inventory = Result(rows: [], count: 0);
  Timer? timer;
  bool isSubmit = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool startAnimation = false;
  bool gridview = true;
  General general = General();

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
  }

  list(page, limit, String value) async {
    Filter filter = Filter(supplierId: widget.id);
    Offset offset = Offset(page: page, limit: limit);
    Result res = await InventoryApi()
        .storeGoods(ResultArguments(filter: filter, offset: offset));
    setState(() {
      inventory = res;
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
    await list(page, limit, '');
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
    await list(page, limit, '');
    refreshController.refreshCompleted();
    isLoading = false;
  }

  onChange(String value) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, value);
      setState(() {
        isSubmit = false;
      });
    });
  }

  fetch(String id) async {
    try {
      await InventoryApi().fetch(
        id: id,
        data: InventoryGoods(
          businessId: general.supplierBusinesses?.first.id,
          description: '',
        ),
      );
      showCustomDialog(context, 'Амжилттай', true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onButtonTapped(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Барааны жагсаалт',
          style: TextStyle(
            color: productColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: white,
            height: 50,
            padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: productColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SvgPicture.asset(
                      'assets/svg/yuluur.svg',
                      colorFilter:
                          const ColorFilter.mode(productColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 30,
                    child: FormTextField(
                      textColor: productColor,
                      name: 'query',
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: productColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: productColor,
                          ),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: SvgPicture.asset('assets/svg/search.svg'),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: grey,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: 10,
                          left: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      gridview = !gridview;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(
                        color: productColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: SvgPicture.asset(
                        'assets/svg/filter.svg',
                        colorFilter: const ColorFilter.mode(
                            productColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: productColor,
                  ),
                )
              : Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: inventory.rows!.length == inventory.count
                        ? null
                        : _onLoading,
                    onRefresh: _onRefresh,
                    color: productColor,
                    child: inventory.rows!.isNotEmpty
                        ? gridview == true
                            ? GridView.count(
                                childAspectRatio: 2 / 3,
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                children: inventory.rows!
                                    .map(
                                      (data) => GridViewProductCard(
                                        data: data,
                                        buttonClick: () {
                                          fetch(data.id);
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : ListView.builder(
                                itemCount: inventory.rows?.length,
                                itemBuilder: (context, index) => ProductCard(
                                  data: inventory.rows![index],
                                  buttonClick: () {
                                    fetch(inventory.rows?[index].id);
                                  },
                                ),
                              )
                        : const NotFound(
                            module: 'INVENTORY',
                            labelText: "Бараа олдсонгүй",
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}
