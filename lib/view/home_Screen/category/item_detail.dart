import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:emart_app/view/chat_screen/chat_screen.dart';
import 'package:get/get.dart';
import '../../../Widget_common/commonButton.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  ItemDetails({Key? key, this.title, this.data}) : super(key: key);
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              controller.resetValue();
              Get.back();
            },
          ),
          title:
              title!.text.fontFamily(bold).size(20).color(darkFontGrey).make(),
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(
                      "https://play.google.com/store/apps/details?id=com.niftyb2b");
                },
                icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                      controller.isFav(false);
                    } else {
                      controller.addToWishList(data.id, context);
                      controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_images'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                      10.heightBox,
                      title!.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        //isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        count: 5,
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        maxRating: 5,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_prices']}"
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .color(redColor)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Seller"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  5.heightBox,
                                  "MRG"
                                 // "${data['p_seller']}"
                                      .text
                                      .size(14)
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make()
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                   launch("tel://9714003441");
                                  /* Get.to(() => const ChatScreen(), arguments: [
                                    data['p_seller'],
                                    data['vendor_id']
                                  ]);*/
                                },
                                    
                                //   Get.to(() => const ChatScreen(), arguments: [
                                //     data['p_seller'],
                                //     data['vendor_id']
                                //   ]);
                                // },
                                icon: (Image.asset(icCall)),
                              )),
                              const SizedBox(width: 20,),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                
                                   Get.to(() => const ChatScreen(), arguments: [
                                    data['p_seller'],
                                    data['vendor_id']
                                  ]);
                                },
                                    
                                icon: (Image.asset(icMessages)),
                              ))
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      // color section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Color:".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(data['p_color'][index])
                                                .withOpacity(1.0))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .make()
                                            .onTap(() {
                                          controller.chageColorIndex(index);
                                        }),
                                        Visibility(
                                            visible: index ==
                                                controller.colorIndex.value,
                                            child: const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            // quantiy
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: "Quentitty: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.quentityDecrease();
                                        controller.totalMoney(
                                            int.parse(data['p_prices']));
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    controller.quentity.value.text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                      onPressed: () {
                                        controller.quentityIncrease(
                                            totalQuentity: int.parse(
                                                "${data['p_quentity']}"));
                                        controller.totalMoney(
                                            int.parse(data['p_prices']));
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    "${data["p_quentity"]} Available"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ]),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                '${controller.totalPrice.value}'
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.shadowSm.white.make(),
                      ),
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                            title: itemDetailButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  // launchURLBrowser(Uri.parse(data['p_vediourl']));
                                  launchURLBrowser(Uri.parse(
                                      "https://www.youtube.com/watch?v=WnzM5iOYoTE&ab_channel=PoojaJain"));
                                  break;
                                // case 1:
                                //   // launchURLBrowser(Uri.parse(
                                //   //     "https://play.google.com/store/apps/details?id=com.smartprix.main&pli=1"));
                                //   break;
                                case 1:
                                  launchURLBrowser(Uri.parse(
                                      "https://www.freeprivacypolicy.com/live/d79a3d2a-d34c-4f94-971c-915b3f182863"));
                                  break;
                                case 2:
                                  launchURLBrowser(Uri.parse(
                                      "https://www.amazon.in/gp/help/customer/display.html/ref=cs_ret_rfp_q_3/?nodeId=202111770"));
                                  break;
                                case 3:
                                  launchURLBrowser(Uri.parse(
                                      "https://themeforest.net/page/item_support_policy"));
                                  break;
                                default:
                              }
                            },
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),

                      // Products You May Like
                      20.heightBox,
                      productsMayYouLike.text
                          .size(16)
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder(
                          stream: FireStoreServices.getFeaturedProduct(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return "No Featured Product"
                                  .text
                                  .white
                                  .makeCentered();
                            } else {
                              var featureddata = snapshot.data!.docs;
                              return Row(
                                children: List.generate(
                                    featureddata.length,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featureddata[index]['p_images']
                                                  [0],
                                              width: 150,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "${featureddata[index]['p_name']}"
                                                .text
                                                .color(darkFontGrey)
                                                .fontFamily(semibold)
                                                .make(),
                                            10.heightBox,
                                            "${featureddata[index]['p_prices']}"
                                                .numCurrency
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .size(16)
                                                .make()
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .roundedSM
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemDetails(
                                                title:
                                                    "${featureddata[index]['p_name']}",
                                                data: featureddata[index],
                                              ));
                                        })),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: commonButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quentity.value > 0) {
                      controller.addToCart(
                          vendorId: data['vendor_id'],
                          color: data['p_color'][controller.colorIndex.value],
                          context: context,
                          title: data['p_name'],
                          img: data['p_images'][0],
                          qty: controller.quentity.value,
                          sellerName: data['p_seller'], //data['p_seller']
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added To Cart");
                    } else {
                      VxToast.show(context,
                          msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add To Cart"),
            )
          ],
        ),
      ),
    );
  }

  launchURLBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
