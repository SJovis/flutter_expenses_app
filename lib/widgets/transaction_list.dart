import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).primaryColorLight,
                        ),
                ),
              );
            },
          );
  }
}
