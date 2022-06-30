import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_new/constants/common_size.dart';
import 'package:sample_app_new/constants/shared_pref_keys.dart';
import 'package:sample_app_new/states/user_provider.dart';
import 'package:sample_app_new/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  String? _verificationId;
  int? _forceResendingToken;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        //ignoring == true 면 이하 자식 위젯들의 터치및 스와이프등 동작 무시
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '전화번호 로그인',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: common_padding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'asset/image/padlock.png',
                          width: size.width * 0.15,
                          height: size.height * 0.15,
                        ),
                        Text(
                          '토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.',
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: common_sm_padding,
                    // ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                        focusedBorder: inputBorder,
                        border: inputBorder,
                      ),
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          return '전화번호를 다시 입력해주세요.';
                        }
                      },
                    ),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    TextButton(
                      // style: TextButton.styleFrom(
                      //   backgroundColor: Colors.grey[350],
                      // ),
                      onPressed: () async {
                        // _getAddress();
                        if (_verificationStatus ==
                            VerificationStatus.codeSending) return;

                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          print(passed);
                          final phoneNum = _phoneNumberController.text
                              .replaceFirst("0", "")
                              .replaceAll(" ", "");
                          print('phone num: ${phoneNum}');
                          if (passed) {
                            FirebaseAuth auth = FirebaseAuth.instance;

                            setState(() {
                              _verificationStatus =
                                  VerificationStatus.codeSending;
                            });

                            await auth.verifyPhoneNumber(
                              phoneNumber: '+82${phoneNum}',
                              forceResendingToken: _forceResendingToken,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                logger.d('verificationComplate: $credential');
                                await auth.signInWithCredential(credential);
                              },
                              verificationFailed:
                                  (FirebaseAuthException error) {
                                logger.e(error.message);
                                setState(() {
                                  _verificationStatus = VerificationStatus.none;
                                });
                              },
                              codeSent: (String verificationId,
                                  int? resendToken) async {
                                setState(() {
                                  _verificationStatus =
                                      VerificationStatus.codeSent;
                                });
                                _verificationId = verificationId;
                                _forceResendingToken = resendToken;
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                            setState(() {
                              _verificationStatus = VerificationStatus.codeSent;
                            });
                          }
                        }
                      },
                      child: (_verificationStatus ==
                              VerificationStatus.codeSending)
                          ? SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              '인증번호 발송',
                              style: Theme.of(context).textTheme.button,
                            ),
                    ),
                    SizedBox(
                      height: common_padding,
                    ),
                    AnimatedOpacity(
                      opacity: (_verificationStatus == VerificationStatus.none
                          ? 0
                          : 1),
                      duration: duration,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            border: inputBorder,
                          ),
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: duration,
                      height: getVerificationButtonHeight(_verificationStatus),
                      child: TextButton(
                        // style: TextButton.styleFrom(
                        //   backgroundColor: Colors.grey[350],
                        // ),
                        onPressed: () {
                          //keyboard dismiss
                          FocusManager.instance.primaryFocus?.unfocus();
                          attemptVerify(context);
                        },
                        child: (_verificationStatus ==
                                VerificationStatus.verifying)
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                '인증문자 확인',
                                style: Theme.of(context).textTheme.button,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_sm_padding;
    }
  }

  double getVerificationButtonHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48 + common_sm_padding;
    }
  }

  void attemptVerify(BuildContext context) async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _codeController.text,
      );

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.e('verification failed');
      SnackBar snackBar = SnackBar(
        content: Text(
          '입력하신 코드가 틀려요!',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });

    //data 변경시엔 read 로 watch 경우 무한 루프
    // context.read<UserProvider>().setUserAuth(true);
  }

  _getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString(SHARED_ADDRESS) ?? "";
    double lat = prefs.getDouble(SHARED_LAT) ?? 0;
    double lon = prefs.getDouble(SHARED_LON) ?? 0;
    logger.d("Address from shared pref - $address");
  }
}

enum VerificationStatus {
  none,
  codeSending,
  codeSent,
  verifying,
  verificationDone,
}
