import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({
    required this.isRight,
    required this.id,
    required this.bloc,
    super.key,
  });

  final bool isRight;
  final int id;
  final AlbumBloc bloc;

  @override
  Widget build(BuildContext context) {
    final double cm = MediaQuery.of(context).size.width * 0.95 / 21;
    final double a = cm * 7;

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
            angle: isRight ? pi / -2 : pi / 2,
            child: SizedBox(
              height: a,
              width: a,
              child: InkWell(
                onLongPress: () {
                  bloc.add(AddPhotosTogether());
                },
                onTap: () {
                  bloc.add(AddPhotoSeparately(id));
                },
                child: state.images?[id] ??
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Image.asset(
                        "assets/add_image.png",
                      ),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
