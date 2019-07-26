import 'package:flutter/material.dart';
import 'package:aris_frontend/screens/coupons/components/coupon_form.dart';


class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Coupons"),
      ),
      body: CouponForm(),
    );
  }
}