import 'package:flutter/material.dart';

import 'chart.dart';
import 'nextTransaction.dart';
import 'transactionlist.dart';
import 'transactions.dart';

void main() {
  return runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
 
  Widget build(BuildContext context) => MaterialApp(
    title: 'Personal Expenses',   
    theme: ThemeData(
      primarySwatch: Colors.teal,
      accentColor: Colors.amber,
      textTheme: ThemeData.light().textTheme.copyWith(
      button: TextStyle(color: Colors.white)
      ),
    ),
     home: Homepage(),
  );
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTx {
    return _userTransactions.where((tx) {return
     tx.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
     
     }).toList();
  }

  void userTx(String Txtitle, double Txamount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        amount: Txamount,
        title: Txtitle,
        time: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransactions( String id){
    setState(() {
       _userTransactions.removeWhere((tx) => tx.id == id);
    });
   

  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NextTransaction(userTx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }


  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: ListTile(
            leading: Icon(Icons.list),
            title: Text('Expenses Manager',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center),
            trailing: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white38,
              onPressed: () =>  _startAddNewTransaction(context),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(_recentTx),
              TransactionList(_userTransactions, _deleteTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)),
      );
    
  }
}



// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     home: MyHomePage(),
//   );
// }

// class MyHomePage extends StatelessWidget {

//   static const String _message = 'This is the modal bottom sheet. Click anywhere to dismiss.';

//   static void _showModalBottomSheet(BuildContext context) => showModalBottomSheet<void>(
//     context: context,
//     builder: (BuildContext context) => Container(
//     child:  Padding(
//       padding: const EdgeInsets.all(32.0),
//         child:  Text(_message,
//           textAlign: TextAlign.center,
//           style:  TextStyle(
//             color: Theme.of(context).accentColor,
//             fontSize: 24.0
//           ),
//         ),
//   ),),);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     floatingActionButton: FloatingActionButton(
//       onPressed: () => _showModalBottomSheet(context)),);
// }
