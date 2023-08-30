import 'package:dehub/models/invoice.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/index1.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/pdf_page.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/send_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class HarahArguments {
  Invoice invoice;
  List<Invoice> data;
  HarahArguments({
    required this.invoice,
    required this.data,
  });
}

class Harah extends StatefulWidget {
  final Invoice invoice;
  final List<Invoice> data;
  static const routeName = '/harah';
  const Harah({
    required this.invoice,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<Harah> createState() => _HarahState();
}

class _HarahState extends State<Harah>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  int currentIndex = 1;
  bool isTap = false;

  @override
  afterFirstLayout(BuildContext context) {
    print(widget.data.first.toJson());
    print('=====data=====');
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'INV-290812',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '417,450 ₮',
              style: TextStyle(
                color: invoiceColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Bolor Retail Store',
              style: TextStyle(
                fontSize: 16,
                color: grey3,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: grey3, width: 0.5),
                        color: currentIndex == 0 ? invoiceColor : white,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: currentIndex == 0 ? white : grey3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: grey3, width: 0.5),
                          color: currentIndex == 1 ? invoiceColor : white),
                      child: Icon(
                        Icons.visibility_outlined,
                        color: currentIndex != 1 ? grey3 : white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: transparent,
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => buildSheet(),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: grey3, width: 0.5),
                          color: currentIndex == 2 ? invoiceColor : white),
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
                        color: currentIndex == 2 ? white : grey3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                      showModalBottomSheet(
                        backgroundColor: transparent,
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => sendSheet(),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: grey3, width: 0.5),
                        color: currentIndex == 3 ? invoiceColor : white,
                      ),
                      child: Icon(
                        Icons.mail_outlined,
                        color: currentIndex != 3 ? grey3 : white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
            ),
            currentIndex == 1
                ? Index1(
                    invoice: widget.invoice,
                    data: widget.data,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (context, scrollController) => PdfPage(),
      );
  Widget sendSheet() => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) => SendPage(),
      );
}
