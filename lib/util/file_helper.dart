class FileHelper {
  factory FileHelper() => _getInstance();

  static FileHelper get instance => _getInstance();
  static FileHelper _instance; // 单例对象

  static FileHelper _getInstance() {
    if (_instance == null) {
      _instance = FileHelper._internal();
    }
    return _instance;
  }

  FileHelper._internal();

  /////////////////////////////////////////////////////////////

  String sDCardDir;

  String getFileSize(int fileSize) {
    String str = '';

    if (fileSize < 1024) {
      str = '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      str = '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      str = '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }

    return str;
  }

  String selectIcon(String ext) {
    String iconImg = 'assets/images/fileIcon/unknown.png';

    switch (ext) {
      case '.ppt':
      case '.pptx':
        iconImg = 'assets/images/fileIcon/ppt.png';
        break;
      case '.doc':
      case '.docx':
        iconImg = 'assets/images/fileIcon/word.png';
        break;
      case '.xls':
      case '.xlsx':
        iconImg = 'assets/images/fileIcon/excel.png';
        break;
      case '.jpg':
      case '.jpeg':
      case '.png':
        iconImg = 'assets/images/fileIcon/image.png';
        break;
      case '.txt':
        iconImg = 'assets/images/fileIcon/txt.png';
        break;
      case '.mp3':
        iconImg = 'assets/images/fileIcon/mp3.png';
        break;
      case '.mp4':
        iconImg = 'assets/images/fileIcon/video.png';
        break;
      case '.rar':
      case '.zip':
        iconImg = 'assets/images/fileIcon/zip.png';
        break;
      case '.psd':
        iconImg = 'assets/images/fileIcon/psd.png';
        break;
      default:
        iconImg = 'assets/images/fileIcon/file.png';
        break;
    }
    return iconImg;
  }
}
