import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/full_picture/full_picture.dart';
import 'package:dehub/src/order_module/components/chat_card/chat_card.dart';
import 'package:dehub/components/refresher/refresher.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

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
    super.key,
    required this.data,
  });

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> with AfterLayoutMixin {
  bool isLoading = true;
  User user = User();
  TextEditingController chatController = TextEditingController();
  Result conversations = Result(count: 0, rows: []);
  RefreshController refreshController = RefreshController();
  Order get = Order();
  int limit = 10;

  @override
  afterFirstLayout(BuildContext context) async {
    conversations =
        await OrderApi().conversationList('${widget.data.id}', limit);
    get = await OrderApi().deliveryNoteGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  void onLoading() async {
    setState(() {
      limit += 10;
    });
    conversations =
        await OrderApi().conversationList('${widget.data.id}', limit);
    refreshController.loadComplete();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    conversations =
        await OrderApi().conversationList('${widget.data.id}', limit);
    refreshController.refreshCompleted();
  }

  void sendChat() async {
    Order chat = Order();
    if (chatController.text.isNotEmpty) {
      try {
        chat.text = chatController.text;
        chat.deliveryNoteId = widget.data.id;
        chat.image = '';
        setState(() {
          conversations.rows?.add(Order(
            text: chatController.text,
            createdAt: DateTime.now(),
            user: Order(
              id: user.id,
              avatar: user.avatar,
              lastName: user.lastName,
              firstName: user.firstName,
            ),
          ));
        });
        // await OrderApi().createConversation(chat);
        // await OrderApi().conversationList('${widget.data.id}', limit);
        setState(() {
          chatController.text = '';
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      try {
        chat.text = '👋';
        chat.deliveryNoteId = widget.data.id;
        chat.image = '';
        setState(() {
          conversations.rows?.add(Order(
            text: chatController.text,
            createdAt: DateTime.now(),
            user: Order(
              id: user.id,
              avatar: user.avatar,
              lastName: user.lastName,
              firstName: user.firstName,
            ),
          ));
        });
        // await OrderApi().createConversation(chat);
        // await OrderApi().conversationList('${widget.data.id}', limit);
        setState(() {
          chatController.text = '';
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void phoneCall() async {
    final Uri phoneLaunch =
        Uri(scheme: 'tel', path: "${get.buyerBusiness?.partner?.phone}");
    if (await canLaunchUrl(phoneLaunch)) {
      await launchUrl(phoneLaunch);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: orderColor),
          centerTitle: true,
          title: const Text(
            'Захиалга хүргэлт',
            style: TextStyle(
              color: buttonColor,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: orderColor,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Refresher(
                      refreshController: refreshController,
                      onLoading:
                          conversations.rows!.length == conversations.count
                              ? null
                              : onLoading,
                      onRefresh: onRefresh,
                      color: orderColor,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: white,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: grey,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                user.currentBusiness?.type ==
                                                        "SUPPLIER"
                                                    ? '${get.buyerBusiness?.logo}'
                                                    : "${get.supplierBusiness?.logo}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: user.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${get.buyerBusiness?.profileName}',
                                                      style: const TextStyle(
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${get.buyerBusiness?.partner?.businessName}',
                                                      style: const TextStyle(
                                                        color: saaral,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${get.supplierBusiness?.profileName}',
                                                      style: const TextStyle(
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${get.supplierBusiness?.partner?.businessName}',
                                                      style: const TextStyle(
                                                        color: saaral,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      phoneCall();
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: orderColor,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/svg/call.svg',
                                          colorFilter: const ColorFilter.mode(
                                              white, BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
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
                                      get.staff?.avatar != null
                                          ? CircleAvatar(
                                              radius: 18,
                                              backgroundColor: grey,
                                              backgroundImage: NetworkImage(
                                                  '${get.staff?.avatar}'),
                                            )
                                          : const CircleAvatar(
                                              radius: 18,
                                              backgroundColor: grey,
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${get.staff?.firstName}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'Худалдагч',
                                            style: TextStyle(
                                              color: saaral,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/inv.svg',
                                            colorFilter: const ColorFilter.mode(
                                                darkGreen, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${widget.data.refCode}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: orderColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Захиалсан: ${DateFormat('yyyy-MM-dd').format(get.createdAt!)}',
                                        style: const TextStyle(
                                          color: depBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 125,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: get.lines!.map((item) {
                                        List<String> images = [];
                                        for (var data in get.lines!) {
                                          images.add(data.image!);
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              FullPicture.routeName,
                                              arguments: FullPictureArguments(
                                                pictures: images,
                                                initialPage:
                                                    get.lines!.indexOf(item),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                height: 125,
                                                width: 185,
                                                decoration: BoxDecoration(
                                                  color: lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      '${item.image}',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 10,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 7,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        const Color(0xfffdf4f6),
                                                  ),
                                                  child: Text(
                                                    '${item.quantity} ${item.unit![0]}'
                                                        .toLowerCase(),
                                                    style: const TextStyle(
                                                      color: pink,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: get.lines!
                                        .map(
                                          (item) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          color: grey3,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "${item.name} ",
                                                          ),
                                                          item.optionValue !=
                                                                  null
                                                              ? TextSpan(
                                                                  text:
                                                                      "${item.optionValue}")
                                                              : const TextSpan(),
                                                          item.optionValue !=
                                                                  null
                                                              ? const TextSpan(
                                                                  text: " - ")
                                                              : const TextSpan(),
                                                          TextSpan(
                                                              text:
                                                                  "${item.quantity} "),
                                                          TextSpan(
                                                              text:
                                                                  "${item.baseUnit?.toLowerCase()} "),
                                                        ],
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
                                        )
                                        .toList(),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Нийт дүн',
                                        style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '${Utils().formatCurrency(get.lines?.map((e) => e.totalAmount).reduce((value, element) => value! + element!).toString())}₮',
                                        style: const TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (conversations.rows!.isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, bottom: 5),
                                      child: const Text(
                                        'Харилцааны түүх',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  Column(
                                    children: conversations.rows!.reversed
                                        .map(
                                          (data) => ChatCard(
                                            isOwnChat: user.id == data.user.id,
                                            data: data,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (get.deliveryNoteStatus != "DELIVERED")
                    Container(
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: FormTextField(
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    controller: chatController,
                                    name: 'chat',
                                    inputType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
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
                                  sendChat();
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
                                    child: chatController.text.isNotEmpty
                                        ? SvgPicture.asset(
                                            'assets/svg/send_chat.svg')
                                        : const Text(
                                            '👋',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                  ),
                                ),
                              ),
                            ],
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
