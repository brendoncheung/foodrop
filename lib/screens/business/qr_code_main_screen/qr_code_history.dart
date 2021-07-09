import 'package:flutter/material.dart';

import '../../../core/models/UserProfile.dart';
import '../../../core/models/business.dart';
import '../../../core/models/qr_transaction.dart';
import '../../../core/services/repositories/qr_transaction_repository.dart';
import 'qr_code_generation_screen.dart';
import 'package:provider/provider.dart';

class QRCodeHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QRTransactionRepository repo = Provider.of<QRTransactionRepository>(context);
    Business business = Provider.of<Business>(context);

    void addTapped() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => QRCodeGenerationScreen(
            user: Provider.of<UserProfile>(context),
            business: Provider.of<Business>(context),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: addTapped, icon: Icon(Icons.add))],
        ),
        body: FutureBuilder(
            future: repo.fetchAllTransactions(business.uid),
            builder: (_, AsyncSnapshot<List<QRTransaction>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var transactions = snapshot.data;
                return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (_, index) {
                      if (transactions[index].recipientId == null) {
                        return ListTile(
                          title: Text("Pending..."),
                          subtitle: Text("\$${transactions[index].dollarAmountTransacted.toString()}"),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                        );
                      }

                      return ListTile(
                        title: Text(transactions[index].recipientId),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
