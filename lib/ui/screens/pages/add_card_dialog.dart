import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/card/card_bloc.dart';
import 'package:payment_app/blocs/card/card_event.dart';
import 'package:payment_app/data/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({super.key});

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  final TextEditingController cardNumberController = TextEditingController();

  final TextEditingController cardHolderNameController =
      TextEditingController();

  final TextEditingController expiryDateController = TextEditingController();

  final TextEditingController cvvController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Card'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cardHolderNameController,
                decoration:
                    const InputDecoration(labelText: 'Card Holder Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: expiryDateController,
                decoration:
                    const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? userId = prefs.getString('userID');

              if (userId != null) {
                // ignore: use_build_context_synchronously
                context.read<CardBloc>().add(
                      AddCardEvent(
                        CardModel(
                          id: UniqueKey().toString(), // Yangi kartaning idsi
                          userId: userId, // Foydalanuvchi idsi
                          number: cardNumberController.text,
                          balance: 0.0,
                        ),
                      ),
                    );
                // Add card logic here
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                print("Userni id null shuning uchun qo'shilmadi card");
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
