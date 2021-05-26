import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_flutter_app/widgets/transaction_form.dart';
import 'package:second_flutter_app/widgets/transaction_list.dart';
import 'package:uuid/uuid.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  // NECESSARIO NELLE VERSIONI RECENTI PER SETTARE LE PREFERRED
  /*WidgetsFlutterBinding.ensureInitialized();*/

  // BLOCCO GLI ORIENTAMENTI POSSIBILI
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    /**
     * SE NON FACESSI COSÌ DOVREI GESTIRE MANUALMENTE I PROBL (es. TEXT SIZE)
     * Al momento lui suggerisce di utilizzare sempre MaterialApp
     * se non serve necessariamente la CupertinoApp e utilizzare dove serve Platform.isIOS
     */
    return /*Platform.isIOS
        ? CupertinoApp(
            title: 'My Expenses Tracker',
            theme: CupertinoThemeData(),
            home: MyHomePage(),
            // TODO Check utility
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
          )
        : */
        MaterialApp(
      title: 'My Expenses Tracker',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Exo2'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // FAKE TRANSACTIONS LIST
  final List<Transaction> _transactions = [
    Transaction(
      id: Uuid().v1(),
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 200.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'New Jeans',
      amount: 350.50,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  void _handleSwitchChange(value) {
    setState(() {
      _showChart = value;
    });
  }

  void addTransaction(String title, double amount, DateTime chosenDate) {
    print('ADDING TRANSACTION: ' + title + ' --> ' + amount.toString());

    final transaction = Transaction(
      id: Uuid().v1(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  void deleteTransaction(String uuid) {
    setState(() {
      _transactions.removeWhere((element) => element.id == uuid);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    final builder = (_) {
      return TransactionForm(_transactions, addTransaction);
    };

    Platform.isIOS
        ? showCupertinoModalPopup(
            context: context, builder: builder, useRootNavigator: true)
        : showModalBottomSheet(context: context, builder: builder);
  }

  List<Transaction> get _recentTransactions {
    var list = _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
    // print('>>>> LIST' + list.toString());

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // APP BAR TITLE
    final appTitleComponent = Text('My Expenses Tracker');

    // APP BAR COMPONENT
    final appBarComponent = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: appTitleComponent,
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  child: Icon(CupertinoIcons.add),
                  onPressed: () => startAddNewTransaction(context),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          )
        : AppBar(
            title: appTitleComponent,
            actions: [
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );

    final mediaQuery = MediaQuery.of(context);

    // isLandscape
    final isLandscapeMode = mediaQuery.orientation == Orientation.landscape;

    // fullHeight - appBar - statusBar
    final availableHeight = mediaQuery.size.height -
        (appBarComponent as PreferredSizeWidget).preferredSize.height -
        MediaQuery.of(context).padding.top;

    // TRANSACTIONS COMPONENT
    final transactionsComponent = Column(children: [
      Container(
        height: availableHeight * 0.7,
        child: TransactionList(_transactions, deleteTransaction),
      )
    ]);

    // CHART COMPONENT
    final chartComponent = Container(
      alignment: Alignment.center,
      height: availableHeight * 0.6,
      child: Chart(_recentTransactions),
    );

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SINTASSI NUOVA E SPECIALE
            if (isLandscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  // adaptive == CAMBIA STILE IN BASE AL S.O.
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: _handleSwitchChange,
                  ),
                ],
              ),
            // SHOW BOTH IN PORTRAIT
            if (!isLandscapeMode) chartComponent,
            if (!isLandscapeMode) transactionsComponent,
            // SHOW ONE IN LANDSCAPE BASED ON SWITCH
            if (isLandscapeMode)
              _showChart ? chartComponent : transactionsComponent,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBarComponent as CupertinoNavigationBar,
            child: appBody,
          )
        : Scaffold(
            appBar: appBarComponent as AppBar,
            body: appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // Components Render based on Operative System Check
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
