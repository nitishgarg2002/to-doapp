import 'package:flutter/foundation.dart';
import 'package:task/helpers/db_Helper.dart';
import 'package:task/models/event.dart';


class Events with ChangeNotifier {
  List<Event> _items =[];
  List<Event> get items {
    return [..._items];
  }
  void addEvent(
  String pickedEvent,
  String desc, 
  String pickedTime,
  ) {
    final newEvent = Event(
      id: DateTime.now().toString(),
      event: pickedEvent,
      datetime: pickedTime,
      desc: desc,
      
    );
    
    _items.add(newEvent);
    notifyListeners();
    DBHelper2.database();
    DBHelper2.insert('user_events', {
      'id': newEvent.id,
      'event': newEvent.event,
      'datetime':newEvent.datetime,
      'desc':newEvent.desc,
    });
  }
  Future<void> fetchAndSetEvents() async {
    final dataList = await DBHelper2.getData('user_events');
    _items = dataList.map(
      (item) => Event(
        id: item['id'],
        event: item['event'],
        datetime: item['datetime'],
        desc: item['desc'],
      ),
    ).toList();
    notifyListeners();
  }
}