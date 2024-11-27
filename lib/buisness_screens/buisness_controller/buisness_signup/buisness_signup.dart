import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../custom_iteam/customtextfield.dart';
import '../../../function/function_class.dart';
import '../../../validation/validation.dart';
import '../../../widgets/custom_buttons.dart';
import '../buisness_login/buisness_login.dart';
import 'buisness_signupcontroller.dart';

class BuisnessSignUp extends StatefulWidget {
  const BuisnessSignUp({super.key});

  @override
  State<BuisnessSignUp> createState() => _BuisnessSignUpState();
}

class _BuisnessSignUpState extends State<BuisnessSignUp> {
  BuisnessSignUpController buisbnesssignUpController =
      Get.put(BuisnessSignUpController());
  BuisnessSignUpController businessStateController =
      Get.put(BuisnessSignUpController());

  String countryValue = " ";
  String stateValue = " ";
  String cityValue = " ";
  String address = "";

  final _formKey = GlobalKey<FormState>();
  bool showDropdown = false;
  List<String> categories = [];

  String? BuisnessValue;








  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Fetch categories when the widget initializes
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://forreal.net:4000/fetchAllBussinessCategory'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            categories = List<String>.from(
              data['allCategory'].map((category) => category['category_name']),
            );
          });

          print('Categorie list------------${categories}');
        }
      } else {
        debugPrint('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Background 1.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220.h,
                child: Stack(
                  children: [
                    Center(
                        child: Image.asset(
                            'assets/images/AppIcon-120px-40pt@3x 1.png')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome!',
                          style: CustomTextStyle.crd,
                        ),
                        const Text(
                          'Sign up to continue',
                          style: CustomTextStyle.crd,
                        ),

                        const SizedBox(height: 30),

                        CustumTextField(
                          controller:
                              buisbnesssignUpController.buisnessnameController,
                          validator: validateBusinessName,
                          hintText: 'Business Name ',
                        ),

                        const SizedBox(height: 15),
                        CustumTextField(
                          controller:
                              buisbnesssignUpController.bemailController,
                          validator: validateEmailField,
                          hintText: 'Email',
                        ),

                        const SizedBox(height: 15),
                        Obx(
                          () => CustumTextField(
                            keyboardType: TextInputType.text,
                            onTap: () {
                              buisbnesssignUpController.seePassword.value =
                                  !buisbnesssignUpController.seePassword.value;
                            },
                            controller:
                                buisbnesssignUpController.bpasswordcontroller,
                            validator: validatePassword,
                            suffixIconn:
                                buisbnesssignUpController.seePassword == true
                                    ? 'assets/icons/Eye Slash.svg'
                                    : 'assets/icons/eye.svg',
                            hintText: 'Password',
                            obscureText:
                                buisbnesssignUpController.seePassword.value,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Obx(
                          () => CustumTextField(

                            onTap: () {
                              buisbnesssignUpController.seePassword1.value =
                                  !buisbnesssignUpController.seePassword1.value;
                            },

                            controller: buisbnesssignUpController
                                .bconfirmpasscontroller,
                            validator: validateConfPassword,
                            suffixIconn:
                                buisbnesssignUpController.seePassword1 == true
                                    ? 'assets/icons/Eye Slash.svg'
                                    : 'assets/icons/eye.svg',
                            hintText: 'Confirm Password',
                            obscureText:
                                buisbnesssignUpController.seePassword1.value,

                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        CustumNumberField(
                          maxLength: 15,
                          controller:
                              buisbnesssignUpController.bphonenoController,
                          validator: validateMobile,
                          hintText: 'Number',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),

                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: buisbnesssignUpController.categoryController,
                          readOnly: true, // Prevent manual typing
                          onTap: () {
                            setState(() {
                              showDropdown = !showDropdown; // Toggle dropdown
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Select Category",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(.15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  if(categories.isEmpty){
                                    print('Category Index-----${categories}');
                                    Fluttertoast.showToast(msg: 'Category Not found');
                                  }else{
                                    showDropdown = !showDropdown;
                                  }
                                });
                              },
                            ),
                          ),
                          cursorColor: Colors.white,
                        ),
                        if (showDropdown)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: isLoading
                                ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            )
                                : ListView.builder(
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    categories[index],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      buisbnesssignUpController.categoryController.text = categories[index];
                                      showDropdown = false; // Close dropdown
                                    });
                                  },
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 15),

                        // if (_currentPosition != null) Text(
                        //     "LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"
                        // ),

                        TextFormField(
                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                          validator: notEmptyAddValidator,

                          onChanged: (value) {
                            buisbnesssignUpController.getCoordinates(value);
                          },
                          // style: const TextStyle(color: Colors.white),
                          controller:
                              buisbnesssignUpController.addressController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  buisbnesssignUpController
                                      .getCurrentLocation();
                                  print(buisbnesssignUpController.loadAddress);
                                },
                                child: Obx(() => buisbnesssignUpController
                                        .loadAddress.value
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                    margin: EdgeInsets.all(10),
                                        child:
                                            const CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0))
                                    : const Icon(
                                        Icons.location_disabled,
                                        color: Colors.white,
                                      ))),
                            // prefixText: buisbnesssignUpController.loadAddress==true?"loading...":"",
                            /*    helperText:buisbnesssignUpController.loadAddress==true?"loading...":"" ,s,*/
                            hintText:
                                buisbnesssignUpController.currentAddress != null
                                    ? buisbnesssignUpController.currentAddress
                                        .toString()
                                    : "Address",
                            hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400),                            //counterText: "Category",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(.15),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                )),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),

                          ),

                          cursorColor: Colors.white,
                        ),
                        const SizedBox(height: 15),
                        CSCPicker(

                          ///Enable disable state dropdown [OPTIONAL PARAMETER]
                          showStates: true,

                          /// Enable disable city drop down [OPTIONAL PARAMETER]
                          showCities: true,

                          ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                          flagState: CountryFlag.DISABLE,

                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                          dropdownDecoration: BoxDecoration(
                            color: Colors.white.withOpacity(.15),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),

                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                            color: Colors.white.withOpacity(.15),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),

                          ///placeholders for dropdown search field
                          countrySearchPlaceholder: "Country",
                          stateSearchPlaceholder: "State",
                          citySearchPlaceholder: "City",

                          ///labels for dropdown
                          countryDropdownLabel: "Country",
                          stateDropdownLabel: "State",
                          cityDropdownLabel: "City",

                          ///Default Country
                          ///defaultCountry: CscCountry.India,

                          ///Country Filter [OPTIONAL PARAMETER]
                          countryFilter: const [
                            CscCountry.Afghanistan,
                            CscCountry.Aland_Islands,
                            CscCountry.Albania,
                            CscCountry.Algeria,
                            CscCountry.Andorra,
                            CscCountry.Antigua_And_Barbuda,
                            CscCountry.Argentina,
                            CscCountry.Armenia,
                            CscCountry.Australia,
                            CscCountry.Bahrain,
                            CscCountry.Bangladesh,
                            CscCountry.Barbados,
                            CscCountry.Belgium,
                            CscCountry.Belarus,
                            CscCountry.Bermuda,
                            CscCountry.Brazil,
                            CscCountry.Canada,
                            CscCountry.Cambodia,
                            CscCountry.Cayman_Islands,
                            CscCountry.Colombia,
                            CscCountry.Costa_Rica,
                            CscCountry.Cyprus,
                            CscCountry.Denmark,
                            CscCountry.Djibouti,
                            CscCountry.Dominica,
                            CscCountry.Dominican_Republic,
                            CscCountry.Ecuador,
                            CscCountry.Egypt,
                            CscCountry.El_Salvador,
                            CscCountry.Eritrea,
                            CscCountry.Ethiopia,
                            CscCountry.Equatorial_Guinea,
                            CscCountry.Falkland_Islands,
                            CscCountry.Faroe_Islands,
                            CscCountry.Fiji_Islands,
                            CscCountry.Finland,
                            CscCountry.France,
                            CscCountry.Georgia,
                            CscCountry.Gambia_The,
                            CscCountry.Germany,
                            CscCountry.Ghana,
                            CscCountry.Greece,
                            CscCountry.Greenland,
                            CscCountry.Haiti,
                            CscCountry.Heard_Island_and_McDonald_Islands,
                            CscCountry.Honduras,
                            CscCountry.Hong_Kong_S_A_R,
                            CscCountry.Hungary,
                            CscCountry.Iceland,
                            CscCountry.India,
                            CscCountry.Indonesia,
                            CscCountry.Iran,
                            CscCountry.Iraq,
                            CscCountry.Ireland,
                            CscCountry.Israel,
                            CscCountry.Italy,
                            CscCountry.Jamaica,
                            CscCountry.Japan,
                            CscCountry.Jersey,
                            CscCountry.Jordan,
                            CscCountry.Kazakhstan,
                            CscCountry.Kenya,
                            CscCountry.Korea_North,
                            CscCountry.Korea_South,
                            CscCountry.Kosovo,
                            CscCountry.Kuwait,
                            CscCountry.Kyrgyzstan,
                            CscCountry.Laos,
                            CscCountry.Latvia,
                            CscCountry.Lebanon,
                            CscCountry.Libya,
                            CscCountry.Luxembourg,
                            CscCountry.Macedonia,
                            CscCountry.Madagascar,
                            CscCountry.Malaysia,
                            CscCountry.Marshall_Islands,
                            CscCountry.Mauritania,
                            CscCountry.Mauritius,
                            CscCountry.Myanmar,
                            CscCountry.Morocco,
                            CscCountry.Mexico,
                            CscCountry.Mongolia,
                            CscCountry.Namibia,
                            CscCountry.Nepal,
                            CscCountry.New_Zealand,
                            CscCountry.Netherlands_The,
                            CscCountry.Nigeria,
                            CscCountry.Norway,
                            CscCountry.Oman,
                            CscCountry.Pakistan,
                            CscCountry.Paraguay,
                            CscCountry.Peru,
                            CscCountry.Philippines,
                            CscCountry.Poland,
                            CscCountry.Portugal,
                            CscCountry.Qatar,
                            CscCountry.Romania,
                            CscCountry.Russia,
                            CscCountry.Saudi_Arabia,
                            CscCountry.Singapore,
                            CscCountry.Sri_Lanka,
                            CscCountry.Taiwan,
                            CscCountry.Tajikistan,
                            CscCountry.Thailand,
                            CscCountry.Turkey,
                            CscCountry.Tunisia,
                            CscCountry.Uganda,
                            CscCountry.Ukraine,
                            CscCountry.United_Arab_Emirates,
                            CscCountry.United_Kingdom,
                            CscCountry.United_States,
                            CscCountry.United_States_Minor_Outlying_Islands,
                            CscCountry.Uruguay,
                            CscCountry.Uzbekistan,
                            CscCountry.Vatican_City_State_Holy_See,
                            CscCountry.Venezuela,
                            CscCountry.Vietnam,
                            CscCountry.Western_Sahara,
                            CscCountry.Wallis_And_Futuna_Islands,
                            CscCountry.Yemen,
                            CscCountry.Zambia,
                            CscCountry.Zimbabwe,
                          ],

                          ///Disable country dropdown (Note: use it with default country)
                          //disableCountry: true,

                          ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            // fontWeight: FontWeight.w600
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,

                          ),

                          ///Dialog box radius [OPTIONAL PARAMETER]
                          dropdownDialogRadius: 10.0,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          searchBarRadius: 10.0,

                          ///triggers once country selected in dropdown
                          onCountryChanged: (value) {
                            setState(() {
                              ///store value in country variable
                              buisbnesssignUpController.countryValue = value;
                              value = buisbnesssignUpController.countryValue
                                  .toString();
                            });
                          },

                          /// triggers once state selected in dropdown

                          onStateChanged: (value) {
                            setState(() {
                              ///store value in state variable
                              buisbnesssignUpController.stateValue =
                                  value.toString();
                              print("state v ${stateValue}");
                            });
                          },

                          ///triggers once city selected in dropdown
                          onCityChanged: (value) {
                            setState(() {
                              ///store value in city variable
                              buisbnesssignUpController.cityValue =
                                  value.toString();
                            });
                          },

                          ///Show only specific countries using country filter
                          currentCity: "United States",
                        ),

                        ///Show only specific countries using country filter

                        SizedBox(
                          height: 50.h,
                        ),

                        Obx(
                              () => customPrimaryBtn(
                            btnText: "Sign Up",
                            btnFun: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (buisbnesssignUpController.bpasswordcontroller.value.text == buisbnesssignUpController.bconfirmpasscontroller.value.text) {
                                  if (buisbnesssignUpController.countryValue != null && businessStateController.countryValue != null) {
                                    buisbnesssignUpController.BuisnesssignUpfunction(
                                      buisbnesssignUpController.currentPosition?.latitude ?? buisbnesssignUpController.manualLatitude,
                                      buisbnesssignUpController.currentPosition?.longitude ?? buisbnesssignUpController.manualLongitude,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please fill all the fields.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Password and confirm password don't match",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please fill all the fields.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            btnclr: Colors.white,
                            btntextclr: Colors.black,
                            loading: buisbnesssignUpController.isLoadig.value,
                          ),
                        ),

                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      //BuisnessKycVerify()
                                      const BuisnessLogin()),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                'Already have an account? Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Aboshi',
                                  color: HexColor('#FFFFFF'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}



