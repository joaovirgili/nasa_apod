import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/apod_entity.dart';
import '../../../shared/formatters/date_formatter.dart';

class ApodCardWidget extends StatelessWidget {
  const ApodCardWidget({
    Key key,
    @required this.apod,
    this.onTap,
  }) : super(key: key);

  final ApodEntity apod;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: apod.validUrl,
      imageBuilder: (context, provider) {
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: [
                  Image(
                    width: double.maxFinite,
                    image: provider,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 12,
                    right: 12,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title,
                            style: const TextStyle(color: Colors.white),
                            softWrap: true,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            DateFormatter.format(apod.date),
                            style: const TextStyle(color: Colors.white),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
