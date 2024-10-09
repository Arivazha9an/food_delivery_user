import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/widgets/button.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Variables to hold card information
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView:
                  isCvvFocused, // Toggle back view when focusing on CVV
              cardBgColor: Colors.teal,
              obscureCardCvv: true,
              obscureCardNumber: true,
              labelCardHolder: 'Card Holder',
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: true,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              onCreditCardModelChange: onCreditCardModelChange,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextButton(
              title: 'Pay now',
              background: Colors.teal,
              textColor: white.withOpacity(0.8),
              fontSize: 20,
              width: 200,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  // You can proceed to Stripe Payment
                  if (kDebugMode) {
                    print('Card Details are valid');
                  }
                  // Trigger Stripe integration here
                } else {
                  if (kDebugMode) {
                    print('Invalid Card Details');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // This function is called whenever there’s a change in the card form fields.
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
