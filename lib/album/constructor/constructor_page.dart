import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_story_album/album/@manager/album_bloc.dart';
import 'package:single_story_album/album/constructor/constructor_widget.dart';

class ConstructorPage extends StatelessWidget {
  const ConstructorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) => AlbumBloc()..add(InitialEvent()),
      child: const ConstructorWidget(),
    );
  }
}
