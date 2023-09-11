import 'package:dehub/components/chat_card/chat_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/screens/product_give/product_give.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryPageArguments {
  Order data;
  DeliveryPageArguments({
    required this.data,
  });
}

class DeliveryPage extends StatefulWidget {
  final Order data;
  static const routeName = '/DeliveryPage';
  const DeliveryPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  List<String> chat = [];
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void scrollToBottom() {}

  void sendMessage() {
    setState(() {
      if (chatController.text != '') {
        chat.add(chatController.text);
        chatController.text = '';
      }
    });
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Захиалга хүргэлт',
          style: TextStyle(
            color: buttonColor,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.data.receiverBusiness?.profileName}',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.data.receiverBusiness?.partner?.businessName}',
                                  style: TextStyle(
                                    color: saaral,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: orderColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'images/map.svg',
                                  color: white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: orderColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'images/call.svg',
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.data.staff?.firstName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Худалдагч',
                                  style: TextStyle(
                                    color: saaral,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/inv.svg',
                                  color: darkGreen,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'PO-234343',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orderColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Захиалсан: 2021-11-30',
                              style: TextStyle(
                                color: depBrown,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 125,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [1, 2, 3]
                                .map(
                                  (e) => Stack(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        height: 125,
                                        width: 185,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: AssetImage('images/map.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: pink.withOpacity(0.1),
                                          ),
                                          child: Text(
                                            '3 ш',
                                            style: TextStyle(
                                              color: pink,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Талын монгол:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Банш 5кг, ууттай - 3 ширхэг, Багц хоол - 3ш, Бууз 12ш, Бантангийн мах - 12 хайрцаг',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Талын монгол:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Банш 5кг, ууттай - 3 ширхэг, Багц хоол - 3ш, Бууз 12ш, Бантангийн мах - 12 хайрцаг',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Нийт дүн',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '115,000₮',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Text(
                            'Харилцааны түүх',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: chat.length,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              chat: chat[index],
                              isOwnChat: chat[index] == "asdf" ? false : true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: FormTextField(
                          onComplete: () {
                            sendMessage();
                          },
                          controller: chatController,
                          name: 'chat',
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            filled: true,
                            hintText: 'Энд харилцана уу',
                            fillColor: lightGrey,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            isDense: false,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: orderColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset('images/send_chat.svg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: transparent,
                          child: Column(
                            children: [
                              SvgPicture.asset('images/list_detail.svg'),
                              Text(
                                'Дэлгэрэнгүй',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProductGive.routeName);
                        },
                        child: Container(
                          color: transparent,
                          child: Column(
                            children: [
                              Icon(
                                Icons.fire_truck_rounded,
                                color: white,
                                size: 24,
                              ),
                              Text(
                                'Бараа олгох',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
