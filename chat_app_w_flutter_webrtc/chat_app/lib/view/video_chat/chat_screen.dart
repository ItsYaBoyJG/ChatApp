import 'package:chat_app/utils/enums/app_emum_states.dart';
import 'package:chat_app/data/video_signalling.dart';
import 'package:chat_app/data/session.dart';
import 'package:chat_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoChatScreen extends StatefulWidget {
  const VideoChatScreen({super.key});

  @override
  State<VideoChatScreen> createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
//  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Signaling? _signaling;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? _selfId;
  String? _roomId;
  MediaStream? _mediaStream;
  bool? _isRemoteConnected;
  bool _inCall = false;
  bool _waitAccept = false;
  List _peers = [];
  Session? _session;

  Future _showPermissionsDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Action Needed'),
            content: const Text(
                'In order to participate in video calls, you need to'
                ' give access to your camera and microphone while using the app.'),
            actions: [
              OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
              OutlinedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Settings'))
            ],
          );
        });
  }

  void _checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      _activateConnect();
    } else {
      if (await Permission.camera.request().isGranted &&
          await Permission.microphone.request().isGranted) {
        _activateConnect();
      } else {
        _showPermissionsDialog();
      }
    }
  }

  void _activateConnect() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    _connect(context);
  }

  void _connect(BuildContext context) async {
    _signaling ??= Signaling('localhost', context)..connect();
    _signaling?.onSignalingStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.closed:
        case SignalingState.error:
        case SignalingState.open:
          break;
      }
    };

    _signaling?.onCallStateChange = (Session session, CallState state) async {
      switch (state) {
        case CallState.newState:
          setState(() {
            _session = session;
          });
          break;
        case CallState.ringState:
          bool? accept = await _showAcceptDialog();
          if (accept!) {
            _accept();
            setState(() {
              _inCall = true;
            });
          } else {
            _reject();
          }
          break;
        case CallState.hangUpState:
          if (_waitAccept) {
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            _localRenderer.srcObject = null;
            _remoteRenderer.srcObject = null;
            _inCall = false;
            _session = null;
          });
          break;
        case CallState.inviteState:
          _waitAccept = true;
          _showInviteDialog();
          break;
        case CallState.connectedSate:
          if (_waitAccept) {
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            _inCall = true;
          });

          break;
      }
    };

    _signaling?.onPeersUpdate = ((event) {
      setState(() {
        _selfId = event['self'];
        _peers = event['peers'];
      });
    });

    _signaling?.onLocalStream = ((stream) {
      _localRenderer.srcObject = stream;
      setState(() {});
    });

    _signaling?.onAddRemoteStream = ((_, stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    _signaling?.onRemoveRemoteStream = ((_, stream) {
      _remoteRenderer.srcObject = null;
    });
  }

  Future<bool?> _showAcceptDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Call'),
          content: const Text('Accept?'),
          actions: [
            MaterialButton(
              child: const Text(
                'Reject',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => context.pop(false),
            ),
            MaterialButton(
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showInviteDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invited User'),
          content: const Text('Waiting'),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                context.pop(false);
                _hangUp();
              },
            ),
          ],
        );
      },
    );
  }

  void _invitePeer(BuildContext context, String peerId, bool useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling?.invite(peerId, 'video', useScreen);
    }
  }

  void _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid, 'video');
    }
  }

  void _reject() {
    if (_session != null) {
      _signaling?.reject(_session!.sid);
    }
  }

  void _hangUp() {
    if (_session != null) {
      _signaling?.bye(_session!.sid);
    }
  }

  void _switchCamera() {
    _signaling?.switchCamera();
  }

  void _muteMic() {
    _signaling?.muteMic();
  }

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  void deactivate() {
    _signaling?.close();
    _remoteRenderer.dispose();
    _localRenderer.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: _inCall
            ? OrientationBuilder(
                builder: (context, orientation) {
                  return Stack(
                    children: [
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          child: RTCVideoView(_remoteRenderer),
                        ),
                      ),
                      Positioned(
                        left: 20.0,
                        top: 20.0,
                        child: Container(
                          width: orientation == Orientation.portrait
                              ? 90.0
                              : 120.0,
                          height: orientation == Orientation.portrait
                              ? 120.0
                              : 90.0,
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          child: RTCVideoView(_localRenderer, mirror: true),
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                itemCount: (_peers.length),
                itemBuilder: (context, i) {
                  var peer = _peers[i];
                  var self = (peer['id'] == _selfId);
                  return ListBody(
                    children: [
                      ListTile(
                        title: Text(self
                            ? peer['name'] +
                                ', ID: ${peer['id']} ' +
                                ' [Your self]'
                            : peer['name'] + ', ID: ${peer['id']} '),
                        onTap: null,
                        trailing: SizedBox(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!self)
                                IconButton(
                                  icon: Icon(
                                      self ? Icons.close : Icons.videocam,
                                      color: self ? Colors.grey : Colors.black),
                                  onPressed: () =>
                                      _invitePeer(context, peer['id'], false),
                                  tooltip: 'Video calling',
                                ),
                            ],
                          ),
                        ),
                        subtitle: Text('${peer['user_agent']}'),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCall
          ? SizedBox(
              width: 240.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    tooltip: 'Camera',
                    onPressed: _switchCamera,
                    child: const Icon(Icons.switch_camera),
                  ),
                  FloatingActionButton(
                    onPressed: _hangUp,
                    tooltip: 'Hangup',
                    backgroundColor: Colors.pink,
                    child: const Icon(Icons.call_end),
                  ),
                  FloatingActionButton(
                    tooltip: 'Mute Mic',
                    onPressed: _muteMic,
                    child: const Icon(Icons.mic_off),
                  )
                ],
              ),
            )
          : GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(10.0),
                height: 70,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                    color: AppTheme.appTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(24.0)),
                child: const Center(
                  child: Text(
                    ' Make a video call',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              onTap: () {},
            ),
    );
  }
}

/**
 * 
 * GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(10.0),
                height: 70,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                    color: AppTheme.appTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(24.0)),
                child: const Center(
                  child: Text(
                    ' Make a video call',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              onTap: () {},
            ),
 */
