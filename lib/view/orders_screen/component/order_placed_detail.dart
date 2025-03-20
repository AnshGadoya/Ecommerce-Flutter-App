import 'package:emart_app/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "$title1".text.fontFamily(bold).make(),
              "$d1".text.fontFamily(semibold).color(redColor).make()
            ],
          ),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                "$title2".text.fontFamily(bold).make(),
                "$d2".text.fontFamily(semibold).color(redColor).make()
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
