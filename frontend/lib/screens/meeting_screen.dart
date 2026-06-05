import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class MeetingScreen extends ConsumerStatefulWidget {
  final String meetingId;

  const MeetingScreen({super.key, required this.meetingId});

  @override
  ConsumerState<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends ConsumerState<MeetingScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  
  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  Future<void> initRenderers() async {
    await _localRenderer.initialize();
    
    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    try {
      var stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = stream;
      setState(() {});
    } catch (e) {
      print('Error getting user media: $e');
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting: ${widget.meetingId}'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          // Main Video Area
          Center(
            child: _localRenderer.srcObject != null
              ? RTCVideoView(
                  _localRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                )
              : const CircularProgressIndicator(),
          ),
          
          // Meeting Controls
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(Icons.mic, () {}),
                const SizedBox(width: 20),
                _buildControlButton(Icons.videocam, () {}),
                const SizedBox(width: 20),
                _buildControlButton(Icons.call_end, () {
                  Navigator.pop(context);
                }, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed, {Color color = Colors.white24}) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: color,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        iconSize: 30,
        onPressed: onPressed,
      ),
    );
  }
}
