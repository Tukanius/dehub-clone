import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business_staffs.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';

class AddRankArguments {
  String? parentName;
  String? parentRefCode;
  String? parentId;
  ListenController listenController;
  AddRankArguments({
    this.parentRefCode,
    this.parentName,
    this.parentId,
    required this.listenController,
  });
}

class AddRank extends StatefulWidget {
  static const routeName = '/AddRank';
  final ListenController listenController;
  final String? parentName;
  final String? parentRefCode;
  final String? parentId;
  const AddRank({
    super.key,
    this.parentRefCode,
    this.parentName,
    this.parentId,
    required this.listenController,
  });

  @override
  State<AddRank> createState() => _AddRankState();
}

class _AddRankState extends State<AddRank> with AfterLayoutMixin {
  bool isSwitch = false;
  int page = 1;
  int limit = 10;
  General general = General();
  Result reference = Result(count: 0, rows: []);
  String? parentId;
  bool isLoading = true;
  String? refcode;
  User user = User();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  @override
  afterFirstLayout(BuildContext context) {
    if (widget.parentId == null) {
      clientClassificationList(page, limit);
    } else {
      setState(() {
        parentId = widget.parentId;
        refcode = widget.parentRefCode;
      });
    }
  }

  clientClassificationList(page, limit) async {
    Offset offset = Offset(limit: limit, page: page);
    Filter filter = Filter(isParent: true);
    reference = await BusinessApi().clientClassificationList(
      ResultArguments(offset: offset, filter: filter),
    );
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        BusinessStaffs businessStaffs =
            BusinessStaffs.fromJson(fbKey.currentState!.value);
        if (widget.parentId == null) {
          businessStaffs.parentId = parentId;
        } else {
          businessStaffs.parentId = widget.parentId;
        }
        await BusinessApi().createClientClassification(businessStaffs);
        await Provider.of<GeneralProvider>(context, listen: false)
            .businessInit(false);
        loading.loading(false);
        widget.listenController.changeVariable('createRank');
        Navigator.of(context).pop();
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
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
          leading: const CustomCloseButton(),
          title: const Text(
            'Харилцагчийн зэрэглэл',
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: networkColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: const Text(
                        'Мэдээлэл',
                        style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    widget.parentId != null
                        ? FieldCard(
                            paddingHorizontal: 15,
                            paddingVertical: 15,
                            labelText: "Ангилал нэр",
                            secondText: widget.parentName,
                            color: white,
                            secondTextColor: networkColor,
                          )
                        : reference.rows!.isEmpty
                            ? Container(
                                color: white,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15),
                                child: const Text(
                                  'Ангилал сонгоно уу',
                                  style: TextStyle(color: red),
                                ),
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
                                  child: const Row(
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
                                onChanged: (value) {},
                                dropdownColor: white,
                                elevation: 2,
                                decoration: const InputDecoration(
                                  hintText: 'Ангилал нэр',
                                  hintStyle:
                                      TextStyle(fontSize: 14, color: dark),
                                  filled: true,
                                  fillColor: white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: reference.rows!
                                    .map(
                                      (item) => DropdownMenuItem(
                                        onTap: () {
                                          setState(() {
                                            parentId = item.id;
                                            refcode = item.refCode;
                                          });
                                        },
                                        value: item,
                                        child: Text(
                                          '${item.name}',
                                          style: const TextStyle(
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
                          const Text(
                            'Ангилал код',
                            style: TextStyle(color: dark),
                          ),
                          refcode == null
                              ? const Text(
                                  'Ангилал код',
                                  style: TextStyle(color: networkColor),
                                )
                              : Text(
                                  '$refcode',
                                  style: const TextStyle(
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
                      child: const Row(
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Бүртгэсэн огноо, цаг',
                            style: TextStyle(color: dark),
                          ),
                          Text(
                            DateFormat("yyyy-MM-dd").format(DateTime.now()),
                            style: const TextStyle(
                              color: dark,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Бүртгэсэн ажилтан',
                            style: TextStyle(color: dark),
                          ),
                          Text(
                            '${user.firstName}',
                            style: const TextStyle(
                              color: networkColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Статус',
                            style: TextStyle(color: dark),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            color: networkColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.end,
        ),
      );
}
