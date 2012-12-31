// Copyright (c) 2012, Lukas Renggli <renggli@gmail.com>

part of critics;

class Critics {

  Path library;

  Path package;

  void process(Path file) {

    // generate package and library path
    var libraryPath = library == null
        ? file.directoryPath.append('/')
        : package;
    var packagePath = package == null
        ? file.directoryPath.append('packages/')
        : package;

    Compilation compilation = new Compilation(file, libraryPath, packagePath);

    print(compilation);

  }

}
