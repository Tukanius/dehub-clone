import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OptionInformationSheet extends StatefulWidget {
  final List<InventoryGoods> arrayData;
  final InventoryGoods jsonData;
  final int index;
  const OptionInformationSheet({
    super.key,
    required this.index,
    required this.jsonData,
    required this.arrayData,
  });

  @override
  State<OptionInformationSheet> createState() => _OptionInformationSheetState();
}

class _OptionInformationSheetState extends State<OptionInformationSheet> {
  String name = '';
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isFileEmpty = false;
  final picker = ImagePicker();
  File? image;
  InventoryGoods upload = InventoryGoods();
  bool isLoading = false;

  @override
  void initState() {
    List<String> names = widget.arrayData.map((e) => e.name!).toList();
    name = names.join(', ');
    super.initState();
  }

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);

    if (file != null) {
      setState(() {
        image = File(file.path);
        isLoading = true;
      });
      setState(() {
        isFileEmpty = false;
      });
      upload = await InventoryApi().upload(file);
      setState(() {
        isLoading = false;
      });
    }
  }

  onSubmit() async {
    List<InventoryGoods> optionValues = [];

    if (fbKey.currentState!.saveAndValidate()) {
      for (var i = 0; i < widget.arrayData.length; i++) {
        optionValues.add(
          InventoryGoods(
            optionId: widget.arrayData[i].optionId,
            name: widget.arrayData[i].name,
          ),
        );
      }
      InventoryGoods data = InventoryGoods.fromJson(fbKey.currentState!.value);
      data.goodsId = widget.jsonData.id;
      data.optionValues = optionValues;
      data.skuCode = '${widget.jsonData.skuCode}-${widget.index + 1}';
      data.barCode = '${widget.jsonData.barCode}-${widget.index + 1}';
      data.erpCode = '${widget.jsonData.erpCode}-${widget.index + 1}';
      data.image = upload.url != null ? upload.url : widget.jsonData.image;
      await InventoryApi().variant(data);
      await Provider.of<InventoryProvider>(context, listen: false)
          .removeOption(widget.index);
      showCustomDialog(
        context,
        "Хувилбар амжилттай үүслээ",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: productColor),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(3),
                    color: transparent,
                    child: SvgPicture.asset(
                      'assets/svg/square-x.svg',
                      colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Хувилбар хянах',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onSubmit();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: productColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    child: Center(
                      child: Text(
                        'Болсон',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          'Хувилбар',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      Container(
                        color: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                optionName(),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'SKU-1000000',
                                  style: TextStyle(color: grey2),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: productColor,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Лого'),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                getImage(ImageSource.gallery);
                              },
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Color(0xffFAFAFA),
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Color(0xffD9D9D9),
                                  ),
                                ),
                                padding: EdgeInsets.all(
                                    isLoading == true || upload.url == null
                                        ? 35
                                        : 0),
                                child: isLoading == true
                                    ? CircularProgressIndicator(
                                        color: productColor,
                                        strokeWidth: 0.5,
                                      )
                                    : upload.url == null
                                        ? SvgPicture.asset(
                                            'assets/svg/image_upload.svg',
                                            colorFilter: ColorFilter.mode(
                                                productColor, BlendMode.srcIn),
                                          )
                                        : Image.network(
                                            "${upload.url}",
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          'Хадгалах, эсвэл засна уу',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'DeHUB-Код',
                        secondText: 'Авто үүснэ',
                        secondTextColor: productColor,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'SKU код',
                        secondText:
                            '${widget.jsonData.skuCode}-${widget.index + 1}',
                        secondTextColor: productColor,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'Бар код',
                        secondText:
                            '${widget.jsonData.barCode}-${widget.index + 1}',
                        secondTextColor: productColor,
                      ),
                      FieldCard(
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        color: white,
                        labelText: 'ERP код',
                        secondText:
                            '${widget.jsonData.erpCode}-${widget.index + 1}',
                        secondTextColor: productColor,
                      ),
                      FormTextField(
                        initialValue: "${widget.jsonData.nameApp}, ${name}",
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'nameApp',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Апп-д гарах нэр',
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      FormTextField(
                        initialValue: "${widget.jsonData.nameWeb}, ${name}",
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'nameWeb',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Вебд гарах нэр',
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      FormTextField(
                        initialValue: "${widget.jsonData.nameBill}, ${name}",
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'nameBill',
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: white,
                          filled: true,
                          hintText: 'Энд оруулна уу',
                          hintStyle: TextStyle(
                            color: productColor,
                          ),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Падааны нэр',
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionName() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: productColor, fontFamily: "Montserrat"),
        children: widget.arrayData.map((e) {
          "${e.name} ${e.optionId == widget.arrayData.last.optionId ? "" : ","} ";
          return TextSpan(
            text:
                "${e.name} ${e.optionId == widget.arrayData.last.optionId ? "" : ","} ",
          );
        }).toList(),
      ),
    );
  }
}
