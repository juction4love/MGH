import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/constants.dart';
import 'package:flutter/services.dart';

class SoundService {
  /// १. वर्तमान साउन्ड मोड थाहा पाउने (Get Current Sound Mode)
  static Future<RingerModeStatus> getCurrentMode() async {
    try {
      return await SoundMode.ringerModeStatus;
    } catch (e) {
      return RingerModeStatus.unknown;
    }
  }

  /// २. फोनलाई साइलेन्ट गराउने (Set Silent Mode - Useful for Patients in Hospital)
  static Future<void> setSilentMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    } on PlatformException catch (e) {
      print('Could not set silent mode: $e');
    }
  }

  /// ३. फोनलाई भाइब्रेट गराउने (Set Vibrate Mode)
  static Future<void> setVibrateMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.vibrate);
    } on PlatformException catch (e) {
      print('Could not set vibrate mode: $e');
    }
  }

  /// ४. फोनलाई नर्मल गराउने (Set Normal Mode)
  static Future<void> setNormalMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.normal);
    } on PlatformException catch (e) {
      print('Could not set normal mode: $e');
    }
  }
}
