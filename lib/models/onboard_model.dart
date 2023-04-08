class OnBoardModel {
  final String title;
  final String description;
  final String imageName;

  OnBoardModel(this.title, this.description, this.imageName);

  String get imageWithPath => 'assets/$imageName.png';
}

class OnBoardModels {
  static final List<OnBoardModel> onBoardItems = [
    OnBoardModel('Akademiyle ilgili sorun, şikayet ve önerilerini ilet', '', 'welcome_one'),
    OnBoardModel('Arkadaşlarının da desteğiyle daha hızlı geri bildirim al', '', 'welcome_two'),
  ];
}
