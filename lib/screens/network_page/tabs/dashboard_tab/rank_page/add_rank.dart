import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AddRankArguments {
  ListenController listenController;
  AddRankArguments({
    required this.listenController,
  });
}

class AddRank extends StatefulWidget {
  static const routeName = '/AddRank';
  final ListenController listenController;
  const AddRank({
    Key? key,
    required this.listenController,
  }) : super(key: key);

  @override
  State<AddRank> createState() => _AddRankState();
}

class _AddRankState extends State<AddRank> {
  bool isSwitch = false;
  General general = General();
  String? parentId;
  String? refcode;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        BusinessStaffs businessStaffs =
            BusinessStaffs.fromJson(fbKey.currentState!.value);
        businessStaffs.parentId = parentId;
        await BusinessApi().createClientClassification(businessStaffs);
        widget.listenController.changeVariable('createRank');
        Navigator.of(context).pop();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    print(general.toJson());
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: networkColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset('images/close.svg'),
          ),
        ),
        title: Text(
          'Харилцагчийн зэрэглэл',
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
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Зэрэглэл код',
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
                      hintText: 'Зэрэглэл нэр оруулах',
                      fillColor: white,
                      hintStyle: TextStyle(color: networkColor),
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
                        child: Text(
                          'Зэрэглэл нэр',
                          style: TextStyle(color: dark),
                        ),
                      ),
                    ),
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Ангилал нэр оруулна уу'),
                    ]),
                  ),
                  general.clientClassifications == []
                      ? Container(
                          color: white,
                          padding: const EdgeInsets.all(15),
                          child: Text('Бүсчлэл сонгоно уу'),
                        )
                      : DropdownButtonFormField(
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Заавал оруулна уу.')
                          ]),
                          icon: Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Сонгох',
                                  style: TextStyle(
                                      color: networkColor, fontSize: 14),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: dark,
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          dropdownColor: white,
                          elevation: 2,
                          decoration: InputDecoration(
                            hintText: 'Бүсийн нэр',
                            hintStyle: TextStyle(fontSize: 14, color: dark),
                            filled: true,
                            fillColor: white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: general.clientClassifications!
                              .map(
                                (item) => DropdownMenuItem(
                                  onTap: () {
                                    parentId = item.id;
                                    refcode = item.refCode;
                                  },
                                  value: item,
                                  child: Text(
                                    '${item.name}',
                                    style: TextStyle(
                                      color: dark,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ангилал код',
                          style: TextStyle(color: dark),
                        ),
                        refcode == null
                            ? Text(
                                'Ангилал код',
                                style: TextStyle(color: networkColor),
                              )
                            : Text(
                                '${refcode}',
                                style: TextStyle(
                                  color: networkColor,
                                ),
                              )
                      ],
                    ),
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
                    decoration: InputDecoration(
                      hintText: 'Тайлбар оруулах',
                      fillColor: white,
                      hintStyle: TextStyle(color: networkColor),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүртгэсэн огноо, цаг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '2023-04-08 16:24 PM',
                    style: TextStyle(
                      color: dark,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Статус',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: networkColor),
                    ),
                    child: CustomButton(
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: networkColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.end,
        ),
      );
}
