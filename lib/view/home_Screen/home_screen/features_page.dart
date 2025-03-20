import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:emart_app/view/home_Screen/category/item_detail.dart';
import 'package:get/get.dart';

class MyFeaturePage extends StatefulWidget {
  const MyFeaturePage({super.key});

  @override
  State<MyFeaturePage> createState() => _MyFeaturePageState();
}

class _MyFeaturePageState extends State<MyFeaturePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
                                stream: FireStoreServices.getFeaturedProduct(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(redColor),
                                      ),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Product"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featureddata = snapshot.data!.docs;
                                    return  ListView.builder(
                                      itemCount: featureddata.length,
                                        itemBuilder: (context, index) {
                                          
                                           return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    featureddata[index]
                                                        ['p_images'][0],
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
                                                  .margin(
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 4))
                                                  .roundedSM
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(() => ItemDetails(
                                                      title:
                                                          "${featureddata[index]['p_name']}",
                                                      data: featureddata[index],
                                                    ));
                                              });});
                                    
                                  }
                                },
                              )
       ,
      ),
    );
                        
  }
}