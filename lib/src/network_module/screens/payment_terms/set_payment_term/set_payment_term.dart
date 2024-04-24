import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SetPaymentTermArguments {
  String id;
  ListenController listenController;
  SetPaymentTermArguments({
    required this.listenController,
    required this.id,
  });
}

class SetPaymentTerm extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/SetPaymentTerm';
  const SetPaymentTerm({
    super.key,
    required this.id,
    required this.listenController,
  });

  @override
  State<SetPaymentTerm> createState() => _SetPaymentTermState();
}

class _SetPaymentTermState extends State<SetPaymentTerm> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? paymentTermId;
  String? paymentTerm;
  String? configTypeId;
  String? config;
  String? conditionName;
  String? conditionId;
  General general = General();
  bool isLoading = false;
  Result paymentTerms = Result(rows: [], count: 0);
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1));
  DateTime? expireDate;

  @override
  void initState() {
    startDate = DateTime.now();
    expireDate = DateTime.now();
    super.initState();
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await BusinessApi().setPaymentTerm(
        BusinessNetwork(
          businessIds: [widget.id],
          paymentTermId: paymentTermId,
          paymentTermStartDate: DateFormat("yyyy-MM-dd").format(startDate),
          paymentTermEndDate: DateFormat("yyyy-MM-dd").format(endDate),
        ),
      );
      widget.listenController.changeVariable('SetPaymentTerm');
      loading.loading(false);
      showCustomDialog(
        context,
        "Амжилттай хадгаллаа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  api(String condition, String configType) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      paymentTerms =
          await BusinessApi().paymentTermSelect(condition, configType);
      loading.loading(false);
    } catch (e) {
      loading.loading(false);
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
        automaticallyImplyLeading: false,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        title: const Text(
          'Төлбөрийн нөхцөл',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          CustomCloseButton(
            color: networkColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Төлбөрийн хэлбэр",
              onClick: () {
                condition();
              },
              arrowColor: networkColor,
              secondText: conditionName ?? '-',
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Төлбөр",
              onClick: () {
                configType();
              },
              arrowColor: networkColor,
              secondText: config ?? '-',
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Төлбөрийн нөхцөл",
              onClick: () {
                paymentTermSelect();
              },
              arrowColor: networkColor,
              secondText: paymentTerm ?? '-',
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Эхлэх хугацаа",
              onClick: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Болсон',
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              minimumDate:
                                  startDate.subtract(const Duration(hours: 1)),
                              maximumDate: endDate,
                              initialDateTime: startDate,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => startDate = newDate);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              secondText:
                  "${startDate.year} - ${startDate.month} - ${startDate.day}",
              arrowColor: networkColor,
              secondTextColor: networkColor,
              labelTextColor: buttonColor,
            ),
            FieldCard(
              arrowColor: networkColor,
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Дуусах хугацаа",
              onClick: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Болсон',
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              minimumDate:
                                  endDate.subtract(const Duration(hours: 1)),
                              initialDateTime: endDate,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => endDate = newDate);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              secondText: "${endDate.year} - ${endDate.month} - ${endDate.day}",
              secondTextColor: networkColor,
              labelTextColor: buttonColor,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              labelText: "Хадгалах",
              labelColor: paymentTerm == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              onClick: paymentTerm != null ? onSubmit : () {},
            ),
          ],
        ),
      ),
    );
  }

  condition() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Төлбөрийн хэлбэр сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: general.paymentTermConditions!
                      .where((element) => element.code != "AR_NET30")
                      .map(
                        (e) => GestureDetector(
                          onTap: () async {
                            setState(() {
                              conditionId = e.code;
                              conditionName = e.name;
                              paymentTerm = null;
                              paymentTermId = null;
                              config = null;
                              configTypeId = null;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Text(
                              '${e.name}',
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  configType() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Төлбөрийн хэлбэр сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: general.paymentTermConfigTypes!
                      .where((element) => element.condition == conditionId)
                      .map(
                        (e) => GestureDetector(
                          onTap: () async {
                            setState(() {
                              config = e.text;
                              configTypeId = e.code;
                              paymentTerm = null;
                              paymentTermId = null;
                            });
                            await api(conditionId!, e.code!);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Text(
                              '${e.text}',
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  paymentTermSelect() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Төлбөрийн нөхцөл сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: paymentTerms.rows!
                      .where((element) => element.code != "AR_NET30")
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              paymentTermId = e.id;
                              paymentTerm = e.description;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Text(
                              '${e.description}',
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
