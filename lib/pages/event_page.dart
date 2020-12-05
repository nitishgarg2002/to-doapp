import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/models/event.dart';
import 'package:task/pages/widgets/custom_icon_decoration.dart';
import 'package:task/providers/events.dart';

class EventPage extends StatefulWidget {
  static const routeName = '/event-page';
  @override
  _EventPageState createState() => _EventPageState();
}



class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    bool isFinish = false;
    return FutureBuilder(
        future: Provider.of<Events>(context, listen: false).fetchAndSetEvents(),
        builder: (ctx, snapShot) => Consumer<Events>(
            child: Center(
              child: const Text('Got no events'),
            ),
            builder: (ctx, events, ch) => events.items.length <= 0
                ? ch
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.items.length,
                    itemBuilder: (ctx, i) => Row(
                      children: [
                        _lineStyle(context, iconSize, i, events.items.length,
                            isFinish),
                        _displayTime(events.items[i]),
                        _displayContent(events.items[i]),
                      ],
                    ),
                  )));
  }

  Widget _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.event),
              SizedBox(
                height: 12,
              ),
              Text(event.desc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayTime(Event event) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(event.datetime),
        ));
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            lineWidth: 1,
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: Icon(
              isFinish
                  ? Icons.fiber_manual_record
                  : Icons.radio_button_unchecked,
              size: iconSize,
              color: Theme.of(context).accentColor),
        ));
  }
}
