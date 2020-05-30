import './transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleleTx;

  TransactionList(this.transaction, this.deleleTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions added yet'),
                SizedBox(height: 50),
                Container(
                  height: 200,
                  child: Image.asset('assets/images/poster.png',
                      fit: BoxFit.cover),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transaction[index].amount.toStringAsFixed(2)}')),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].time),
                    ),
                    trailing: IconButton(
                      color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => deleleTx(transaction[index].id)),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
