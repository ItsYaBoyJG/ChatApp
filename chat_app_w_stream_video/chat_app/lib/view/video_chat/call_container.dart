import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class CallContainer extends ConsumerStatefulWidget {
  const CallContainer({super.key, required this.call});

  final Call call;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CallContainerState();
  }
}

class _CallContainerState extends ConsumerState<CallContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 80,
        width: MediaQuery.of(context).size.width - 5,
        padding: const EdgeInsets.all(8.0),
        child: StreamCallContainer(call: widget.call));
  }
}
