import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.red,
      Colors.teal,
      Colors.purple
    ];
    
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                  icon: Icon(Icons.delete),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).errorColor),
                  label: Text('Delete'),
                )
              : IconButton(
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                )),
    );
  }
}
