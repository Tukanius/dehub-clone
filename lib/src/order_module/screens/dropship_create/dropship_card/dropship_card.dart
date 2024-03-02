import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class DropshipCard extends StatefulWidget {
  final Order data;
  const DropshipCard({
    super.key,
    required this.data,
  });

  @override
  State<DropshipCard> createState() => DropshipCardState();
}

class DropshipCardState extends State<DropshipCard> {
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
}
