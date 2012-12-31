// Copyright (c) 2012, Lukas Renggli <renggli@gmail.com>

/**
 * Performs a static analysis on the provided dart files
 *
 *     $ dart dartcritics.dart foo.dart
 */
library dartcritics;

import 'dart:io';

import 'package:args/args.dart';
import 'package:dartcritics/critics.dart';

void printUsage(ArgParser arguments) {
  print('dartcritics [options] input.dart ...');
  print('');
  print(arguments.getUsage());
  exit(1);
}

void main() {

  // application state
  final critics = new Critics();
  final arguments = new ArgParser();

  // defines the supported arguments
  arguments.addOption('pkg',
      help: 'sets the package directory',
      callback: (value) {
        if (value != null) {
          critics.package = new Path(value);
        }
      });
  arguments.addOption('lib',
      help: 'sets the library directory',
      callback: (value)  {
        if (value != null) {
          critics.library = new Path(value);
        }
      });
  arguments.addFlag('help', negatable: false,
      help: 'show this help',
      callback: (value) {
        if (value) {
          printUsage(arguments);
        }
      });

  // process the supported arguments
  final results = arguments.parse(new Options().arguments);
  critics.entrypoints = results.rest.map((each) => new Path(each));

  // call the critics compiler
  critics.process();

}
