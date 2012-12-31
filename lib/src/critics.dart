// Copyright (c) 2012, Lukas Renggli <renggli@gmail.com>

part of critics;

class Critics {

  Path _library;

  set library(Path path) => _library = path;

  Path get library {
    if (_library != null) {
      return _library;
    } else if (Platform.environment.containsKey('DART_SDK')) {
      return new Path(Platform.environment['DART_SDK']);
    } else {
      // TODO(renggli): figure out something better
      return new Path('/Applications/Dart/dart-sdk/');
    }
  }

  Path _package;

  set package(Path path) => _package = path;

  Path get package {
    if (_package != null) {
      return _package;
    } else {
      return entrypoints.first.directoryPath.append('packages/');
    }
  }

  List<Path> entrypoints = [];

  void process() {
    Compilation compilation = new Compilation.library(entrypoints,
        library, package);
    var libraries = compilation.mirrors.libraries.values.filter((library) {
      return !library.uri.toString().startsWith('dart:');
    });
    // TODO(renggli): do the actual critics on the libraries
  }

}
