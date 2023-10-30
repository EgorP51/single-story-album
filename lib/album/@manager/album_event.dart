part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends AlbumEvent {}

class SaveAlbum extends AlbumEvent {}

class ShareAlbum extends AlbumEvent {}

class ChangeAlbumTitle extends AlbumEvent {
  ChangeAlbumTitle(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class ChangeAlbumDescription extends AlbumEvent {
  ChangeAlbumDescription(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class AddPhotoSeparately extends AlbumEvent {
  AddPhotoSeparately(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class AddPhotosTogether extends AlbumEvent {}
