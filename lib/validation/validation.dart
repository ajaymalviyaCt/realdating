String? notEmptyValidator(String? value) {
  var value1 = value?.trim();
  if (value1 == null || value1.isEmpty) {
    return 'Date is required';
  }
  return null; // Input is not empty
}



String? notEmptyAddValidator(String? value) {
  var value1 = value?.trim();
  if (value1 == null || value1.isEmpty) {
    return 'Address is required';
  }
  return null; // Input is not empty
}

String? notEmptyMsgValidator(String? value) {
  var value1 = value?.trim();
  if (value1 == null || value1.isEmpty) {
    return 'Message is required';
  }
  return null; // Input is not empty
}

String? validateEmailField(value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
      r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern as String);
  if (value.isEmpty) {
    return 'Email is Required.';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid Email';
  }
}

String? validatePassword(value) {
  Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
  RegExp regex = new RegExp(pattern as String);

  if (value.isEmpty) {
    return 'Password is Required.';
  } else if (value.length < 8) {
    return 'Password required at least 8 numbers';
  }
}


String? validateConfPassword(value) {
  Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
  RegExp regex = new RegExp(pattern as String);

  if (value.isEmpty) {
    return 'Confirm Password is Required.';
  } else if (value.length < 8) {
    return 'Password required at least 8 numbers';
  }
}

//
// String? validatePassword( value) {
//   RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   if (value.isEmpty) {
//     return 'Please enter password';
//   } else {
//     if (!regex.hasMatch(value)) {
//       return 'Enter valid password';
//     } else if (value.length < 8) {
//       return "Password required at least 6 numbers";
//     }
//   }
// }


//   else String passNonNullValue;
//  if (!regex.hasMatch(passNonNullValue)) {
//     return ("Password should contain upper,lower,digit and Special character ");
//   }
//   return null;
// }
//   return 'Password must contain numbers, letter, and at least six characters';


//
// String? validateConfirmPassword(value) {
//   Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
//   RegExp regex = new RegExp(pattern as String);
//
//   if (value.isEmpty) {
//     return 'ReEnter Password .';
//   } else if (value.length < 6) {
//     return 'Password required at least 6 numbers';
//   }
//   // else if (!regex.hasMatch(value))
//   //   return 'Password must contain numbers, letter, and at least six characters';
// }

/*
String? validateNewPassword(value) {
   Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$';
  // RegExp regex = new RegExp(pattern);

  if (value.isEmpty) {
    return 'New Password is Required.';
  } else  if (int.parse(value) < 8 || int.parse(value) > 10) {
    return 'New Password required at least 6 numbers';
  }
  // else if (!regex.hasMatch(value))
  //   return 'Password must contain numbers, letter, and at least six characters';
}
*/


String? validateNewPassword( value) {
  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$');
  if (value.isEmpty) {
    return 'New Password is Required';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Password must contain numbers, letter, and at least six characters';
    } else if (value.length < 8)  {
      return null;
    }
  }
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is Required.';
  } else if (value.length < 5) {
    return 'Full Name requires at least 5 characters.';
  } else if (value.contains(' ')) {
    return 'Spaces are not allowed in the Full Name.';
  }
  return null;
}





String? validateBusinessName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Business Name is Required.';
  } else if (value.contains(' ')) {
    return 'Spaces are not allowed in the Full Name.';
  }
  return null;
}




String? validateRange(value) {
  if (value.isEmpty) {
    return 'Range is Required.';
  }
}

String? validateTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Title is Required.';
  }
  return null; // Return null if validation passes
}

String? validTimeTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Time is Required.';
  }
  return null; // Return null if validation passes
}


String? validateLink(value) {
  if (value.isEmpty) {
    return 'Link is Required.';
  }
}



String? validateLocation(value) {
  if (value.isEmpty) {
    return 'Location is Required.';
  }
}
String? validateDescriptionn(value) {
  if (value.isEmpty) {
    return 'Description is Required.';
  }
}

String? validateCampaign(value) {
  if (value.isEmpty) {
    return 'Campaign Duration required';
  }
}

String? validateBudget(value) {
  if (value.isEmpty) {
    return 'Budget is Required.';
  }
}

String? validateIntrest(value) {
  if (value.isEmpty) {
    return 'Interest is Required.';
  }
}

String? validateTitleDeal(value) {
  if (value.isEmpty) {
    return 'Title Name is Required.';
  }
}

String? validatePrice(value) {
  if (value.isEmpty) {
    return 'Price is Required.';
  }
}

String? validateDiscount(value) {
  if (value.isEmpty) {
    return 'Discount is Required.';
  }
}

String? validateage(value) {
  if (value.isEmpty) {
    return 'Age is Required.';
  }
}
String? validateDeal(value) {
  if (value.isEmpty) {
    return 'Title Name is Required.';
  }
}

String? validatePromoCode(value) {
  if (value.isEmpty) {
    return 'Please enter promo code.';
  } else if (value.length < 5) {
    return 'promo code required 6 numbers';
  }
}

String? validateHome(value) {
  if (value.isEmpty) {
    return 'Home Name is Required.';
  }
}

String? validateBlock(value) {
  if (value.isEmpty) {
    return 'Block is Required.';
  }
}

String? validateStreet(value) {
  if (value.isEmpty) {
    return 'Street is Required.';
  }
}

String? validateAppartmentNo(value) {
  if (value.isEmpty) {
    return 'Appartment no. is Required.';
  }
}

String? validateOffice(value) {
  if (value.isEmpty) {
    return 'Office is Required.';
  }
}

String? validateFloor(value) {
  if (value.isEmpty) {
    return 'Floor is Required.';
  }
}

String? validaterequired(value) {
  if (value.isEmpty) {
    return 'Required Field.';
  }
}

String? validateAddressName(value) {
  if (value.isEmpty) {
    return 'Address Name is Required.';
  }
}

String? validatecityName(value) {
  if (value.isEmpty) {
    return 'City Name is Required.';
  } else if (value.length < 3) {
    return 'City Name required at least 6 numbers';
  }
}

String? validatestateName(value) {
  if (value.isEmpty) {
    return 'State Name is Required.';
  }
}

String? validateInsta(value) {
  if (value.isEmpty) {
    return 'This field is Required.';
  }
}

String? validatelendmarkName(value) {
  if (value.isEmpty) {
    return 'Lendmark Name is Required.';
  } else if (value.length < 3) {
    return 'Lendmark Name required at least 6 numbers';
  }
}

String? validatecountryName(value) {
  if (value.isEmpty) {
    return 'Country Name is Required.';
  }
}

/*
String? validateMobile(value) {
  if (value.isEmpty) {
    return 'Phone Number is Required.';
  } else if (value.length < 10) {
    return 'Phone Number required 10 digits';
  }
}
*/

String? validateMobile( value) {




  //String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  // RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
  RegExp regExp = RegExp(r'^\+?[0-9]{10,15}$');

  if (value.length == 00) {
    return 'Please enter number';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  } else if (int.parse(value) < 10 || int.parse(value) > 10) {
    return null;
  }
}