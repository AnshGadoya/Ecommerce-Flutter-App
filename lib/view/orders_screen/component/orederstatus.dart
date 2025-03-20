import 'package:emart_app/consts/consts.dart';

Widget OrderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).fontFamily(bold).make(),
          showDone
              ? const Icon(
                  Icons.done_all_rounded,
                  color: redColor,
                ).box.rounded.make()
              : Container(),
        ],
      ),
    ),
  );
}
