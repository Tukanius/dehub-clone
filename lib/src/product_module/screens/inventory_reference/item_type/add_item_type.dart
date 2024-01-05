import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddItemType extends StatefulWidget {
  const AddItemType({
    super.key,
  });

  @override
  State<AddItemType> createState() => _AddItemTypeState();
}

class _AddItemTypeState extends State<AddItemType> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isGoods = false;
  bool isService = false;
  bool isSubmit = false;

  create() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        data.isGoods = isGoods;
        data.isService = isService;
        await InventoryApi().itemTypeCreate(data);
        showCustomDialog(context, 'Нэр төрөл амжилттай нэмлээ', true,
            onPressed: () {
          Navigator.of(context).pop();
        });
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
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
                      'Нэр төрөл',
                      style: TextStyle(
                        color: productColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: isSubmit == true
                        ? () {}
                        : () {
                            create();
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
                          'Хадгалах',
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
                child: FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('Энд бичээд "Хадгалах" сонгоно уу'),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        name: 'name',
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
                                'Нэр',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
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
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Бараанд хамаарах',
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: paymentColor,
                                value: isGoods,
                                onChanged: (bool value) {
                                  setState(() {
                                    isGoods = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ажилт үйлчилгээнд хамрах',
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: paymentColor,
                                value: isService,
                                onChanged: (bool value) {
                                  setState(() {
                                    isService = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
                          'Тайлбар',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        color: white,
                        padding: const EdgeInsets.all(15),
                        child: FormTextField(
                          textAlign: TextAlign.left,
                          name: 'description',
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: grey),
                            ),
                            fillColor: white,
                            filled: true,
                            hintStyle: TextStyle(
                              color: grey2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
