import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const DatePickerField(
      {super.key, required this.controller, required this.labelText});

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today),
        labelText: widget.labelText,
      ),
      readOnly: true,
      onTap: () async {
        await _selectDate(context);
      },
    );
  }
}
