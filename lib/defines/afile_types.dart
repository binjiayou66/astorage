class AFileTypes {
  // Images
  static const String png = 'png';
  static const String jpg = 'jpg';
  static const String jpeg = 'jpeg';
  static const String gif = 'gif';
  static const List<String> imageTypes = [
    png,
    jpg,
    jpeg,
    gif,
  ];

  static bool isImage(String type) {
    return imageTypes.contains(type.toLowerCase());
  }

  // Audios
  static const String wav = 'wav';
  static const String flac = 'flac';
  static const String ape = 'ape';
  static const String alac = 'alac';
  static const String mp3 = 'mp3';
  static const String aac = 'aac';
  static const String amr = 'amr';
  static const String ogg = 'ogg';
  static const List<String> audioTypes = [
    wav,
    flac,
    ape,
    alac,
    mp3,
    aac,
    amr,
    ogg,
  ];

  static bool isAudio(String type) {
    return audioTypes.contains(type.toLowerCase());
  }

  // Office
  static const String txt = 'txt';
  static const String pdf = 'pdf';
  static const String doc = 'doc';
  static const String docx = 'docx';
  static const String xls = 'xls';
  static const String xlsx = 'xlsx';
  static const String ppt = 'ppt';
  static const String pptx = 'pptx';
  static const List<String> officeTypes = [
    txt,
    pdf,
    doc,
    docx,
    xls,
    xlsx,
    ppt,
    pptx,
  ];
  static bool isOffice(String type) {
    return officeTypes.contains(type.toLowerCase());
  }
}
