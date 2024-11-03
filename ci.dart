import 'dart:io';

import 'package:path/path.dart';

void main(List<String> arguments) async {
  switch (arguments.firstOrNull) {
    case 'publish':
      pubIgnore(increase: [...rustIgnores, ...nodeIgnores]);
      final args = ['pub', 'publish', ...arguments.sublist(1)];
      final code = await command('flutter', args);
      if (code != 0) exit(code);

    default:
      throw Exception('invalid arguments: $arguments');
  }
}

/// Run a command, and redirect output messages to [stdout] and [stderr].
Future<int> command(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment = true,
  bool runInShell = true,
}) async {
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    environment: environment,
    includeParentEnvironment: includeParentEnvironment,
    runInShell: runInShell,
  );
  process.stdout.forEach(stdout.add);
  process.stderr.forEach(stderr.add);
  return process.exitCode;
}

/// Generate `.pubignore` file according to `.gitignore`.
///
/// Once `.pubignore` is enabled, options in `.gitignore` won't work,
/// but usually there are many useful options in `.gitignore`
/// which are also supposed to be in the `.pubignore` configurations.
/// Copying them once `.gitignore` is modified is not only inconvenient,
/// but also error-prone. So this function helps to copy them.
///
/// 1. [increase] and [decrease] are the lines to add or remove from [base].
/// 2. [increase] will after the [decrease] process.
/// 3. The output `.pubignore` file will locate at the [workingDirectory].
/// 4. It's recommended to git ignore `.pubignore` as it is generated.
/// 5. It's recommended to [removeComments]
///    as the modified ones won't be formatted properly,
///    and such `.pubignore` is nto designed to be human-readable.
void pubIgnore({
  String workingDirectory = '.',
  String base = '.gitignore',
  List<String> increase = const [],
  List<String> decrease = const [],
  bool removeComments = true,
}) {
  // Read and process contents.
  final lines = File(base).readAsLinesSync();
  if (removeComments) {
    lines.removeWhere((line) {
      final content = line.trim();
      return content.isEmpty || content.startsWith('#');
    });
  }
  lines.removeWhere((line) => decrease.contains(line));
  lines.addAll(increase);

  File(join(workingDirectory, '.pubignore'))
    ..createSync(recursive: true)
    ..writeAsStringSync(lines.join('\n'));
}

const rustIgnores = [
  'src/',
  'Cargo.lock',
  'Cargo.toml',
  'rustfmt.toml',
];

const nodeIgnores = [
  'node_modules/',
  'package.json',
  'pnpm-lock.lock',
  'pnpm-workspace.yaml',
];
