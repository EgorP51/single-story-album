import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';

class FreeSpaceWidget extends StatelessWidget {
  const FreeSpaceWidget({super.key, this.images});

  final List<Image?>? images;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          color: Colors.black,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 0.215,
                color: Colors.white,
              ),
              const Spacer(),
              const VerticalDivider(
                width: 1,
                color: Colors.white24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 1,
              ),
              const VerticalDivider(
                width: 1,
                color: Colors.white24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 1,
              ),
              const VerticalDivider(
                width: 1,
                color: Colors.white24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 7.5,
                height: MediaQuery.of(context).size.width * 0.95 / 21 * 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        crossAxisCount: 4,
                        children: List.generate(8, (index) {
                          if (images != null) {
                            return images![index] ??
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.black12,
                                  child: Image.asset(
                                    "assets/add_image.png",
                                  ),
                                );
                          }
                          return const SizedBox();
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                width: 1,
                color: Colors.white24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 7.5,
              ),
              const VerticalDivider(
                width: 1,
                color: Colors.white24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 7.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95 / 21 * 0.215,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
