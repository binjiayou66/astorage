import 'dart:io';

extension FileExtention on FileSystemEntity {
  String get fileName {
    return this?.path?.split("/")?.last;
  }

  String get fileType {
    return fileName.split('.')?.last;
  }
}
