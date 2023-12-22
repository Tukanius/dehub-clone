import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientStaffCard extends StatefulWidget {
  final bool startAnimation;
  final int index;
  final Function()? onClick;
  final BusinessNetwork? data;
  const ClientStaffCard({
    Key? key,
    this.onClick,
    this.data,
    required this.index,
    required this.startAnimation,
  }) : super(key: key);

  @override
  State<ClientStaffCard> createState() => _ClientStaffCardState();
}

class _ClientStaffCardState extends State<ClientStaffCard> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).businessUser;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      widget.data?.logo == null
                          ? CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage: AssetImage('images/avatar.png'),
                            )
                          : CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage: NetworkImage(
                                '${widget.data?.logo}',
                              ),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data?.profileName}',
                              style: TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data?.refCode}',
                              style: TextStyle(
                                color: dark,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: networkColor,
                  size: 18,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Хариуцсан:',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: widget.data?.businessStaff?.avatar == null
                                  ? Image.asset(
                                      'images/avatar.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      '${widget.data?.businessStaff?.avatar}',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat'),
                                children: [
                                  widget.data?.businessStaff?.lastName != null
                                      ? TextSpan(
                                          text:
                                              '${widget.data?.businessStaff?.lastName}')
                                      : TextSpan(text: ''),
                                  widget.data?.businessStaff?.firstName != null
                                      ? TextSpan(
                                          text:
                                              '${widget.data?.businessStaff?.firstName}')
                                      : TextSpan(text: '-'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Орлох ажилтан:',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: widget.data?.businessStaff2?.avatar == null
                                  ? Image.asset(
                                      'images/avatar.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      '${widget.data?.businessStaff2?.avatar}',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat'),
                                children: [
                                  widget.data?.businessStaff2?.lastName != null
                                      ? TextSpan(
                                          text:
                                              '${widget.data?.businessStaff2?.lastName}')
                                      : TextSpan(text: ''),
                                  widget.data?.businessStaff2?.firstName != null
                                      ? TextSpan(
                                          text:
                                              '${widget.data?.businessStaff2?.firstName}')
                                      : TextSpan(text: '-'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
