import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RankDetailPageArguments {
  String id;
  RankDetailPageArguments({
    required this.id,
  });
}

class RankDetailPage extends StatefulWidget {
  final String id;
  static const routeName = '/RankDetailPage';
  const RankDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<RankDetailPage> createState() => _RankDetailPageState();
}

class _RankDetailPageState extends State<RankDetailPage> with AfterLayoutMixin {
  ReferenceInformationGet get = ReferenceInformationGet();
  bool isLoading = true;
  General general = General();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  @override
  afterFirstLayout(BuildContext context) async {
    get = await BusinessApi().clientClassificationGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  parent() {
    final res = general.clientClassifications!
        .firstWhere((element) => element.id == get.parentId);
    return res;
  }

  staff() {
    final res =
        general.staffs!.firstWhere((element) => element.id == get.regUserId);
    return res;
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        Business data = Business.fromJson(fbkey.currentState!.value);
        await BusinessApi().clientClassificationUpdate(get.id!, data);
        get = await BusinessApi().clientClassificationGet(widget.id);
        setState(() {});
        Navigator.of(context).pop();
        loading.loading(false);
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Зэрэглэл нэр, код',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
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
                      'Тохиргоо',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    color: white,
                    labelText: 'Ангилал код',
                    labelTextColor: dark,
                    secondText: parent().refCode,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    color: white,
                    labelText: 'Нэр',
                    labelTextColor: dark,
                    secondText: parent().name,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    color: white,
                    labelText: 'Зэрэглэл код',
                    labelTextColor: dark,
                    secondText: get.refCode,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    color: white,
                    labelText: 'Зэрэглэл',
                    labelTextColor: dark,
                    secondText: get.name,
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    color: white,
                    labelText: 'Тайлбар',
                    labelTextColor: dark,
                    secondText: get.description,
                    secondTextColor: networkColor,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Системийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
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
                          '${staff().firstName}',
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
                          'Бүртгэсэн огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(get.createdAt!),
                          style: const TextStyle(
                            color: networkColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      update();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: transparent,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Засах',
                            style: TextStyle(
                              color: networkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            'assets/svg/edit_rounded.svg',
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

  update() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: backgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: fbkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Нэр'),
                      ),
                      FormTextField(
                        name: 'name',
                        decoration: const InputDecoration(
                          fillColor: white,
                          filled: true,
                          border: InputBorder.none,
                        ),
                        initialValue: get.name,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Тайлбар'),
                      ),
                      FormTextField(
                        name: 'description',
                        decoration: const InputDecoration(
                          fillColor: white,
                          filled: true,
                          border: InputBorder.none,
                        ),
                        initialValue: get.description,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomButton(
                      onClick: () {
                        Navigator.pop(context);
                      },
                      labelColor: white,
                      textColor: networkColor,
                      borderColor: networkColor,
                      labelText: 'Болих',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      onClick: onSubmit,
                      labelColor: networkColor,
                      labelText: 'Засах',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
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
