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
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BrandSheet extends StatefulWidget {
  const BrandSheet({super.key});

  @override
  State<BrandSheet> createState() => _BrandSheetState();
}

class _BrandSheetState extends State<BrandSheet> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;
  Result brand = Result(count: 0, rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    brandList();
  }

  brandList() async {
    brand = await InventoryApi().brandList();
    setState(() {
      isLoading = false;
    });
  }

  create() async {
    InventoryGoods create = InventoryGoods();
    create.name = controller.text;
    create.logo = '';
    var res = await InventoryApi().brandCreate(create);
    setState(() {
      brand.rows?.add(res);
    });
  }

  update(String id, String logo) async {
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods data = InventoryGoods.fromJson(fbKey.currentState!.value);
      data.logo = '';
      try {
        await InventoryApi().brandUpdate(id, data);
        await brandList();
        Navigator.of(context).pop();
      } catch (e) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: const BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                isLoading == true
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: FormTextField(
                              controller: controller,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.zero,
                                ),
                                contentPadding: EdgeInsets.symmetric(
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
                                color: const Color(0xffEAECEE),
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
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: productColor,
                        ),
                      )
                    : Column(
                        children: brand.rows!
                            .map(
                              (data) => InkWell(
                                onLongPress: () {
                                  show(data.id, data.name, data.logo ?? '');
                                },
                                onTap: () {
                                  source.brand(data.name, data.id);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (data.logo != null &&
                                              data.logo != '')
                                            CircleAvatar(
                                              radius: 14,
                                              backgroundColor: grey,
                                              backgroundImage:
                                                  NetworkImage('${data.logo}'),
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            data.name,
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/double-check.svg',
                                        colorFilter: ColorFilter.mode(
                                            source.product.brandName ==
                                                    data.name
                                                ? productColor
                                                : grey3,
                                            BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  show(String id, String name, String logo) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ctx) {
        return Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(name),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      brandChange(id, name, logo);
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.edit_note_sharp,
                            color: productColor,
                          ),
                          Text(
                            'Засах',
                            style: TextStyle(color: productColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await InventoryApi().brandDelete(id);
                      await brandList();
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.delete_outline_outlined,
                            color: red,
                          ),
                          Text(
                            'Устгах',
                            style: TextStyle(color: red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  brandChange(String id, String name, String logo) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.only(top: 75),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Нэр солих',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: FormBuilder(
                    key: fbKey,
                    child: FormTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        hintText: 'Нэр оруулна уу',
                        fillColor: white,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: grey),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Нэр оруулна уу'),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: const Text(
                        "Цуцлах",
                        style: TextStyle(color: red),
                      ),
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "Засах",
                          style: TextStyle(color: dark),
                        ),
                        onPressed: () async {
                          update(id, logo);
                        }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
