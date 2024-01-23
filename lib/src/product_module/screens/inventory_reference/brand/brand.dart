import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/update_sheet/update_sheet.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/src/product_module/screens/inventory_reference/brand/add_brand_sheet.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class InventoryBrand extends StatefulWidget {
  static const routeName = '/InventoryBrand';
  const InventoryBrand({super.key});

  @override
  State<InventoryBrand> createState() => _InventoryBrandState();
}

class _InventoryBrandState extends State<InventoryBrand> with AfterLayoutMixin {
  Result brand = Result(rows: []);
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    brand = await InventoryApi().brandList();
    setState(() {
      isLoading = false;
    });
  }

  update(String id, String name, String logo) {
    updateSheet(context, updateClick: () {
      Navigator.of(context).pop();
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        builder: (context) => AddBrandSheet(
          id: id,
          brandName: name,
          brandLogo: logo,
        ),
      );
    }, deleteClick: () async {
      try {
        setState(() {
          isLoading = true;
        });
        InventoryApi().brandDelete(id);
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
    });
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
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
            builder: (context) => const AddBrandSheet(),
          );
        },
      ),
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
