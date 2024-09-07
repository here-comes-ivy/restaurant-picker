import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../../services/payment_config.dart';

class PaymentGrid extends StatelessWidget {
  final List<String> emoji = ["🍩", "☕", "🧋", "🍺"];
  final List<String> prices = ["\$0.99", "\$1.99", "\$2.99", "\$3.99"];

  void onGooglePayResult(paymentResult) {
    // 處理 Google Pay 結果
  }

  void onApplePayResult(paymentResult) {
    // 處理 Apple Pay 結果
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GooglePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: [
                        PaymentItem(
                          label: 'Buy ${emoji[index]}',
                          amount: prices[index],
                          status: PaymentItemStatus.final_price,
                        ),
                      ],
                      width: double.infinity,
                      height: 50,
                      type: GooglePayButtonType.pay,
                      onPaymentResult: onGooglePayResult,
                    ),
                    ApplePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
                      paymentItems: [
                        PaymentItem(
                          label: 'Buy ${emoji[index]}',
                          amount: prices[index],
                          status: PaymentItemStatus.final_price,
                        ),
                      ],
                      width: double.infinity,
                      height: 50,
                      style: ApplePayButtonStyle.black,
                      type: ApplePayButtonType.buy,
                      onPaymentResult: onApplePayResult,
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.deepOrange[100 * (index + 1)],
            ),
            child: Center(
              child: Text(
                'Buy me a ${emoji[index]}',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}