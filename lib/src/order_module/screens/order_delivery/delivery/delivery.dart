import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/chat_card/chat_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

class _DeliveryPageState extends State<DeliveryPage> with AfterLayoutMixin {
  bool isLoading = true;
  User user = User();
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Result conversationList = Result(count: 0, rows: []);
  Order chat = Order();
  bool isSubmit = false;
  RefreshController refreshController = RefreshController();
  bool chatIsEmpty = true;
  Order get = Order();
  int limit = 10;

  @override
  afterFirstLayout(BuildContext context) async {
    conversationList =
        await OrderApi().conversationList('${widget.data.id}', limit);
    get = await OrderApi().deliveryNoteGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  void _onLoading() async {
    setState(() {
      limit += 10;
    });
    conversationList =
        await OrderApi().conversationList('${widget.data.id}', limit);
    refreshController.loadComplete();
    setState(() {
      isLoading = false;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
    });
    conversationList =
        await OrderApi().conversationList('${widget.data.id}', limit);
    refreshController.refreshCompleted();
    isLoading = false;
  }

  void sendChat() async {
    if (chatController.text.isNotEmpty) {
      setState(() async {
        try {
          // setState(() {
          //   isSubmit = true;
          // });
          chat.text = chatController.text;
          chat.deliveryNoteId = widget.data.id;
          chat.image = '';
          await OrderApi().createConversation(chat);
          conversationList =
              await OrderApi().conversationList('${widget.data.id}', 10);
          chatController.text = '';
          // setState(() {
          //   isSubmit = false;
          // });
        } catch (e) {
          debugPrint('============err===========');
          debugPrint(e.toString());
          debugPrint('============err===========');
        }
      });
      await Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 75,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else {
      try {
        setState(() {
          isSubmit = true;
        });
        chat.text = '👋';
        chat.deliveryNoteId = widget.data.id;
        chat.image = '';
        await OrderApi().createConversation(chat);
        conversationList =
            await OrderApi().conversationList('${widget.data.id}', 10);
        chatController.text = '';
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        debugPrint('============err===========');
        debugPrint(e.toString());
        debugPrint('============err===========');
      }
      await Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 75,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: orderColor,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: refreshController,
                      header: WaterDropHeader(
                        waterDropColor: orderColor,
                        refresh: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: orderColor,
                          ),
                        ),
                      ),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      footer: CustomFooter(
                        builder: (context, mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = const Text("");
                          } else if (mode == LoadStatus.loading) {
                            body = const CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = const Text("Алдаа гарлаа. Дахин үзнэ үү!");
                          } else {
                            body = const Text("Мэдээлэл алга байна");
                          }
                          return SizedBox(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      child: SingleChildScrollView(
                        reverse: false,
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: white,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      user.currentBusiness?.type == "SUPPLIER"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${get.buyerBusiness?.profileName}',
                                                  style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${get.buyerBusiness?.partner?.businessName}',
                                                  style: TextStyle(
                                                    color: saaral,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
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
                                                  style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${get.supplierBusiness?.partner?.businessName}',
                                                  style: TextStyle(
                                                    color: saaral,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
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
                                            'assets/svg/map.svg',
                                            colorFilter: ColorFilter.mode(
                                                white, BlendMode.srcIn),
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
                                            'assets/svg/call.svg',
                                            colorFilter: ColorFilter.mode(
                                                white, BlendMode.srcIn),
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
                                      get.staff?.avatar != null
                                          ? CircleAvatar(
                                              radius: 18,
                                              backgroundColor: grey,
                                              backgroundImage: NetworkImage(
                                                  '${get.staff?.avatar}'),
                                            )
                                          : CircleAvatar(
                                              radius: 18,
                                              backgroundColor: grey,
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${get.staff?.firstName}',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/inv.svg',
                                            colorFilter: ColorFilter.mode(
                                                darkGreen, BlendMode.srcIn),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${widget.data.refCode}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: orderColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Захиалсан: ${DateFormat('yyyy-MM-dd').format(get.createdAt!)}',
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
                                      children: get.lines!
                                          .map(
                                            (item) => Stack(
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                      color: Color(0xfffdf4f6),
                                                    ),
                                                    child: Text(
                                                      '${item.quantity} ${item.unit![0]}'
                                                          .toLowerCase(),
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
                                                        style: TextStyle(
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
                                                              : TextSpan(),
                                                          item.optionValue !=
                                                                  null
                                                              ? TextSpan(
                                                                  text: " - ")
                                                              : TextSpan(),
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
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        '${Utils().formatCurrency(get.lines?.map((e) => e.totalAmount).reduce((value, element) => value! + element!).toString())}₮',
                                        style: TextStyle(
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
                                  conversationList.rows?.length != 0
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 15, bottom: 5),
                                          child: Text(
                                            'Харилцааны түүх',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  isSubmit == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: orderColor,
                                          ),
                                        )
                                      : Column(
                                          children: conversationList.rows!
                                              .map(
                                                (data) => ChatCard(
                                                  isOwnChat:
                                                      user.id == data.user.id,
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
                  Container(
                    decoration: BoxDecoration(
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
                              child: Container(
                                height: 40,
                                child: FormTextField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  onComplete: () {
                                    sendChat();
                                  },
                                  controller: chatController,
                                  name: 'chat',
                                  inputType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
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
                                      : Text(
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
