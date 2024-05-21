class ImageModel {
  String? url;
  String? errorMessage;

  ImageModel({this.url, this.errorMessage});

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['url'],
      errorMessage: map['errorMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'errorMessage': errorMessage,
    };
  }

  setErrorMessage(String message) {
    errorMessage = message;
  }

  getErrorMessage() {
    return errorMessage;
  }

  setUrl(String url) {
    this.url = url;
  }

  getUrl() {
    return url;
  }
}
