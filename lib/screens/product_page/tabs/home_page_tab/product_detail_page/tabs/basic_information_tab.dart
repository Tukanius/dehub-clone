import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BasicInformationTab extends StatefulWidget {
  const BasicInformationTab({super.key});

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab> {
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
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    'Түр төлөв',
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SKU код',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'SKU код',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Barcode',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Barcode',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ERP code',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'ERP code',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэр /Монгол хэл/',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэр /Англи хэл/',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Падаанд гарах нэр',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Вевд гарах нэр',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Апп-д гарах нэр',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
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
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Брэнд',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Брэнд нэр',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нийлүүлэгч',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нийлүүлэгч',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Үйлдвэрлэгч',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Үйлдвэрлэгч',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Үйлдвэрлэгч улс',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Үйлдвэрлэгч улс',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Импортлогч улс',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Импортлогч улс',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дистрибютор',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Дистрибютор',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Нэр төрөл',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Нэр төрөл',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ангилал',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Ангилал',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дэд ангилал',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Дэд ангилал',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Категори',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Категори',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Таг',
                  style: TextStyle(color: grey2),
                ),
                Text(
                  'Таг',
                  style: TextStyle(color: grey2),
                ),
              ],
            ),
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
            height: 125,
            color: white,
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: grey2.withOpacity(0.3),
                ),
              ),
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
              image: AssetImage('images/map.jpg'),
              fit: BoxFit.fitHeight,
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
          Container(
            height: 200,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  color: white,
                  child: Image(
                    image: AssetImage('images/map.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  color: white,
                  child: Image(
                    image: AssetImage('images/map.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
