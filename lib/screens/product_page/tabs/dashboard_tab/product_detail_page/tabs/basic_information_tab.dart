import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/dialog_manager/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/inventory_goods.dart';
import 'package:dehub/api/inventory_api.dart';

class BasicInformationTabArguments {
  String id;
  BasicInformationTabArguments({
    required this.id,
  });
}

class BasicInformationTab extends StatefulWidget {
  final String id;
  const BasicInformationTab({
    super.key,
    required this.id,
  });

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab>
    with AfterLayoutMixin {
  InventoryGoods inventory = InventoryGoods();
  bool isLoading = false;

  @override
  afterFirstLayout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    inventory = await InventoryApi().goodsGet(widget.id);
    print('======inventory========');
    print(inventory.brand?.toJson());
    print('======inventory========');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Үндсэн мэдээлэл',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'DeHUB код',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        'Авто гарах',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Бүртгэлийн статус',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xffAAB8C2).withOpacity(0.3),
                          border: Border.all(
                            color: grey2.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${inventory.itemStatus}',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SKU код',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.skuCode}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Barcode',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.barCode}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ERP code',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.erpCode}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нэр /Монгол хэл/',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${inventory.nameMon}',
                          style: TextStyle(color: grey2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нэр /Англи хэл/',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${inventory.nameEng}',
                          style: TextStyle(color: grey2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Падаанд гарах нэр',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${inventory.nameBill}',
                          style: TextStyle(color: grey2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Вевд гарах нэр',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${inventory.nameWeb}',
                          style: TextStyle(color: grey2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Апп-д гарах нэр:',
                        style: TextStyle(color: grey2),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${inventory.nameApp}',
                          style: TextStyle(color: grey2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Гарал үүсэл',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Брэнд',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.brand?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нийлүүлэгч',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.supplier?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Үйлдвэрлэгч',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.manufacturer?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Үйлдвэрлэгч улс',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.originCountry?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Импортлогч улс',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.importerCountry?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дистрибютор',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.distributor?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Нэр төрөл',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.itemType?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ангилал',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.classification?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Дэд ангилал',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.subClassification?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Категори',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.category?.name}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Таг',
                        style: TextStyle(color: grey2),
                      ),
                      Text(
                        '${inventory.tag?.text}',
                        style: TextStyle(color: grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    child: Text('${inventory.description}'),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    image: AssetImage('images/map.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Нэмэлт зураг',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                inventory.detailImages != null
                    ? Container(
                        height: 200,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: inventory.detailImages!
                              .map(
                                (e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  height: 200,
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
                                          context: context,
                                          builder: (context) {
                                            return ImageDialog(link: e);
                                          });
                                    },
                                    child: Image(
                                      image: NetworkImage('${e}'),
                                      fit: BoxFit.cover,
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
