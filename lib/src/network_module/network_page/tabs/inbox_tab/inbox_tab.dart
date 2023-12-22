import 'package:dehub/src/network_module/network_page/tabs/inbox_tab/invitation.dart';
import 'package:flutter/material.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({Key? key}) : super(key: key);

  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  changePage(index) {
    setState(() {
      tabController.index = index;
    });
  }

  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.index = currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: Text(
            'Ирсэн урилга',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Invitation(),
      ],
    );
  }
}
