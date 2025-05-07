camilCaseMethod(String value) {
  String valueProccess = value.replaceAll("_", " ");

  valueProccess = valueProccess.toLowerCase().trim();
  List valueList = valueProccess.split(" ");

  String camilCaseString = "";
  for (int i = 0; i < valueList.length; i++) {
    if (valueList[i].toString().trim().isNotEmpty) {
      String valueWord =
          valueList[i][0].toUpperCase() + valueList[i].substring(1);
      if (i != valueList.length - 1) {
        valueWord += " ";
      }
      camilCaseString += valueWord;
    }
  }
  return camilCaseString;
}
