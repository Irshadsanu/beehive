import 'package:beehive/QmchScreens/userRegistrationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Screens/home_screen.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/login_provider.dart';
import '../providers/main_provider.dart';



enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;
  bool isHovering = false;

  @override
  void initState() {
    getPackageName();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}packagenameee");
    setState(() {

    });
  }

  Future<void> signInWithPhoneAuthCredential(BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          LoginProvider loginProvider = LoginProvider();
          // callNext(HomeScreenNew(), context);
          loginProvider.userAuthorized(LoginUser.phoneNumber, context);

          // callNextReplacement(AdminHomeScreen(), context);

          if (kDebugMode) {
            print("Login SUccess");

          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
          backgroundColor: Colors.black,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }

  Widget getMobileFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);
    return  WillPopScope(
      onWillPop: () async {
        finish(context);
        return true;
      },
      child: Scaffold(


        appBar: AppBar(
          backgroundColor: myWhite,
          centerTitle: true,
          elevation: 0,
          leading: Center(
            child:
            packageName =='com.spine.qmch'?
            InkWell(
              onTap: () {
                finish(context);
              },
              child:CircleAvatar(
                radius: 19,
                backgroundColor: myBlack.withOpacity(0.05),
                child: const Padding(
                  padding: EdgeInsets.only(left:5.0),
                  child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
                ),
              ),
            ):const SizedBox(),
          ),
          title: const Text(
            "Login",style: TextStyle(
              color: myBlack,
              fontSize: 15,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5
          ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex:1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 113,
                    // color: Colors.green,
                    child: Image.asset("assets/qmchBg.png"),
                  ),
                  const SizedBox(height: 8,),
                  const Text(
                    'QUAID-E-MILLATH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myBlack,
                      fontSize: 14,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                      height: 1,
                      // height: 0,
                    ),
                  ),
                  const Text(
                    'CENTRE FOR HUMANITY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myBlack,
                      fontSize: 14,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 18, right: 18,top: 10),//280
                    child: TextFormField(
                      controller: phoneController,
                      onChanged: (value) {
                        if (value.length == 10) {
                          showTick = true;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        } else {
                          showTick = false;
                        }

                        setState(() {});
                      },
                      style:  const TextStyle(color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w100,),
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterStyle: const TextStyle(color:c_Grey),
                        hintStyle:   TextStyle(
                          color: Colors.black.withOpacity(0.4000000059604645),
                          fontSize: 15,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Mobile Number',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:  const BorderSide(
                              color: Colors.white
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:  const BorderSide(
                              color: Colors.white
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:  const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ///
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if(phoneController.text!=''&&phoneController.text!='null'){
                          db.collection('USERS').where('PHONE_NUMBER',isEqualTo: "+91${phoneController.text}").get().then((value) async {
                            if(value.docs.isNotEmpty){
                              setState(() {
                                if (phoneController.text.length == 10) {
                                  showLoading = true;
                                }
                              });
                              await auth.verifyPhoneNumber(
                                  phoneNumber: "+91${phoneController.text}",
                                  verificationCompleted:
                                      (phoneAuthCredential) async {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Verification Completed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {}
                                  },
                                  verificationFailed:
                                      (verificationFailed) async {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("Sorry, Verification Failed"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    if (kDebugMode) {
                                      print(verificationFailed.message.toString());
                                    }
                                  },
                                  codeSent:
                                      (verificationId, resendingToken) async {
                                    setState(() {
                                      showLoading = false;
                                      currentSate = MobileVarificationState
                                          .SHOW_OTP_FORM_STATE;
                                      this.verificationId = verificationId;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "OTP sent to phone successfully"),
                                        duration:
                                        Duration(milliseconds: 3000),
                                      ));

                                      if (kDebugMode) {
                                        print("");
                                      }
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (verificationId) async {});
                            }else{
                              if(packageName.toString()!='com.spine.behiveAdmin'){
                                LoginProvider loginProvider =
                                Provider.of<LoginProvider>(context, listen: false);
                                loginProvider.clearForm();
                                callNext(UserRegistrationScreen(from: 'GENERAL'), context);
                                const snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(milliseconds: 3000),
                                    content: Text("No user Found!,Please Register",
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                const snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(milliseconds: 3000),
                                    content: Text("Admin Not Found",
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }

                            }
                          });
                        }else{
                          const snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 3000),
                              content: Text("Please enter phone number",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }


                      },
                      child: showLoading
                          ?  const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          )
                      )
                          :Container( width: width*0.9,
                        height: 50,
                        // width: 340,
                        margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                        decoration:  const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(34)),
                          gradient:  LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [cl_3F50A4, cl_253068],
                          ),

                        ),
                        child: const Center(
                          child: Text("Send OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                fontFamily: "PoppinsMedium",
                                letterSpacing: 0.39
                            ),),
                        ),
                      ),
                    ),
                  ),
                  ///
              packageName.toString()!='com.spine.qmchAdmin'?
              InkWell(
                    onTap: (){
                      LoginProvider loginProvider =
                      Provider.of<LoginProvider>(context, listen: false);
                      loginProvider.clearForm();
                      callNext(UserRegistrationScreen(from: 'GENERAL'), context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         Text("New User?",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins",
                            color: myBlack),
                         ),

                        Text(" Sign Up",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: "Poppins",color:cl_3F4FA3,decoration: TextDecoration.underline ),)

                      ],
                    ),
                  ):SizedBox(),
                  ///
                  SizedBox(height: 20,)
                ],
            )
              )
],),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 113,
                  // color: Colors.green,
                  child: Image.asset("assets/qmchBg.png"),
                ),
                const SizedBox(height: 8,),
                const Text(
                  'QUAID-E-MILLATH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                    height: 1,
                    // height: 0,
                  ),
                ),
                const Text(
                  'CENTRE FOR HUMANITY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex:1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18,top: 10
                  ),
                  child: SizedBox(
                    width: width * 1,
                    height: 70,
                    child: PinFieldAutoFill(
                      codeLength: 6,
                      focusNode: _pinPutFocusNode,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      controller: otpController,
                      currentCode: "",
                      decoration: CirclePinDecoration(
                        bgColorBuilder: const FixedColorBuilder(myWhite),
                        textStyle: const TextStyle(
                          color:myBlack,
                          fontSize: 18,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w500,
                        ),
                        strokeColorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.05)),
                      ),
                      onCodeChanged: (pin) {
                        if (pin!.length == 6) {
                          PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: pin,
                          );
                          signInWithPhoneAuthCredential(context, phoneAuthCredential);
                          otpController.text = pin;
                          setState(() {
                            Code = pin;
                          });
                        }
                      },
                    ),
                  ),
                ),

                Container(
                  width: width*0.9,
                  height: 50,
                  // width: 340,
                  margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                  decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(34)),
                    gradient:  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [cl_3F50A4, cl_253068],
                    ),

                  ),
                  child: const Center(
                    child: Text("Send OTP",
                      style: TextStyle(
                          color: myWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: "PoppinsMedium",
                          letterSpacing: 0.39
                      ),),
                  ),
                ),

                showLoading
                    ? CircularProgressIndicator(
                      color: Color(0xFF096FB2),
                    )
                    : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Already have an account?",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins",color: myBlack),),

                    Text(" Resend Now",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: "Poppins",color:clC90000,decoration: TextDecoration.underline ),)

                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
          key: scaffoldKey,
          body: Container(
            child:
            currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            // getMobileFormWidget
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
          )),
    );
  }
}
