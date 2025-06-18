import 'package:flutter/material.dart';

class YearMonthPickerDialog extends StatefulWidget {
  const YearMonthPickerDialog({super.key});

  @override
  YearMonthPickerDialogState createState() => YearMonthPickerDialogState();
}

class YearMonthPickerDialogState extends State<YearMonthPickerDialog> {
  int selectedYear = DateTime.now().year;

  final List<String> months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Month & Year'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () => setState(() => selectedYear--),
              ),
              Text('$selectedYear', style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () => setState(() => selectedYear++),
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(months.length, (index) {
              String month = months[index];
              return GestureDetector(
                onTap: () {
                  DateTime selected = DateTime(selectedYear, index + 1);
                  Navigator.pop(context, selected);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    month,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}