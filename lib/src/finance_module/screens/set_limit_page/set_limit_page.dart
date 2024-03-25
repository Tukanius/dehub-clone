import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/finance_module/components/buyer_proposal_card/buyer_proposal_card.dart';
import 'package:dehub/src/finance_module/sheets/select_discount_type.dart';
import 'package:dehub/src/finance_module/sheets/select_penalty_type.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SetLimitPageArguments {
  List<Finance> data;
  SetLimitPageArguments({
    required this.data,
  });
}

class SetLimitPage extends StatefulWidget {
  static const routeName = '/SetLimitPage';
  final List<Finance> data;
  const SetLimitPage({
    super.key,
    required this.data,
  });

  @override
  State<SetLimitPage> createState() => _SetLimitPageState();
}

class _SetLimitPageState extends State<SetLimitPage> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  String? debtLimitAmount;
  String? discountPercent;
  String? penaltyPercent;
  String? weekAvgDebtAmount;
  String? halfMonthAvgDebtAmount;
  String? monthAvgDebtAmount;
  String? monthAvgPurchaseAmount;
  String? monthAvgRefundAmount;
  String? monthAvgBidAmount;
  bool discount = false;
  bool penalty = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  General general = General();

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        List<String> businessIds = [];
        Finance data = Finance.fromJson(fbkey.currentState!.value);
        for (var data in widget.data) {
          businessIds.add(data.id!);
        }
        data.businessIds = businessIds;
        data.debtLimitStartDate = startDate.toString();
        data.debtLimitEndDate = endDate.toString();
        data.earlyDiscount = discount;
        data.countPenalty = penalty;
        data.discountType = source.finance.discountType;
        data.penaltyType = source.finance.penaltyType;
        data.debtLimitAmount = double.parse(debtLimitAmount!);
        data.weekAvgDebtAmount = double.parse(weekAvgDebtAmount!);
        data.halfMonthAvgDebtAmount = double.parse(halfMonthAvgDebtAmount!);
        data.monthAvgDebtAmount = double.parse(monthAvgDebtAmount!);
        data.monthAvgPurchaseAmount = double.parse(monthAvgPurchaseAmount!);
        data.monthAvgRefundAmount = double.parse(monthAvgRefundAmount!);
        data.monthAvgBidAmount = double.parse(monthAvgBidAmount!);
        loading.loading(true);

        await FinanceApi().setLimit(source.url, data);
        loading.loading(false);
        showCustomDialog(context, "Амжилттай лимит тохирууллаа", true,
            onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  penaltyType() {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.finance.penaltyType != null) {
      final res = general.networkPenaltyTypes!
          .firstWhere((element) => element.code == source.finance.penaltyType);
      return res.name;
    } else {
      return null;
    }
  }

  discountType() {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    if (source.finance.discountType != null) {
      final res = general.networkDiscountTypes!
          .firstWhere((element) => element.code == source.finance.discountType);
      return res.name;
    } else {
      return null;
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    await source.clearData();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).financeGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          iconTheme: IconThemeData(color: source.currentColor),
          title: Text(
            'Лимит тохируулах',
            style: TextStyle(
              color: source.currentColor,
              fontSize: 17,
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
                  'Санхүүжүүлэхэд шаардлагатай мэдээлэл',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FormBuilder(
                  key: fbkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Авлагын лимит'),
                      ),
                      FormTextField(
                        name: "debtLimitAmount!",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            debtLimitAmount = Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн оруулна уу",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        inputFormatters: [CurrencyInputFormatter()],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      SelectionField(
                        labelText: "Лимит эхлэх огноо",
                        hintText: 'Огноо сонгоно уу',
                        onClick: () {
                          selectStartDate();
                        },
                        value: DateFormat('yyyy-MM-dd').format(startDate),
                      ),
                      SelectionField(
                        labelText: "Лимит дуусах огноо",
                        hintText: 'Огноо сонгоно уу',
                        onClick: () {
                          selectEndDate();
                        },
                        value: DateFormat('yyyy-MM-dd').format(endDate),
                      ),
                      Row(
                        children: [
                          const Text('Хугацаанаас өмнө хөнгөлдөг эсэх'),
                          Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                color: source.currentColor,
                                width: 2,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            activeColor: source.currentColor,
                            value: discount,
                            onChanged: (value) {
                              setState(() {
                                discount = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      if (discount)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text('Хөнгөлөлтийн хувь'),
                            ),
                            FormTextField(
                              name: "discountPercent",
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              maxLenght: 3,
                              showCounter: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Хувь оруулна уу",
                                hintStyle: const TextStyle(
                                  color: grey2,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: grey2.withOpacity(0.3),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна',
                                ),
                              ]),
                            ),
                            SelectionField(
                              labelText: "Хөнгөлөлт тооцдог арга",
                              hintText: 'Сонгоно уу',
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) =>
                                      const SelectDiscountType(),
                                );
                              },
                              value: discountType(),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          const Text('Хугацаанаас өмнө алданги тооцдог эсэх'),
                          Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                color: source.currentColor,
                                width: 2,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            activeColor: source.currentColor,
                            value: penalty,
                            onChanged: (value) {
                              setState(() {
                                penalty = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      if (penalty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text('Алдангийн хувь'),
                            ),
                            FormTextField(
                              name: "penaltyPercent",
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              maxLenght: 3,
                              showCounter: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                isDense: true,
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Хувь оруулна уу",
                                hintStyle: const TextStyle(
                                  color: grey2,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: grey2.withOpacity(0.3),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Заавал оруулна',
                                ),
                              ]),
                            ),
                            SelectionField(
                              labelText: "Алданги тооцдог арга",
                              hintText: 'Сонгоно уу',
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) =>
                                      const SelectPenaltyType(),
                                );
                              },
                              value: penaltyType(),
                            ),
                          ],
                        ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text(
                          'Түүхэнд үндэслэх оруулах',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Дундаж үлдэгдэл - 7 хоног'),
                      ),
                      FormTextField(
                        name: "weekAvgDebtAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            weekAvgDebtAmount = Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Дундаж үлдэгдэл - 2 д.хо'),
                      ),
                      FormTextField(
                        name: "halfMonthAvgDebtAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            halfMonthAvgDebtAmount =
                                Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Дундаж үлдэгдэл - Сар'),
                      ),
                      FormTextField(
                        name: "monthAvgDebtAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            monthAvgDebtAmount = Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Сарын дундаж татан авалт'),
                      ),
                      FormTextField(
                        name: "monthAvgPurchaseAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            monthAvgPurchaseAmount =
                                Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Сарын буцаалтын дундаж дүн'),
                      ),
                      FormTextField(
                        name: "monthAvgRefundAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            monthAvgRefundAmount = Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Заавал оруулна',
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text('Сарын дундаж орлого тушаалт'),
                      ),
                      FormTextField(
                        name: "monthAvgBidAmount!",
                        inputFormatters: [CurrencyInputFormatter()],
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            monthAvgBidAmount = Utils().parseCurrency(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Дүн",
                          hintStyle: const TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: grey2.withOpacity(0.3),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
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
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Сонгосон бизнесүүд',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: widget.data
                    .map(
                      (e) => BuyerProposalCard(selected: null, data: e),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      borderColor: grey2,
                      labelColor: white,
                      labelText: 'Болих',
                      textColor: buttonColor,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      labelColor: source.currentColor,
                      labelText: 'Баталгаажуулах',
                      textColor: white,
                      onClick: onSubmit,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
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

  selectStartDate() {
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
                      DateTime.now().subtract(const Duration(hours: 1)),
                  initialDateTime: startDate,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    if (newDate.difference(endDate).inDays > 0) {
                      setState(() {
                        endDate = newDate;
                      });
                    }
                    setState(() {
                      startDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  selectEndDate() {
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
                  minimumDate: startDate,
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
  }
}
