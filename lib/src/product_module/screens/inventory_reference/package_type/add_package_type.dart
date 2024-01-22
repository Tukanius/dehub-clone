import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPackageType extends StatefulWidget {
  final String? name;
  final String? id;
  const AddPackageType({
    this.name,
    this.id,
    super.key,
  });

  @override
  State<AddPackageType> createState() => _AddPackageTypeState();
}

class _AddPackageTypeState extends State<AddPackageType> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSubmit = false;

  onSubmit() async {
    try {
      if (fbKey.currentState!.saveAndValidate()) {
        setState(() {
          isSubmit = true;
        });
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        if (widget.name == null) {
          await InventoryApi().packageTypeCreate(data);
          showCustomDialog(context, 'Сав баглаа боодол амжилттай нэмлээ', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          await InventoryApi().packageTypeUpdate(widget.id!, data);
          showCustomDialog(context, 'Сав баглаа боодол амжилттай заслаа', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        }
        setState(() {
          isSubmit = false;
        });
      }
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'Сав баглаа боодол',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: isSubmit == false
                      ? () {
                          onSubmit();
                        }
                      : () {},
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
                      initialValue: widget.name ?? '',
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'name',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: white,
                        filled: true,
                        hintText: 'Энд бичнэ үү',
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
                            Text('Нэр'),
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
        ],
      ),
    );
  }
}
