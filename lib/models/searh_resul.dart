class SearchResut {
  final bool cancel;
  final bool manual;

  SearchResut({required this.cancel, this.manual = false});

  //Hacer modificaciones nombre,description,latLong
  @override
  String toString() {
    // TODO: implement toString
    return 'cancel: ${cancel}, manual: ${manual}';
  }

}
