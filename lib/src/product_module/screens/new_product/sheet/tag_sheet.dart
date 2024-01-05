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

class TagSheet extends StatefulWidget {
  const TagSheet({
    super.key,
  });

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = true;
  Result list = Result(rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    tagList();
  }

  tagList() async {
    list = await InventoryApi().tagSelect();
    setState(() {
      isLoading = false;
    });
  }

  create() async {
    InventoryGoods create = InventoryGoods();
    create.text = controller.text;
    var res = await InventoryApi().tagCreate(create);
    setState(() {
      list.rows?.add(res);
    });
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
                'Таг сонгоно уу',
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
                          children: list.rows!
                              .map(
                                (data) => InkWell(
                                  onTap: () {
                                    source.tag(data.text, data.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      "${data.text}",
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
}
