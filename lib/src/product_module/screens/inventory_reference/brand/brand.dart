import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/components/update_sheet/update_sheet.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/brand/add_brand_sheet.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class InventoryBrand extends StatefulWidget {
  static const routeName = '/InventoryBrand';
  const InventoryBrand({super.key});

  @override
  State<InventoryBrand> createState() => _InventoryBrandState();
}

class _InventoryBrandState extends State<InventoryBrand> with AfterLayoutMixin {
  ListenController listenController = ListenController();
  Result brand = Result(rows: []);
  bool isLoading = true;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    brand = await InventoryApi().brandList();
    setState(() {
      isLoading = false;
    });
  }

  update(String id, String name, String logo) {
    updateSheet(context, updateClick: () {
      if (Permission().check(user, "ERP_REF_BRND", boolean: 'isEdit')) {
        Navigator.of(context).pop();
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          builder: (context) => AddBrandSheet(
            listenController: listenController,
            id: id,
            brandName: name,
            brandLogo: logo,
          ),
        );
      } else {
        showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
      }
    }, deleteClick: () async {
      if (Permission().check(user, "ERP_REF_BRND", boolean: 'isDelete')) {
        try {
          setState(() {
            isLoading = true;
          });
          await InventoryApi().brandDelete(id);
          brand = await InventoryApi().brandList();
          Navigator.of(context).pop();
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
      }
    });
  }

  @override
  void initState() {
    listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      brand = await InventoryApi().brandList();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).inventoryMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: white,
        backgroundColor: white,
        iconTheme: const IconThemeData(color: productColor),
        title: const Text(
          'Брэнд',
          style: TextStyle(
            color: productColor,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButton:
          Permission().check(user, "ERP_REF_BRND", boolean: 'isCreate')
              ? FloatingActionButton(
                  backgroundColor: productColor,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) => AddBrandSheet(
                        listenController: listenController,
                      ),
                    );
                  },
                )
              : null,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: productColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Брэндийн жагсаалт нэмнэ үү',
                    ),
                  ),
                  Column(
                    children: brand.rows!
                        .map(
                          (data) => Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 14,
                                      backgroundColor: grey,
                                      backgroundImage:
                                          NetworkImage('${data.logo}'),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${data.name}',
                                      style: const TextStyle(color: dark),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    update(data.id, data.name, data.logo);
                                  },
                                  child: Container(
                                    color: transparent,
                                    padding: const EdgeInsets.all(3),
                                    child: SvgPicture.asset(
                                      'assets/svg/edit_rounded.svg',
                                      colorFilter: const ColorFilter.mode(
                                          productColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
