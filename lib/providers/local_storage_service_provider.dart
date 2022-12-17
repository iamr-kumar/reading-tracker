import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reading_tracker/utils/handle_time.dart';

final localStorageServiceProvider = Provider<LocalStorageService>(
  (ref) => LocalStorageService(),
);

class LocalStorageService {
  final GetStorage _box = GetStorage();
  final String _readTimekey = 'readTime';

  String? _getTimeFromStorage() => _box.read('_readTime');

  TimeOfDay? get readTime {
    final time = _getTimeFromStorage();
    if (time != null) {
      return timeFromString(time);
    }
    return null;
  }

  void setReadTime(String time) => _box.write(_readTimekey, time);
}
