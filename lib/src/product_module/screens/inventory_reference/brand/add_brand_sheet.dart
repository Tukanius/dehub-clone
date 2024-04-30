import 'dart:io';
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
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddBrandSheet extends StatefulWidget {
  final String? brandName;
  final String? brandLogo;
  final String? id;
  final ListenController listenController;
  const AddBrandSheet({
    required this.listenController,
    this.brandName,
    this.brandLogo,
    this.id,
    super.key,
  });

  @override
  State<AddBrandSheet> createState() => _AddBrandSheetState();
}

class _AddBrandSheetState extends State<AddBrandSheet> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isFileEmpty = false;
  final picker = ImagePicker();
  File? image;
  InventoryGoods upload = InventoryGoods();
  bool isLoading = false;

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
      upload = await InventoryApi().upload(file.path);
      setState(() {
        isLoading = false;
      });
    }
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      InventoryGoods data = InventoryGoods.fromJson(fbKey.currentState!.value);
      data.logo = upload.url;
      try {
        if (widget.brandName == null) {
          loading.loading(true);
          await InventoryApi().brandCreate(data);
          await widget.listenController.changeVariable('brand');
          loading.loading(false);
          showCustomDialog(context, 'Амжилттай брэнд нэмлээ', true,
              onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          loading.loading(true);
          await InventoryApi().brandUpdate(widget.id!, data);
          await widget.listenController.changeVariable('brand');
          loading.loading(false);
          showCustomDialog(context, 'Амжилттай заслаа', true, onPressed: () {
            Navigator.of(context).pop();
          });
        }
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  void initState() {
    upload.url = widget.brandLogo;
    super.initState();
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
                    'Брэндийн мэдээлэл',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text('Энд бичээд "Хадгалах" сонгоно уу'),
                  ),
                  FormBuilder(
                    key: fbKey,
                    child: FormTextField(
                      textColor: productColor,
                      textAlign: TextAlign.end,
                      name: 'name',
                      initialValue: widget.brandName ?? widget.brandName,
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
                              'Брэндийн нэр',
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
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Лого'),
                        const SizedBox(
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
                              color: const Color(0xffFAFAFA),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: const Color(0xffD9D9D9),
                              ),
                            ),
                            padding: EdgeInsets.all(
                                isLoading == true || upload.url == null
                                    ? 35
                                    : 0),
                            child: isLoading == true
                                ? const CircularProgressIndicator(
                                    color: productColor,
                                    strokeWidth: 0.5,
                                  )
                                : upload.url == null
                                    ? SvgPicture.asset(
                                        'assets/svg/image_upload.svg',
                                        colorFilter: const ColorFilter.mode(
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
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
