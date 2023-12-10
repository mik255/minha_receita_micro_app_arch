extension ConvertToDate on String {
  DateTime coreExtensionsConvertToDate() {
    var date = DateTime.parse(this);
    return date;
  }
}
