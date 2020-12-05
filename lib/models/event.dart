
import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String event;
  final String desc;
  final String datetime;
 
  const Event(
    {
      @required this.id,
     @required this.event,
     @required this.desc,
     @required this.datetime,
      });
}