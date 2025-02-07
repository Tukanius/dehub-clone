import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/business_staffs.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddCategoryArguments {
  ListenController listenController;
  AddCategoryArguments({
    required this.listenController,
  });
}

class AddCategory extends StatefulWidget {
  final ListenController listenController;
  static const routeName = 'AddCategory';
  const AddCategory({
    super.key,
    required this.listenController,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        BusinessStaffs businessStaffs =
            BusinessStaffs.fromJson(fbKey.currentState!.value);
        businessStaffs.parentId = '';
        await BusinessApi().createClientClassification(businessStaffs);
        await Provider.of<GeneralProvider>(context, listen: false)
            .businessInit(true);
        widget.listenController.changeVariable('createCategory');
        Navigator.of(context).pop();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: networkColor,
          surfaceTintColor: networkColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset('assets/svg/close.svg'),
            ),
          ),
          title: const Text(
            'Харилцагчийн ангилал',
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Мэдээлэл',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ангилал',
                      style: TextStyle(color: dark),
                    ),
                    Text(
                      'Авто үүснэ',
                      style: TextStyle(
                        color: networkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              FormBuilder(
                key: fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      textAlign: TextAlign.right,
                      name: 'name',
                      textColor: networkColor,
                      decoration: InputDecoration(
                        hintText: 'Ангилал нэр оруулах',
                        fillColor: white,
                        hintStyle: const TextStyle(color: networkColor),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: const Text(
                            'Ангилал нэр',
                            style: TextStyle(color: dark),
                          ),
                        ),
                      ),
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Ангилал нэр оруулна уу'),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        'Тайлбар',
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FormTextField(
                      textColor: networkColor,
                      name: 'description',
                      decoration: InputDecoration(
                        hintText: 'Тайлбар оруулах',
                        fillColor: white,
                        hintStyle: const TextStyle(color: networkColor),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Бүртгэсэн огноо, цаг',
                      style: TextStyle(color: dark),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()),
                      style: const TextStyle(
                        color: dark,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Бүртгэсэн ажилтан',
                      style: TextStyle(color: dark),
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: networkColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Статус',
                      style: TextStyle(color: dark),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: grey2.withOpacity(0.1),
                      ),
                      child: const Text(
                        'Түр төлөв',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 2.5),
                      child: CustomButton(
                        borderColor: networkColor,
                        labelColor: backgroundColor,
                        textColor: networkColor,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        labelText: "Буцах",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 2.5, right: 10),
                      child: CustomButton(
                        labelColor: networkColor,
                        labelText: 'Хадгалах',
                        onClick: () {
                          onSubmit();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
