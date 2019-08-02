import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:aris_frontend/services/redeemCoupon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:convert';

class CouponForm extends StatefulWidget {
  @override
  CouponFormState createState() {
    return CouponFormState();
  }
}

class CouponFormState extends State<CouponForm> {

  final _formKey = GlobalKey<FormState>();

  String myToken = '';

  TextEditingController couponController = MaskedTextController(mask: '@@@@-@@@@-@@@@-@@@@');

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myToken = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            children: <Widget>[
              Text(
                "Enter your coupon code below to redeem its value.",
                style: TextStyle(
                  fontSize: 20.0,
                )
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter code here...',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                controller: couponController,
                keyboardAppearance: Brightness.light,
                validator: (code) {
                  // Validate input
                  if (code.length != 19) {
                    return 'Invalid coupon form';
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Redeem",
                gradientColors: [Color(0xff390D58), Colors.deepPurpleAccent],
                onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Validating coupon code...'), backgroundColor: Colors.blue,));
                      var body= json.encode({
                        'account_id': 1,
                        'coupon_code': couponController.text
                      });
                      redeemCoupon("https://aris-backend-staging.herokuapp.com/coupons", body, myToken).then((Response r) {
                        if (r.statusCode == 200) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Success: \$${r.coupon_value} has been added to your account.'), backgroundColor: Colors.green,));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error: ${r.description}'), backgroundColor: Colors.red));
                        }
                      });
                    }
                  }
              ),
            ],
          ),
        ),
      )
    );
  }
}