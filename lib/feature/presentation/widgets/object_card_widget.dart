import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:realtyest/common/fonts.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';
import 'package:realtyest/feature/presentation/bloc/cached_bloc/cached_bloc.dart';
import 'package:realtyest/feature/presentation/pages/object_detail_screen.dart';

import 'object_cache_image_widget.dart';

final sl = GetIt.instance;

class ObjectCard extends StatelessWidget {
  final void Function() onPress;
  final RealEntity object;
  CacheBloc _cache = CacheBloc(sl());
  final bool favorite;
  ObjectCard(
      {Key? key,
      required this.object,
      this.favorite = false,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double temp = width / (440 / FONT_SIZE_BIG);
    double fwidth = temp <= FONT_SIZE_BIG ? temp : FONT_SIZE_BIG;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjectDetailPage(object: object)),
          );
        },
        child: Container(
            height: 220,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          dynamicIconFavorite(context),
                          const SizedBox(width: 35),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                object.Price.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fwidth,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                object.Queye.toString() +
                                    " " +
                                    object.Year.toString(),
                                style: TextStyle(
                                  fontSize: fwidth,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/metroTwo.png',
                              width: 25, height: 25),
                          const SizedBox(width: 5),
                          Text(
                            object.Metro.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: FONT_SIZE_SMALL,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          object.Address.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: FONT_SIZE_SMALL,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Прощадь: ${object.AllS.toString()} m2",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: FONT_SIZE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ID: ${object.ID.toString()}",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: FONT_SIZE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                ObjectCacheImage(
                  width: width / 3.5,
                  height: 200,
                  imageUrl: object.Image.toString(),
                ),
              ],
            )),
      ),
    );
  }

  void _showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  IconButton dynamicIconFavorite(BuildContext context) {
    if (favorite) {
      return IconButton(
          onPressed: () {
            onPress();
            _showToast(context, 'Удалено из избранного');
          },
          icon: const Icon(Icons.delete, size: 30));
    } else {
      return IconButton(
          onPressed: () {
            _cache.addObjectToCache(object);
            _showToast(context, 'Добавлено в избранное');
          },
          icon: const Icon(Icons.card_travel_outlined, size: 30));
    }
  }
}
