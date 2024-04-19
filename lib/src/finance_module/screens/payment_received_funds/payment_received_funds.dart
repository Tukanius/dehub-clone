import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/finance_api.dart';
import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/finance.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/finance_module/sheets/bank_account_select.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class PaymentReceivedFundsArguments {
  Finance data;
  PaymentReceivedFundsArguments({
    required this.data,
  });
}

class PaymentReceivedFunds extends StatefulWidget {
  static const routeName = '/PaymentReceivedFunds';
  final Finance data;
  const PaymentReceivedFunds({
    super.key,
    required this.data,
  });

  @override
  State<PaymentReceivedFunds> createState() => _PaymentReceivedFundsState();
}

class _PaymentReceivedFundsState extends State<PaymentReceivedFunds>
    with AfterLayoutMixin {
  bool isLoading = true;
  String? amount;
  Finance finance = Finance();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  General general = General();

  @override
  afterFirstLayout(BuildContext context) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    await source.clearData();
    finance = widget.data;
    setState(() {
      isLoading = false;
    });
  }

  currency() {
    final res = general.currencies!
        .firstWhere((element) => element.code == widget.data.currency);
    return res;
  }

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        if (source.finance.account?.id != null) {
          loading.loading(true);
          await FinanceApi().lbfPay(
            Finance(
              amount: amount != null
                  ? double.parse(amount!)
                  : widget.data.invoice?.amountToPay,
              lbfAccount: finance.accountNumber,
              accountId: source.finance.account?.id,
            ),
            source.url,
          );
          loading.loading(false);
          showCustomDialog(context, 'Амжилттай төллөө', true, onPressed: () {
            Navigator.of(context).pop();
          });
        } else {
          showCustomDialog(context, "Төлбөр төлөх данс сонгоно уу", false);
        }
      } catch (e) {
        loading.loading(false);
      }
    }
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
          iconTheme: IconThemeData(color: source.currentColor),
          title: Text(
            'Зээл төлөх',
            style: TextStyle(
              color: source.currentColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: source.currentColor,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: const Text(
                          "Төлбөрийн мэдээлэл",
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectionField(
                              hintText: 'Дансны дугаар, дансны нэр',
                              labelText: "Төлбөр төлөх данс",
                              value: source.finance.account?.number != null
                                  ? "${source.finance.account?.number} / ${source.finance.account?.bankName}"
                                  : null,
                              onClick: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const BankAccountSelect(),
                                );
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text('Төлбөр төлөх дүн'),
                            ),
                            FormBuilder(
                              key: fbkey,
                              child: FormTextField(
                                inputType: TextInputType.number,
                                initialValue: Utils().formatCurrency(
                                    "${widget.data.payOffAmount}"),
                                name: 'a',
                                inputFormatters: [CurrencyInputFormatter()],
                                onChanged: (value) {
                                  setState(() {
                                    amount = Utils().parseCurrency(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  suffixText: currency().symbol,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Төлбөр төлөх дүн",
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
                                      errorText: 'Заавал оруулна'),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            borderColor: source.currentColor,
                            labelColor: white,
                            labelText: 'Буцах',
                            textColor: source.currentColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: CustomButton(
                            onClick: onSubmit,
                            labelColor: source.currentColor,
                            labelText: 'Төлбөр батлах',
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
