import 'package:flutter_webrtc/flutter_webrtc.dart';

class Session {
  Session({required this.pid, required this.sid});

  final String pid;
  final String sid;
  RTCPeerConnection? peerConnection;
  RTCDataChannel? dataChannel;
  List<RTCIceCandidate>? remoteCandidates = [];
}
