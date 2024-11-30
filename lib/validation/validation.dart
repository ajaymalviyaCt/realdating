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
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
      r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern as String);
  if (value.isEmpty) {
    return 'Email is Required.';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid Email';
  }
  return null;
}

String? validatePassword(value) {
  Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
  RegExp regex = RegExp(pattern as String);

  if (value.isEmpty) {
    return 'Password is Required.';
  } else if (value.length < 8) {
    return 'Password required at least 8 numbers';
  }
  return null;
}

String? validateConfPassword(value) {
  Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
  RegExp regex = RegExp(pattern as String);

  if (value.isEmpty) {
    return 'Confirm Password is Required.';
  } else if (value.length < 8) {
    return 'Password required at least 8 numbers';
  }
  return null;
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

String? validateNewPassword(value) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$');
  if (value.isEmpty) {
    return 'New Password is Required';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Password must contain numbers, letter, and at least six characters';
    } else if (value.length < 8) {
      return null;
    }
  }
  return null;
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
  }
  return null;
}

String? validateRange(value) {
  if (value.isEmpty) {
    return 'Range is Required.';
  }
  return null;
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
  return null;
}

String? validateLocation(value) {
  if (value.isEmpty) {
    return 'Location is Required.';
  }
  return null;
}

String? validateDescriptionn(value) {
  if (value.isEmpty) {
    return 'Description is Required.';
  }
  return null;
}

String? validateCampaign(value) {
  if (value.isEmpty) {
    return 'Campaign Duration required';
  }
  return null;
}

String? validateBudget(value) {
  if (value.isEmpty) {
    return 'Budget is Required.';
  }
  return null;
}

String? validateIntrest(value) {
  if (value.isEmpty) {
    return 'Interest is Required.';
  }
  return null;
}

String? validateTitleDeal(value) {
  if (value.isEmpty) {
    return 'Title Name is Required.';
  }
  return null;
}

String? validatePrice(value) {
  if (value.isEmpty) {
    return 'Price is Required.';
  }
  return null;
}

String? validateDiscount(value) {
  if (value.isEmpty) {
    return 'Discount is Required.';
  }
  return null;
}

String? validateage(value) {
  if (value.isEmpty) {
    return 'Age is Required.';
  }
  return null;
}

String? validateDeal(value) {
  if (value.isEmpty) {
    return 'Title Name is Required.';
  }
  return null;
}

String? validatePromoCode(value) {
  if (value.isEmpty) {
    return 'Please enter promo code.';
  } else if (value.length < 5) {
    return 'promo code required 6 numbers';
  }
  return null;
}

String? validateHome(value) {
  if (value.isEmpty) {
    return 'Home Name is Required.';
  }
  return null;
}

String? validateBlock(value) {
  if (value.isEmpty) {
    return 'Block is Required.';
  }
  return null;
}

String? validateStreet(value) {
  if (value.isEmpty) {
    return 'Street is Required.';
  }
  return null;
}

String? validateAppartmentNo(value) {
  if (value.isEmpty) {
    return 'Appartment no. is Required.';
  }
  return null;
}

String? validateOffice(value) {
  if (value.isEmpty) {
    return 'Office is Required.';
  }
  return null;
}

String? validateFloor(value) {
  if (value.isEmpty) {
    return 'Floor is Required.';
  }
  return null;
}

String? validaterequired(value) {
  if (value.isEmpty) {
    return 'Required Field.';
  }
  return null;
}

String? validateAddressName(value) {
  if (value.isEmpty) {
    return 'Address Name is Required.';
  }
  return null;
}

String? validatecityName(value) {
  if (value.isEmpty) {
    return 'City Name is Required.';
  } else if (value.length < 3) {
    return 'City Name required at least 6 numbers';
  }
  return null;
}

String? validatestateName(value) {
  if (value.isEmpty) {
    return 'State Name is Required.';
  }
  return null;
}

String? validateInsta(value) {
  if (value.isEmpty) {
    return 'This field is Required.';
  }
  return null;
}

String? validatelendmarkName(value) {
  if (value.isEmpty) {
    return 'Lendmark Name is Required.';
  } else if (value.length < 3) {
    return 'Lendmark Name required at least 6 numbers';
  }
  return null;
}

String? validatecountryName(value) {
  if (value.isEmpty) {
    return 'Country Name is Required.';
  }
  return null;
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

String? validateMobile(String? value) {
  // Regular expression for validating international phone numbers (with + sign)
  RegExp regExp = RegExp(r'^\+?[0-9]{8,15}$'); // Allows + and 8-15 digits

  if (value == null || value.isEmpty) {
    return 'Please enter number';
  }
  // Validate against the regex pattern
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null; // No validation errors
}
