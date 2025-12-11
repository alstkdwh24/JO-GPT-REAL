import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawMenuTwo extends StatefulWidget {
  const DrawMenuTwo({super.key});

  @override
  State<StatefulWidget> createState() => _DrawMenuTwo();
}

class _DrawMenuTwo extends State<DrawMenuTwo> {
  final orangeColor = Color.fromRGBO(255, 165, 0, 1.0);
  final orangeYellow = Color.fromRGBO(244, 202, 136, 1.0);
  final orange = Color.fromRGBO(246, 234, 216, 1);
  final orangeColors = const Color(0xFFF97316);
  final blueWhite = Color.fromRGBO(252, 247, 253, 1);
  bool isLoggedIn = false;
  String nickname = "";
  String gptVersion = "";
  bool isLoading = true;

  final double titleFontSize = 32;
  final double fontSize = 18;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); //Drawer 열릴 때 로그인 상태 확인
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedNickname = prefs.getString("nickname");
    String? savedGptVersion = prefs.getString("gptVersion");

    setState(() {
      if (savedNickname != null) {
        isLoggedIn = true;
        nickname = savedNickname;
        gptVersion = savedGptVersion ?? "GPT-4.0";
      } else {
        isLoggedIn = false;
      }
      isLoading = false;
    });
  }

  Future<void> _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      isLoggedIn = false;
      nickname = "";
      gptVersion = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: blueWhite,
      width: screen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isLoggedIn
            ? _buildLoggedInView(screen)
            : _buildLoginView(screen),
      ),
    );
  }

  Widget _buildLoggedInView(double screen) {
    return ListView(
      children: [
        Container(
          width: screen,
          height: 0.26.sh,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 0.2.sw, right: 0.2.sw),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    width: 0.25.sw,
                    height: 0.11.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  Container(
                    height: 0.015.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 0.05.sh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text("별명"),
                  ),
                  Container(
                    height: 0.015.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),

                  Container(
                    height: 0.05.sh,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text("GPT버전"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginView(double screen) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(height: 0.05.sh),
        Icon(Icons.account_circle, size: 80, color: Colors.black),
        SizedBox(height: 0.06.sh),

        Container(
          height: 0.6.sh,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'JO-GPT',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 0.035.sh),
              kakaoLogin(),
              SizedBox(height: 0.025.sh),
              naverLogin(),
              SizedBox(height: 0.025.sh),
              googleLogin(),
              SizedBox(height: 0.025.sh),
              memberJoin(),
              SizedBox(height: 0.025.sh),

              memberLogin(),
              SizedBox(height: 0.025.sh),
              nonMemberLogin(),
            ],
          ),
        ),
      ],
    );
  }

  Widget kakaoLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/kakao_login_large_wide.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget naverLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF03C75A),
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: double.infinity, // 버튼 전체 너비
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 6, // 버튼의 가장 왼쪽에 딱 붙임
                child: Image.asset(
                  'assets/naver_icon.png',
                  width: 40,
                  height: 48,
                ),
              ),

              Positioned(
                left: 126,
                child: Text(
                  '네이버 로그인',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget googleLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size(double.infinity, 48),
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 14,
                child: SvgPicture.string(
                  '''
<svg width="26" height="26" viewBox="0 0 48 48">
  <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
  <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
  <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
  <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
  <path fill="none" d="M0 0h48v48H0z"/>
</svg>
              ''',
                  width: 40,
                  height: 24,
                ),
              ),
              const SizedBox(width: 12),
              Positioned(
                left: 130,
                child: Text(
                  '구글 로그인',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget memberJoin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[50],
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 8,
                child: Image.asset('assets/mail.png', width: 40, height: 36),
              ),
              const SizedBox(width: 12),
              Positioned(
                right: 90,
                child: Text(
                  'JO-GPT 회원가입',
                  style: TextStyle(color: Colors.blue, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget memberLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
          elevation: 0,

        ),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 8,
                child: Image.asset('assets/user.png', width: 40, height: 36),
              ),
              const SizedBox(width: 12),
              Positioned(
                right: 100,
                child: Text(
                  'JO-GPT 로그인',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nonMemberLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: double.infinity, // 버튼 전체 너비
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 7,
                child: Image.asset('assets/people.png', width: 40, height: 50),
              ),

              const SizedBox(width: 12),
              Positioned(
                right: 107,
                child: Text(
                  '비회원 로그인',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
