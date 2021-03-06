import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/pages/widgets/custom_date_time_picker.dart';
import 'package:task/pages/widgets/custom_modal_action_button.dart';
import 'package:task/providers/tasks.dart';

class AddTaskPage extends StatefulWidget {
  static const routeName = '/add-task';
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _taskController = TextEditingController();
  void _saveTask() {
    if (_taskController.text.isEmpty) {
      return;
    }
    Provider.of<Tasks>(context, listen: false).addTask(_taskController.text);
    Navigator.of(context).pop();
  }

  DateTime _selectedDate = DateTime.now();

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().add(Duration(days: -365)),
      lastDate: new DateTime.now().add(Duration(days: 365)),
    );
    if (datepick != null)
      setState(() {
        _selectedDate = datepick;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Text(
            'Add new task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12),
                ),
                ),
              labelText: 'Add Task',
            ),
            controller: _taskController,
          ),
          SizedBox(
            height: 12,
          ),
          CustomDateTimePicker(
            icon: Icons.date_range,
            onPressed: _pickDate,
            value: new DateFormat('dd-MM-yyyy').format(_selectedDate),
          ),
          SizedBox(
            height: 24,
          ),
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: _saveTask,
          ),
        ],
      ),
    );
  }
}
