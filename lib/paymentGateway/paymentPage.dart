import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';

class PaymentPage extends StatefulWidget {
  final Map productDetails;
  PaymentPage(this.productDetails);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  bool _isPaymentSucess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPaymentSucess == true
          ? Center(
              child: Text('Payment Successful'),
            )
          : _isPaymentSucess == false
              ? Center(
                  child: Text('Payment Failed'),
                )
              : Center(child: Text('Redirecting to payment gateway...')),
    );
  }

  @override
  void initState() {
    print(widget.productDetails);
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    initFunctions();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void initFunctions() async {
    _isPaymentSucess = null;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration(milliseconds: 10));
    openCheckout();
  }

  void openCheckout() async {
    Map productDetails = widget.productDetails;
    var options = {
      'key': 'rzp_test_5xNVkH7JL6NQQh',
      'amount': productDetails['amount'] * 100,
      'name': '${productDetails['name']}',
      'description': '',
      // notes=[uid,category,documentId];
      'notes': [
        '${productDetails['uid']}',
        '${productDetails['category']}',
        '${productDetails['name']}',
        '${productDetails['docId']}'
      ],
      'prefill': {'contact': '9061647045', 'email': 'athultest@mail.com'},
//      'external': {
//        'wallets': ['paytm']
//      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _isPaymentSucess = true;

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade400,
//        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {});
  }

  void paymentSuccess() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade400,
//        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _isPaymentSucess = false;
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);
    setState(() {});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }
}
