import 'dart:ui';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../services/local_store_config.dart';

class HelperUtils {
  static String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return '';
    }

    DateTime date = timestamp.toDate();

    Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      String time = DateFormat('dd MMM yyy, h:mm a').format(date);
      return time;
    } else {
      String time = DateFormat('h:mm a').format(date);
      if (difference.inHours > 23) {
        return "Yesterday $time";
      } else {
        return time;
      }
    }
  }

}
