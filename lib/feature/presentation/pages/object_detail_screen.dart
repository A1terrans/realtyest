import 'package:flutter/material.dart';
import 'package:realtyest/common/fonts.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/presentation/pages/image_scale_screen.dart';
import 'package:realtyest/feature/presentation/widgets/object_cache_image_widget.dart';
import 'package:realtyest/feature/presentation/widgets/object_map_widget.dart';
import 'package:clipboard/clipboard.dart';

class ObjectDetailPage extends StatelessWidget {
  final double fontS = 13;
  final Color textColor = Colors.white;
  final RealEntity object;
  const ObjectDetailPage({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> contacts = object.Contacts.toString().split(';');
    double widthBase = MediaQuery.of(context).size.width;
    double temp = widthBase / (500 / FONT_SIZE);
    double sfwidth = temp <= FONT_SIZE ? temp : FONT_SIZE;
    void showBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          width: 200,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Скопировано',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Недвижимость СПб'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.white,
            ),
            width: widthBase,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  object.Types.toString() + " " + object.ID.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: FONT_SIZE_BIG,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageScalePage(url: object.Image.toString())),
                    );
                  },
                  child: ObjectCacheImage(
                      imageUrl: object.Image.toString(),
                      width: widthBase - 15,
                      height: 250),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: widthBase - 10,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.red,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Комнаты: ${object.Rooms.toString() != " " ? object.Rooms.toString() : "нет"}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Апартаменты: ${object.Apart.toString() != " " ? object.Apart.toString() : "нет"}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Студия: ${object.Stud.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Этаж: ${object.FloorN.toString() != " " ? object.FloorN.toString() : "нет"}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Год: ${object.Year.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Отделка: ${object.TypeTwo.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Цена: ${object.Price.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Площадь общая: ${object.AllS.toString()} m2",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Площадь жилая: ${object.LiveS.toString()} m2",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Площадь кухни: ${object.KitchenS.toString()} m2",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Этажей: ${object.AllFloors.toString() != " " ? object.AllFloors.toString() : "нет"}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Очередь: ${object.Queye.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Тип: ${object.BuildType.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Базовая цена: ${object.BasePrice.toString()}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: sfwidth,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Адрес: ${object.Region.toString() + ", " + object.Address.toString()}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: FONT_SIZE,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Контакты: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FONT_SIZE,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        contacts[0],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: FONT_SIZE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        FlutterClipboard.copy(contacts[0])
                            .then((value) => showBar());
                      },
                    ),
                    const Text(
                      ';',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FONT_SIZE,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        contacts[1],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: FONT_SIZE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        FlutterClipboard.copy(contacts[1])
                            .then((value) => showBar());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ObjectMap(coords: [
              double.parse(object.Lat.toString()),
              double.parse(object.Lon.toString())
            ]),
          ),
        ],
      )),
    );
  }
}
