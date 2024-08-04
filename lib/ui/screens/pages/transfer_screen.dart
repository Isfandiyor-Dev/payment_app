import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/transfer/transfer_bloc.dart';
import 'package:payment_app/blocs/transfer/transfer_event.dart';
import 'package:payment_app/blocs/transfer/transfer_state.dart';
import 'package:payment_app/data/models/transfer_model.dart';

class TransferScreen extends StatelessWidget {
  final TextEditingController receiverCardNumberController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();

  TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: receiverCardNumberController,
              decoration:
                  const InputDecoration(labelText: 'Receiver Card Number'),
            ),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final transfer = TransferModel(
                  senderId: 'currentUserId', // Replace with actual user ID
                  receiverCardId: receiverCardNumberController.text,
                  amount: double.parse(amountController.text), 
                  receiverId: '',
                  senderCardId: '',
                );

                BlocProvider.of<TransferBloc>(context)
                    .add(CreateTransferEvent(transfer));
              },
              child: const Text('Transfer'),
            ),
            BlocBuilder<TransferBloc, TransferState>(
              builder: (context, state) {
                if (state is TransferLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TransferSuccess) {
                  return const Text('Transfer Successful');
                } else if (state is TransferFailure) {
                  return Text('Transfer Failed: ${state.error}');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
