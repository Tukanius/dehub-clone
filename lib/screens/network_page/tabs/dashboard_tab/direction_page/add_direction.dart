import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/business-staffs.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';

class AddDirectionArguments {
  ListenController listenController;
  AddDirectionArguments({
    required this.listenController,
  });
}

class AddDirection extends StatefulWidget {
  final ListenController listenController;
  static const routeName = '/AddDirection';
  const AddDirection({
    Key? key,
    required this.listenController,
  }) : super(key: key);

  @override
  State<AddDirection> createState() => _AddDirectionState();
}

class _AddDirectionState extends State<AddDirection> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isSwitch = false;
  String? selectedValue;
  String? refcode;
  int page = 1;
  int limit = 10;
  Result distributionArea = Result(count: 0, rows: []);
  bool isLoading = true;

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(isParent: true);
    var res = await BusinessApi()
        .distributionAreaList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      distributionArea = res;
      isLoading = false;
    });
  }

  @override
  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        BusinessStaffs businessStaffs =
            BusinessStaffs.fromJson(fbKey.currentState!.value);
        businessStaffs.parentId = selectedValue;
        await BusinessApi().createDistributionArea(businessStaffs);
        widget.listenController.changeVariable('createDirection');
        Navigator.of(context).pop();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: networkColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset('images/close.svg'),
          ),
        ),
        title: Text(
          'Чиглэл',
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Чиглэлийн код',
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      textColor: networkColor,
                      textAlign: TextAlign.end,
                      name: 'name',
                      inputType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Text(
                            'Чиглэлийн нэр',
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
                    distributionArea.rows!.isEmpty
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
                            items: distributionArea.rows!
                                .map(
                                  (item) => DropdownMenuItem(
                                    onTap: () {
                                      selectedValue = item.id;
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
                            'Бүсийн код',
                            style: TextStyle(color: dark),
                          ),
                          refcode == null
                              ? Text(
                                  'Авто гарах',
                                  style: TextStyle(
                                    color: networkColor,
                                  ),
                                )
                              : Text(
                                  '${refcode}',
                                  style: TextStyle(color: networkColor),
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
                    Container(
                      color: white,
                      child: Column(
                        children: [
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
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
                              onClick: () {},
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
          textAlign: TextAlign.center,
        ),
      );
}
