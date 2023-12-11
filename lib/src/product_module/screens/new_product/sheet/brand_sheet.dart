import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/models/result.dart';
import 'package:provider/provider.dart';

class BrandSheet extends StatefulWidget {
  const BrandSheet({super.key});

  @override
  State<BrandSheet> createState() => _BrandSheetState();
}

class _BrandSheetState extends State<BrandSheet> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result brand = Result(count: 0, rows: []);
  String brandName = '';

  @override
  afterFirstLayout(BuildContext context) async {
    brandList(page, limit);
  }

  brandList(page, limit) async {
    brand = await InventoryApi().brandList();
    setState(() {
      isLoading = false;
    });
  }

  create() async {
    InventoryGoods create = InventoryGoods();
    create.name = controller.text;
    create.logo = '';
    await InventoryApi().brandCreate(create);
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: productColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Брэндийн нэр сонгоно уу',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      color: transparent,
                      child: SvgPicture.asset('assets/svg/square-x.svg'),
                    ),
                  ),
                ],
              ),
            ),
            isLoading == true
                ? SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: FormTextField(
                          controller: controller,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.zero,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            isDense: false,
                            hintText: 'Энд бичээд нэмнэ үү',
                          ),
                          name: 'asdf',
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.text != ''
                            ? () {
                                create();
                                setState(() {
                                  brand.rows?.add(
                                    InventoryGoods(
                                      logo: null,
                                      name: controller.text,
                                    ),
                                  );
                                  controller.text = '';
                                });
                              }
                            : () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffEAECEE),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: controller.text != ''
                                    ? productColor
                                    : grey3.withOpacity(0.5),
                                size: 14,
                              ),
                              Text(
                                'Нэмэх',
                                style: TextStyle(
                                  color: controller.text != ''
                                      ? productColor
                                      : grey3.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: productColor,
                    ),
                  )
                : Column(
                    children: brand.rows!
                        .map(
                          (data) => InkWell(
                            onTap: () {
                              source.brand(data.name);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  data.logo != null && data.logo != ''
                                      ? CircleAvatar(
                                          radius: 14,
                                          backgroundColor: grey,
                                          backgroundImage:
                                              NetworkImage('${data.logo}'),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${data.name}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
            SizedBox(
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
