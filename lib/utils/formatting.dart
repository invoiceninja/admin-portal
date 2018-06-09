String cleanPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll(RegExp(r'\D'), '');
}

String formatURL(String url) {
  if (url.startsWith('http')) {
    return url;
  }

  return 'http://' + url;
}


String formatAddress({dynamic object, bool isShipping = false, String delimiter = '\n'}) {
  var str = '';

  String address1 = isShipping ? object.shippingAddress1 : object.address1;
  String address2 = isShipping ? object.shippingAddress2 : object.address2;
  String city = isShipping ? object.city : object.city;
  String state = isShipping ? object.state : object.state;
  String postalCode = isShipping ? object.postalCode : object.postalCode;

  if (address1.isNotEmpty) {
    str += address1 + delimiter;
  }
  if (address2.isNotEmpty) {
    str += address2 + delimiter;
  }

  if (city.isNotEmpty || state.isNotEmpty || postalCode.isNotEmpty) {
    str += city + ',' + state + ' ' + postalCode;
  }

  return str;
}