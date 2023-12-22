import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business-staffs.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddZoningArguments {
  ListenController listenController;
  AddZoningArguments({
    required this.listenController,
  });
}

class AddZoning extends StatefulWidget {
  final ListenController listenController;
  static const routeName = "/AddZoning";
  const AddZoning({
    Key? key,
    required this.listenController,
  }) : super(key: key);

  @override
  State<AddZoning> createState() => _AddZoningState();
}

class _AddZoningState extends State<AddZoning> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  BusinessStaffs businessStaffs = BusinessStaffs();
  User user = User();
  bool isSubmit = false;

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        businessStaffs = BusinessStaffs.fromJson(fbKey.currentState!.value);
        businessStaffs.parentId = "";
        await BusinessApi().createDistributionArea(businessStaffs);
        await Provider.of<GeneralProvider>(context, listen: false)
            .businessInit(true);
        showCustomDialog(
          context,
          "Амжилттай бүс нэмлээ",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        widget.listenController.changeVariable("createZoning");
        Navigator.of(context).pop();
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        elevation: 0,
        leading: isSubmit == true
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset('assets/svg/close.svg'),
                ),
              ),
        title: Text(
          'Бүсчлэл',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isSubmit == true
          ? SizedBox()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүсийн код',
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
                          textColor: networkColor,
                          textAlign: TextAlign.end,
                          name: 'name',
                          inputType: TextInputType.text,
                          maxLenght: 255,
                          showCounter: false,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Text(
                                'Нэр',
                                style: TextStyle(color: dark),
                              ),
                            ),
                            fillColor: white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            hintStyle: TextStyle(color: networkColor),
                            hintText: 'Бүсийн нэр',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Бүсийн нэр оруулна уу'),
                          ]),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
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
                          inputType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            hintStyle: TextStyle(color: networkColor),
                            hintText: 'Тайлбар оруулна уу',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн огноо, цаг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
                          style: TextStyle(
                            color: dark,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${user.firstName}',
                          style: TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
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
                          child: Text(
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
                  SizedBox(
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
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
