// Copyright (c) 2012, Lukas Renggli <renggli@gmail.com>

part of critics;

class Critics {

  String library;
  String package;

  void process(String file) {

    // generate package and library path
    var filePath = new Path(file);
    var libraryPath = library == null
        ? new Path('/Applications/Dart/dart-sdk/')
        : new Path(library);
    var packagePath = package == null
        ? filePath.directoryPath.append('packages/')
        : new Path(package);

    // compile the target file
    Compilation compilation = new Compilation.library([filePath],
        libraryPath, packagePath);
    compilation.mirrors.libraries.forEach((k, v) {
      print('$k: ${v.displayName}');
    });

  }

}
