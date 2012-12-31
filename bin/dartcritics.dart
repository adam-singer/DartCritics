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
          critics.package = value;
        }
      });
  arguments.addOption('lib',
      help: 'sets the library directory',
      callback: (value)  {
        if (value != null) {
          critics.library = value;
        }
      });
  arguments.addFlag('help', negatable: false,
      help: 'show this help',
      callback: (value) {
        if (value) {
          printUsage(arguments);
        }
      });

  // parse the supported arguments
  final results = arguments.parse(new Options().arguments);

  // test if we have file to process
  if (results.rest.isEmpty) {
    printUsage(arguments);
  }

  // process each file individually
  for (var file in results.rest) {
    critics.process(file);
  }

}
