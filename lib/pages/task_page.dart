import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/models/task.dart';
import 'package:task/pages/widgets/custom_button.dart';
import 'package:task/providers/tasks.dart';
class TaskPage extends StatefulWidget {
  
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
                    future: Provider.of<Tasks>(context, listen: false)
                        .fetchAndSetTasks(),
                    builder: (ctx, snapShot) =>
                        
                             Consumer<Tasks>(
                                child: Center(
                                  child: const Text('Got no tasks'),
                                ),
                                builder: (ctx, tasks, ch) => tasks.items.length <= 0
                                    ? ch
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: tasks.items.length,
                                        itemBuilder: (ctx, i) =>
                                            _taskUncomplete(tasks.items[i])),
                              ),
                  );
                 
              
            
          
  
      
           
    
  }

  Widget _taskUncomplete(Task data) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm Task',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        data.task,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text('time'),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: 'Complete',
                        onPressed: () {},
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            });
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Delete Task',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(data.task),
                      SizedBox(
                        height: 24,
                      ),
                      Text('date'),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: 'Delete',
                        onPressed: () {},
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(
              data.task,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskComplete(Task data) {
    return Container(
      foregroundDecoration: BoxDecoration(
        color: Color(0x60FDFDFD),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.task),
          ],
        ),
      ),
    );
  }
}

