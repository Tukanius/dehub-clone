import 'dart:async';
import 'package:dehub/components/product_card/grid_view_product_card.dart';
import 'package:dehub/components/product_card/product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    Key? key,
    required this.id,
  }) : super(key: key);

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
    Future.delayed(Duration(milliseconds: 100), () {
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
    await Future.delayed(Duration(milliseconds: 1000));
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

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).inventoryGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: IconThemeData(color: productColor),
        title: Text(
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
                          ColorFilter.mode(productColor, BlendMode.srcIn),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: productColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: productColor,
                          ),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: SvgPicture.asset('assets/svg/search.svg'),
                        ),
                        border: OutlineInputBorder(
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
                        colorFilter:
                            ColorFilter.mode(productColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              header: WaterDropHeader(
                waterDropColor: productColor,
                refresh: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: productColor,
                  ),
                ),
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("");
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                  } else {
                    body = const Text("Мэдээлэл алга байна");
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: productColor,
                      ),
                    )
                  : inventory.rows!.length != 0
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
                      : NotFound(
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
