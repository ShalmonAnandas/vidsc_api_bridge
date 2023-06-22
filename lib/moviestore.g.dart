// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviestore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStore, Store {
  late final _$titleListAtom =
      Atom(name: '_MovieStore.titleList', context: context);

  @override
  List<String> get titleList {
    _$titleListAtom.reportRead();
    return super.titleList;
  }

  @override
  set titleList(List<String> value) {
    _$titleListAtom.reportWrite(value, super.titleList, () {
      super.titleList = value;
    });
  }

  late final _$idListAtom = Atom(name: '_MovieStore.idList', context: context);

  @override
  List<int> get idList {
    _$idListAtom.reportRead();
    return super.idList;
  }

  @override
  set idList(List<int> value) {
    _$idListAtom.reportWrite(value, super.idList, () {
      super.idList = value;
    });
  }

  late final _$posterPathListAtom =
      Atom(name: '_MovieStore.posterPathList', context: context);

  @override
  List<String> get posterPathList {
    _$posterPathListAtom.reportRead();
    return super.posterPathList;
  }

  @override
  set posterPathList(List<String> value) {
    _$posterPathListAtom.reportWrite(value, super.posterPathList, () {
      super.posterPathList = value;
    });
  }

  late final _$overviewListAtom =
      Atom(name: '_MovieStore.overviewList', context: context);

  @override
  List<String> get overviewList {
    _$overviewListAtom.reportRead();
    return super.overviewList;
  }

  @override
  set overviewList(List<String> value) {
    _$overviewListAtom.reportWrite(value, super.overviewList, () {
      super.overviewList = value;
    });
  }

  late final _$getMoviesAsyncAction =
      AsyncAction('_MovieStore.getMovies', context: context);

  @override
  Future<List<String>> getMovies(String movieTitle) {
    return _$getMoviesAsyncAction.run(() => super.getMovies(movieTitle));
  }

  late final _$playMovieAsyncAction =
      AsyncAction('_MovieStore.playMovie', context: context);

  @override
  Future<void> playMovie(int id) {
    return _$playMovieAsyncAction.run(() => super.playMovie(id));
  }

  @override
  String toString() {
    return '''
titleList: ${titleList},
idList: ${idList},
posterPathList: ${posterPathList},
overviewList: ${overviewList}
    ''';
  }
}
