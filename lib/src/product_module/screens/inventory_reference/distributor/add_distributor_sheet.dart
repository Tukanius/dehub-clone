import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDistributor extends StatefulWidget {
  final String? name;
  final String? id;
  final ListenController listenController;
  const AddDistributor({
    this.name,
    this.id,
    required this.listenController,
    super.key,
  });

  @override
  State<AddDistributor> createState() => _AddDistributorState();
}

class _AddDistributorState extends State<AddDistributor> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      if (fbKey.currentState!.saveAndValidate()) {
        loading.loading(true);
        InventoryGoods data =
            InventoryGoods.fromJson(fbKey.currentState!.value);
        if (widget.name == null) {
          await InventoryApi().distributorCreate(data);
          widget.listenController.changeVariable('distributor');
          loading.loading(false);
          showCustomDialog(context, 'Дистрибютр амжилттай нэмлээ', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          await InventoryApi().distributorUpdate(widget.id!, data);
          widget.listenController.changeVariable('distributor');
          loading.loading(false);
          showCustomDialog(context, 'Дистрибютр амжилттай заслаа', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        }
      }
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      colorFilter:
                          const ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Дистрибютр',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: onSubmit,
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
                      name: 'name',
                      initialValue: widget.name ?? '',
                      decoration: const InputDecoration(
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
    );
  }
}
