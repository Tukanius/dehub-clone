import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AccountSettingCard extends StatefulWidget {
  final bool startAnimation;
  final Function()? onClick;
  final int index;
  final BusinessNetwork? data;
  const AccountSettingCard({
    super.key,
    this.data,
    required this.index,
    required this.startAnimation,
    this.onClick,
  });

  @override
  State<AccountSettingCard> createState() => _AccountSettingCardState();
}

class _AccountSettingCardState extends State<AccountSettingCard> {
  @override
  Widget build(BuildContext context) {
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
                      widget.data?.logo != null || widget.data?.logo == ''
                          ? CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage:
                                  NetworkImage('${widget.data?.logo}'),
                            )
                          : const CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage: AssetImage('images/avatar.png'),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data?.profileName}',
                              style: const TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data?.refCode}',
                              style: const TextStyle(
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
                const Icon(
                  Icons.arrow_forward_ios,
                  color: networkColor,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Орлогын данс:',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.data?.inAcc == null
                          ? const Text(
                              '-',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: grey,
                                  backgroundImage: NetworkImage(
                                    '${widget.data?.inAcc?.icon}',
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.data?.inAcc?.number}',
                                  style: const TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Зарлагын данс',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.data?.outAcc == null
                          ? const Text(
                              '-',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: grey,
                                  backgroundImage: NetworkImage(
                                    '${widget.data?.outAcc?.icon}',
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.data?.outAcc?.number}',
                                  style: const TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
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
