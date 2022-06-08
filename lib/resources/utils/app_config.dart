class AppEnvironment {
  AppEnvironment._(
      {required this.apiBaseUrl,
      required this.imageUrl,
      required this.oneSignalAppId,
      required this.defaultBranchApiKey,
      this.isDev = true});

  final String apiBaseUrl;
  final String imageUrl;
  final String defaultBranchApiKey;
  final String oneSignalAppId;
  final bool isDev;

  factory AppEnvironment.dev() {
    return AppEnvironment._(
      apiBaseUrl: "http://localhost:5001",
      imageUrl: "",
      defaultBranchApiKey: "",
      oneSignalAppId: "",
    );
  }

  factory AppEnvironment.live() {
    return AppEnvironment._(
      apiBaseUrl: "http://103.75.186.229",
      imageUrl: "",
      defaultBranchApiKey: "",
      oneSignalAppId: "",
      isDev: false,
    );
  }
}
