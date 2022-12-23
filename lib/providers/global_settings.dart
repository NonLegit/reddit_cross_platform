import 'package:flutter/material.dart';

class GlobalSettings with ChangeNotifier {
  bool isMuted;
  bool isAutoPlay;
  GlobalSettings(this.isMuted, this.isAutoPlay);
  bool get getIsMuted => isMuted;
  mute() => isMuted = true;
  unMute() => isMuted = false;
}
