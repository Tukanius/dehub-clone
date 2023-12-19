import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/dialog_manager/image_dialog.dart';
import 'package:flutter/material.dart';

class BasicInformationTab extends StatefulWidget {
  final InventoryGoods data;
  const BasicInformationTab({
    super.key,
    required this.data,
  });

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab> {
  itemStatus() {
    switch (widget.data.itemStatus) {
      case 'ACTIVE':
        return "Идэвхитэй";
      case 'INACTIVE':
        return "Идэвхигүй";
      case 'DRAFT':
        return "Түр төлөв";
      case 'REGISTERED':
        return "Бүртгэсэн";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Үндсэн мэдээлэл',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'DeHUB код',
            secondText: 'Авто гарах',
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бүртгэлийн статус',
                  style: TextStyle(color: grey2),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xffAAB8C2).withOpacity(0.3),
                    border: Border.all(
                      color: grey2.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    itemStatus().toString(),
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'SKU код',
            secondText: '${widget.data.skuCode}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Barcode',
            secondText: '${widget.data.barCode}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'ERP code',
            secondText: '${widget.data.erpCode}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Нэр /Монгол хэл/',
            secondText: '${widget.data.nameMon}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Нэр /Англи хэл/',
            secondText: '${widget.data.nameEng}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Падаанд гарах нэр',
            secondText: '${widget.data.nameBill}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Вебд гарах нэр',
            secondText: '${widget.data.nameWeb}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Апп-д гарах нэр:',
            secondText: '${widget.data.nameApp}',
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Гарал үүсэл',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Брэнд',
            secondText: '${widget.data.brand?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Нийлүүлэгч',
            secondText: '${widget.data.supplier?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Үйлдвэрлэгч',
            secondText: '${widget.data.manufacturer?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Үйлдвэрлэгч улс',
            secondText: '${widget.data.originCountry}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Импортлогч улс',
            secondText: '${widget.data.importerCountry}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Дистрибютор',
            secondText: '${widget.data.distributor?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Нэр төрөл',
            secondText: '${widget.data.itemType?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Ангилал',
            secondText: '${widget.data.classification?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Дэд ангилал',
            secondText: '${widget.data.subClassification?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Категори',
            secondText: '${widget.data.category?.name}',
          ),
          FieldCard(
            paddingHorizontal: 15,
            paddingVertical: 10,
            color: white,
            secondTextColor: grey2,
            labelTextColor: grey2,
            labelText: 'Таг',
            secondText: '${widget.data.tag?.text}',
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Тайлбар',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: white,
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: grey2.withOpacity(0.3),
                ),
              ),
              child: Text('${widget.data.description}'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Нүүрэнд гарах зураг',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: white,
            child: Image(
              image: NetworkImage('${widget.data.image}'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Нэмэлт зураг',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          widget.data.detailImages != null
              ? Container(
                  height: 200,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: widget.data.detailImages!
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 5),
                            height: 200,
                            width: 330,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return ImageDialog(link: e);
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage('${e}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
