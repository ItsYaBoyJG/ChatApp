import 'package:chat_app/models/widgets/list_card_tile.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatNotificationList extends ConsumerStatefulWidget {
  const ChatNotificationList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatNotificationListState();
  }
}

class _ChatNotificationListState extends ConsumerState<ChatNotificationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width - 5,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.appTheme.colorScheme.tertiary),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListCardTile(leadingData: '$index', onTap: () {});
          }),
    );
  }
}
