import 'package:flutter/material.dart';
import 'package:dma_card/model/collection_history_response.dart';

class TransactionListWidget extends StatelessWidget {
  final CollectionHistoryResponse? collectionResponse;

  const TransactionListWidget({Key? key, required this.collectionResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: collectionResponse?.data != null &&
          collectionResponse!.data!.isNotEmpty
          ? ListView.builder(
        itemCount: collectionResponse!.data!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: const EdgeInsets.only(left: 5.0), // Add left margin
                child: SizedBox(
                  height: 60, // Adjust height as needed
                  width: 60, // Adjust width as needed
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      collectionResponse!.data![index].merchantLogo ?? '',
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TxID ID: ${collectionResponse!.data![index].orderId ?? ""}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Purpose: ${collectionResponse!.data![index].purpose ?? ""}'),
                  Text(
                    'Amount: ${collectionResponse!.data![index].amount?.toStringAsFixed(2) ?? ""} TK',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold), // Example styling
                  ),
                  Text('Paid at: ${collectionResponse!.data![index].created_at ?? ""}'),
                ],
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text(
          'No transaction happened yet',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

