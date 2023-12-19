import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: true);
    return Container(
      color: white,
      child: Column(
        children: [
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.skuCode = value;
              });
            },
            initialValue: source.product.skuCode,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'skuCode',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'SKU код',
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
                errorText: 'SKU код оруулна уу',
              ),
            ]),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.barCode = value;
              });
            },
            initialValue: source.product.barCode,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'barCode',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Бар код',
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
                errorText: 'Бар код оруулна уу',
              ),
            ]),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.erpCode = value;
              });
            },
            initialValue: source.product.erpCode,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'erpCode',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'ERP код',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.nameMon = value;
              });
            },
            initialValue: source.product.nameMon,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'nameMon',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Барааны нэр (Монгол)',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            validator: FormBuilderValidators.compose([
              (value) {
                return validateCryllic(value.toString(), context);
              }
            ]),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.name = value;
              });
            },
            initialValue: source.product.name,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'nameEng',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Англи/Латин нэр',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.padName = value;
              });
            },
            initialValue: source.product.padName,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'asdf',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Падааны нэр',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.nameApp = value;
              });
            },
            initialValue: source.product.nameApp,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'nameApp',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Апп-д гарах нэр',
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
                errorText: 'Нэр оруулна уу',
              ),
            ]),
          ),
          FormTextField(
            onChanged: (value) {
              setState(() {
                source.product.nameWeb = value;
              });
            },
            initialValue: source.product.nameWeb,
            textColor: productColor,
            textAlign: TextAlign.end,
            name: 'nameWeb',
            decoration: InputDecoration(
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
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Веб-д гарах нэр',
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
                errorText: 'Нэр оруулна уу',
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

String? validateCryllic(String value, context) {
  RegExp isValidName = RegExp(r'(^[а-яА-ЯӨөҮүЁёӨө -]+$)');
  if (value == '') {
    return "Нэр оруулна уу";
  } else {
    if (!isValidName.hasMatch(value)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}
