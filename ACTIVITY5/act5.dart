import 'dart:io';

void main() async {
  bool running = true;

  while (running) {
    print("What do you want to do?");
    print("1. Write a File");
    print("2. Read a File");
    print("3. Terminate");

    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        await writeFile();
        break;
      case '2':
        await readFile();
        break;
      case '3':
        running = false;
        break;
      default:
        print("Invalid choice, please select 1, 2, or 3.");
        break;
    }
  }
}

Future<void> writeFile() async {
  stdout.write("Enter the file name you want to create (include .txt extension): ");
  String fileName = stdin.readLineSync() ?? 'default.txt';

  var file = File(fileName);

  if (file.existsSync()) {
    print("File already exists. Choose a different name or delete the existing file.");
    return;
  }

  await file.create();
  print("File created: $fileName");

  stdout.write("Enter the content you want to write to the file: ");
  String content = stdin.readLineSync() ?? '';

  await file.writeAsString(content);
  print("Content written to $fileName");
  print("---------------------------");
}

Future<void> readFile() async {
  String currentDirectory = Directory.current.path;

  print("Files in current directory:");
  Directory(currentDirectory)
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith('.txt'))
      .forEach((file) => print(file.path.split(Platform.pathSeparator).last));

  stdout.write("Enter the file name you want to read: ");
  String fileName = stdin.readLineSync() ?? '';

  File file = File(fileName);

  if (file.existsSync()) {
    try {
      List<String> lines = await file.readAsLines();
      print("Contents of $fileName:");
      for (String line in lines) {
        print(line);
      }
    } catch (e) {
      print('Error reading file: $e');
    }
  } else {
    print("File does not exist.");
    print("---------------------------");
  }
}
