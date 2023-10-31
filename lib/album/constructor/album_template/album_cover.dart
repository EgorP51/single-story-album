import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';

class AlbumCover extends StatelessWidget {
  const AlbumCover({
    super.key,
    required this.bloc,
    required this.isFront,
    required this.id,
  });

  final bool isFront;
  final int id;
  final AlbumBloc bloc;

  @override
  Widget build(BuildContext context) {
    final double cm = MediaQuery.of(context).size.width * 0.95 / 21;
    double a = cm * 7;

    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: cm * 0.21,
            horizontal: cm * 0.215,
          ),
          child: Transform.rotate(
            angle: pi / 2,
            child: SizedBox(
              height: a,
              width: a,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        bloc.add(AddPhotoSeparately(id));
                      },
                      child: Center(
                        child: state.images?[id] ??
                            Container(
                              width: double.infinity,
                              color: Colors.black12,
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                "assets/add_image.png",
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  isFront
                      ? InkWell(
                          onTap: () {
                            bloc.changeTitleDialog(context, state);
                          },
                          child: Text(
                            state.albumTitle ?? '',
                            style: GoogleFonts.merriweather(
                              fontSize: 10,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            bloc.changeDescriptionDialog(context, state);
                          },
                          child: Text(
                            state.albumDescription ?? '',
                            maxLines: null,
                            style: GoogleFonts.merriweather(
                              fontSize: 8,
                            ),
                          ),
                        ),
                  //const Spacer()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
