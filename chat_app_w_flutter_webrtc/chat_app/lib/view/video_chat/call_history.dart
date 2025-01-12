import 'package:chat_app/widgets/list_card_tile.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CallHistory extends ConsumerStatefulWidget {
  const CallHistory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CallHistoryState();
  }
}

class _CallHistoryState extends ConsumerState<CallHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width - 5,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.appTheme.colorScheme.tertiary),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListCardTile(leadingData: '$index', onTap: () {});
          }),
    );
  }
}
