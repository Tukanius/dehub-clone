import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/src/product_module/screens/create_sub_category/create_sub_category.dart';
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

class CategorySheet extends StatefulWidget {
  final String type;
  final String labelText;
  const CategorySheet({
    super.key,
    required this.type,
    required this.labelText,
  });

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = true;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  Result list = Result(count: 0, rows: []);
  InventoryGoods source = InventoryGoods();

  @override
  afterFirstLayout(BuildContext context) async {
    source = Provider.of<InventoryProvider>(context, listen: false).product;
    categoryList();
  }

  categoryList() async {
    if (widget.type == "SUB_CLASSIFICATION") {
      list = await InventoryApi().categoryList(
          widget.type, source.itemTypeId!, source.classificationId!);
    } else if (widget.type == "CATEGORY") {
      list = await InventoryApi().categoryList(
          widget.type, source.itemTypeId!, source.subClassificationId!);
    } else if (widget.type == "SUB_CATEGORY") {
      list = await InventoryApi()
          .categoryList(widget.type, source.itemTypeId!, source.categoryId!);
    } else {
      list = await InventoryApi()
          .categoryList(widget.type, source.itemTypeId!, '');
    }
    setState(() {
      isLoading = false;
    });
  }

  create() async {
    InventoryGoods create = InventoryGoods();
    InventoryGoods provider =
        Provider.of<InventoryProvider>(context, listen: false).product;
    create.name = controller.text;
    create.description = controller.text;
    create.itemTypeId = provider.itemTypeId;
    if (widget.type == 'SUB_CLASSIFICATION') {
      create.parentId = provider.classificationId;
    } else if (widget.type == "CATEGORY") {
      create.parentId = provider.subClassificationId;
    }
    create.type = widget.type;
    InventoryGoods res = await InventoryApi().categoryCreate(create);
    setState(() {
      list.rows?.add(res);
    });
  }

  update(String id) async {
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods data = InventoryGoods.fromJson(fbKey.currentState!.value);
      data.description = '';
      try {
        await InventoryApi().categoryUpdate(id, data);
        await categoryList();
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
                '${widget.labelText}',
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
            child: Container(
              child: Column(
                children: [
                  isLoading == true
                      ? SizedBox()
                      : widget.type != 'SUB_CATEGORY'
                          ? Row(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 15),
                                      isDense: false,
                                      hintText: 'Энд бичээд нэмнэ үү',
                                    ),
                                    name: 'create',
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
                                      color: Color(0xffEAECEE),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                            )
                          : GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop();
                                await Navigator.of(context)
                                    .pushNamed(CreateSubCategory.routeName);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                color: transparent,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Энд дараад нэмнэ үү',
                                        style: TextStyle(color: grey3),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffEAECEE),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: productColor,
                                            size: 14,
                                          ),
                                          Text(
                                            'Нэмэх',
                                            style: TextStyle(
                                              color: productColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: productColor,
                          ),
                        )
                      : Column(
                          children: list.rows!
                              .map(
                                (data) => InkWell(
                                  onLongPress: () {
                                    show(data.id, data.name);
                                  },
                                  onTap: () {
                                    widget.type == "CLASSIFICATION"
                                        ? source.classification(
                                            data.name, data.id)
                                        : widget.type == "SUB_CLASSIFICATION"
                                            ? source.subClassification(
                                                data.name, data.id)
                                            : widget.type == "CATEGORY"
                                                ? source.category(
                                                    data.name, data.id)
                                                : source.subCategory(
                                                    data.name, data.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      "${data.name}",
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
          ),
        ),
      ],
    );
  }

  show(String id, String name) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
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
              Text('${name}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      changePassword(id, name);
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.all(10),
                      child: Column(
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
                      await InventoryApi().categoryDelete(id);
                      await categoryList();
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: transparent,
                      padding: const EdgeInsets.all(10),
                      child: Column(
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

  changePassword(String id, String name) {
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
                Text(
                  'Нэр солих',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  child: FormBuilder(
                    key: fbKey,
                    child: FormTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        hintText: 'Нэр оруулна уу',
                        fillColor: white,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
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
                SizedBox(
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
                          update(id);
                          Navigator.of(ctx).pop();
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
