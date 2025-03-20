import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/orders_screen/component/order_placed_detail.dart';
import 'package:emart_app/view/orders_screen/component/orederstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailscreen extends StatelessWidget {
  final dynamic data;

  const OrderDetailscreen({Key? key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(redColor).make(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              OrderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Order Placed",
                  showDone: data['order_placed']),
              OrderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']),
              OrderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']),
              OrderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Order Delivered",
                  showDone: data['order_delivered']),
              const Divider(
                thickness: 3,
              ),
              Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMEd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlaceDetails(
                      d1: "UnPaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address".text.fontFamily(bold).make(),
                              // Todo: this one remove
                              // "${data['order_by_name']}".text.make(),
                              "${data['order_by_email']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_address']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_city']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_state']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_phone']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_postelcode']}"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                "Rs.${data['total_amount']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 20,
                          width: 30,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
