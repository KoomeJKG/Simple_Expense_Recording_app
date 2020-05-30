import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextTransaction extends StatefulWidget {
  final Function addTx;

  NextTransaction(this.addTx);

  @override
  _NextTransactionState createState() => _NextTransactionState();
}

class _NextTransactionState extends State<NextTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submittedData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    DateTime selectedDates = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 ) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, selectedDates);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
         _selectedDate = pickedDate;
      });
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) {
                submittedData();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submittedData();
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate == null ? 'No date picked' : ' Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submittedData,
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
