import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/login_provider.dart';
import 'login_screen.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}


class UserRegistrationScreen extends StatefulWidget {
  String from;
   UserRegistrationScreen({Key? key,required this.from}) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  late String verificationId;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String Code = "";

  Future<void> signInWithPhoneAuthCredential(BuildContext context, PhoneAuthCredential phoneAuthCredential,String from) async {
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
          LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

          HomeProvider homeProvider =
          Provider.of<HomeProvider>(context, listen: false);

            loginProvider.registerUser(context,from);

          // LoginProvider loginProvider = LoginProvider();
          // loginProvider.userAuthorized(LoginUser.phoneNumber, context);


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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: myWhite,
        centerTitle: true,
        leading: Center(
          child: InkWell(
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
            )
          ),
        ),
        title: const Text("Registration",style: TextStyle(
            color: myBlack,
            fontSize: 15,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5
        ),
        ),
      ),
      body:  currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
      // getMobileFormWidget
          ? registrationForm(context)
          : getOtpFormWidget(context),
    );
  }

  Widget registrationForm(context){
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return  Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height:height*.05),

              Center(
                child: Container(
                  // color: Colors.red,
                  width:width*.60,
                  height:180,
                  child: Column(
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
              ),

              SizedBox(height:height*.10),

              Consumer<LoginProvider>(
                  builder: (context,value,child) {
                    return Container(
                      height: 44,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.04),
                        ),
                        shadows: [
                          const BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 5.15,
                            offset: Offset(0, 2.58),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: value.userRegNameCT,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: myBlack,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            hintText:"Name",
                            hintStyle: TextStyle(
                              color: myBlack.withOpacity(0.22),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    );
                  }
              ),

              const SizedBox(height: 10,),

              Consumer<LoginProvider>(
                  builder: (context,value,child) {
                    return Container(
                      height: 44,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.04),
                        ),
                        shadows: [
                          const BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 5.15,
                            offset: Offset(0, 2.58),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: value.userRegPhoneCT,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: myBlack,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,

                        decoration: InputDecoration(
                            hintText:"Mobile Number",
                            counterText: "",
                            hintStyle: TextStyle(
                              color: myBlack.withOpacity(0.22),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    );
                  }
              ),

              const SizedBox(height: 10,),

              // Container(
              //   height: 44,
              //   clipBehavior: Clip.antiAlias,
              //   decoration: ShapeDecoration(
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(18.04),
              //     ),
              //     shadows: [
              //       const BoxShadow(
              //         color: Color(0x0A000000),
              //         blurRadius: 5.15,
              //         offset: Offset(0, 2.58),
              //         spreadRadius: 0,
              //       )
              //     ],
              //   ),
              //   child: TextFormField(
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(
              //       color: myBlack,
              //       fontSize: 12,
              //       fontFamily: 'Poppins',
              //       fontWeight: FontWeight.w400,
              //     ),
              //
              //     decoration: InputDecoration(
              //         hintText:"Place",
              //         hintStyle: TextStyle(
              //           color: myBlack.withOpacity(0.22),
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //         ),
              //         border: InputBorder.none
              //     ),
              //   ),
              // ),

              const SizedBox(height: 10,),

              Consumer<LoginProvider>(
                  builder: (context,value1,child) {
                    return
                      showLoading
                          ?  const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          )
                      ):InkWell(onTap: () async {

                        db.collection('USERS').where('PHONE_NUMBER',isEqualTo: "+91${value1.userRegPhoneCT.text}").get().then((value) async {
                        if(value.docs.isEmpty){
                          print(' ICNFRUFRFFR');
                          if((widget.from=='SPONSOR')){
                            if((value1.userRegPhoneCT.text.length == 10)){
                              LoginProvider loginProvider =
                              Provider.of<LoginProvider>(context, listen: false);
                              loginProvider.registerUser(context,widget.from);
                            }else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Invalid mobile"),
                                duration: Duration(milliseconds: 3000),
                              ));
                            }

                          }else{
                            setState(() {
                              if (value1.userRegPhoneCT.text.length == 10) {
                                showLoading = true;
                              }
                            });
                            await auth.verifyPhoneNumber(
                                phoneNumber: "+91${value1.userRegPhoneCT.text}",
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
                          }
                        }else{
                          callNext(LoginScreen(), context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                            content: Center(child: Text("Phone number Already Exists,Please sign in!",style: TextStyle(color: Colors.white),)),
                            duration: Duration(milliseconds: 3000),
                          ));

                        }
                        });



                      },
                        child: Container(
                          alignment: Alignment.center,
                          height: 46,
                          // width: width * .80,
                          decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                color: cl1883B2,
                              ),
                              BoxShadow(
                                color: cl000000.withOpacity(0.25),
                                spreadRadius: -5.0,
                                // blurStyle: BlurStyle.inner,
                                blurRadius: 20.0,
                              ),
                            ],
                            borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                            gradient: const LinearGradient(
                              begin: Alignment(-1.00, -0.00),
                              end: Alignment(1, 0),
                              colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: myWhite,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                  }
              ),

              SizedBox(height: 5,),

              InkWell(onTap: (){
                callNext(LoginScreen(), context);
              },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyle(
                            color: myBlack,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.10,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: myBlack,
                            fontSize: 15.22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=(){
                            callNext(LoginScreen(), context);
                          },
                          text: 'Sign in ',
                          style: const TextStyle(
                            color: cl3F4FA3,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            // height: 0.12,
                            letterSpacing: 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,)


            ],
          ),
        ),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(height: height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height*0.1,),

              Column(
                children: [
                  Column(
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


                  const SizedBox(height: 280,),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 30
                        ),
                        child: Container(
                          width: width * 1,
                          height: 74,
                          child: PinFieldAutoFill(
                            codeLength: 6,
                            focusNode: _pinPutFocusNode,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            controller: otpController,
                            currentCode: "",
                            decoration: CirclePinDecoration(
                              bgColorBuilder: FixedColorBuilder(Colors.white),
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                              strokeColorBuilder: FixedColorBuilder(Colors.grey.withOpacity(0.5)),
                            ),
                            onCodeChanged: (pin) {
                              if (pin!.length == 6) {
                                PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: pin,
                                );
                                signInWithPhoneAuthCredential(context, phoneAuthCredential,widget.from);
                                otpController.text = pin;
                                setState(() {
                                  Code = pin;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container( width: width*0.9,
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
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: "PoppinsMedium",
                            letterSpacing: 0.39
                        ),),
                    ),
                  ),
                  showLoading
                      ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                      color: Color(0xFF096FB2),
                    ),
                  )
                      : Container(),

                  InkWell(onTap: (){
                    callNext(LoginScreen(), context);
                  },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,fontFamily: "Poppins",color: myBlack),),

                        Text(" Resend Now",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,fontFamily: "Poppins",color:clC90000,decoration: TextDecoration.underline ),)

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
