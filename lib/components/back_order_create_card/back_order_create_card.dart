import 'package:dehub/api/order_api.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class BackorderCreateCard extends StatefulWidget {
  final Order data;
  const BackorderCreateCard({
    super.key,
    required this.data,
  });

  @override
  State<BackorderCreateCard> createState() => _BackorderCardState();
}

class _BackorderCardState extends State<BackorderCreateCard> {
  Result branches = Result(rows: []);
  Result staffs = Result(rows: []);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(bottom: 2),
      color: white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: grey2,
                  image: DecorationImage(
                    image: NetworkImage(
                      "${widget.data.image}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.data.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${widget.data.skuCode}',
                    style: const TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Хэмжих нэгж: ${widget.data.baseUnit}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Нийт тоо: ${widget.data.quantity}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Qty_Available_Sale: ${widget.data.availableQuantity}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Үлдэгдэл: ${widget.data.minQuantity}',
                  style: const TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  onChanged: (p0) {
                    setState(() {
                      widget.data.quantity = int.tryParse(p0) ?? 0;
                    });
                  },
                  inputType: TextInputType.number,
                  fontSize: 12,
                  name: widget.data.id,
                  decoration: InputDecoration(
                    hintText: 'Тоо хэмжээ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey2.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey2.withOpacity(0.3),
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    isDense: true,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                  ]),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectSupplier();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey2.withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.data.supplierBusiness == null
                          ? 'Нийлүүлэгч'
                          : widget.data.supplierBusiness!.profileName
                              .toString(),
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectBuyer();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey2.withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.data.buyerBusiness == null
                          ? 'Ху.авагч'
                          : widget.data.buyerBusiness!.profileName.toString(),
                      style: const TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (branches.rows!.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectBranch();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey2.withOpacity(0.3)),
                      ),
                      child: Text(
                        widget.data.receiverBranch == null
                            ? 'Салбар'
                            : widget.data.receiverBranch!.name.toString(),
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectStaff();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey2.withOpacity(0.3)),
                      ),
                      child: Text(
                        widget.data.receiverStaff == null
                            ? 'Ажилтан'
                            : "${widget.data.receiverStaff?.lastName?[0]}. ${widget.data.receiverStaff?.firstName}",
                        style: const TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  selectBuyer() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: widget.data.buyers!
                  .map(
                    (e) => InkWell(
                      onTap: () async {
                        setState(() {
                          widget.data.buyerBusiness = e;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.profileName} / ${e.refCode}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  selectSupplier() {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: widget.data.suppliers!
                  .map(
                    (e) => InkWell(
                      onTap: () async {
                        setState(() {
                          widget.data.supplierBusiness = e;
                        });
                        try {
                          loading.loading(true);
                          branches = await OrderApi().branchSelect(e.id);
                          staffs = await OrderApi().staffSelect(e.id!);
                          setState(() {});
                          loading.loading(false);
                        } catch (e) {
                          loading.loading(false);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.profileName} / ${e.refCode}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  selectBranch() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: branches.rows!
                  .map(
                    (e) => InkWell(
                      onTap: () async {
                        setState(() {
                          widget.data.receiverBranch = e;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.name} / ${e.refCode}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  selectStaff() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: staffs.rows!
                  .map(
                    (e) => InkWell(
                      onTap: () async {
                        setState(() {
                          widget.data.receiverStaff = e;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text('${e.lastName[0]}. ${e.firstName}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
