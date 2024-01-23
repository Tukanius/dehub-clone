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
  final InventoryGoods? data;
  const AddItemType({
    this.data,
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

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        data.isGoods = isGoods;
        data.isService = isService;
        if (widget.data == null) {
          await InventoryApi().itemTypeCreate(data);
          showCustomDialog(context, 'Нэр төрөл амжилттай нэмлээ', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          await InventoryApi().itemTypeUpdate(widget.data!.id!, data);
          showCustomDialog(context, 'Нэр төрөл амжилттай заслаа', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        }
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
  void initState() {
    if (widget.data != null) {
      isGoods = widget.data!.isGoods!;
      isService = widget.data!.isService!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
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
                        colorFilter: const ColorFilter.mode(grey2, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const Expanded(
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
                            onSubmit();
                          },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        color: productColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      height: 50,
                      child: const Center(
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
                        child: const Text('Энд бичээд "Хадгалах" сонгоно уу'),
                      ),
                      FormTextField(
                        textColor: productColor,
                        textAlign: TextAlign.end,
                        initialValue: widget.data?.name ?? '',
                        name: 'name',
                        decoration: const InputDecoration(
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
                            children: [
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
                            const Text(
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
                            const Text(
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
                        child: const Text(
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
                        child: const FormTextField(
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
                      const SizedBox(
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
