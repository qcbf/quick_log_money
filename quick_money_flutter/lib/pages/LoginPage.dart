import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quick_money_flutter/Datas/Ledger/LedgerData.dart";
import "package:quick_money_flutter/Datas/UserData.dart";
import "package:quick_money_flutter/pages/HomePage.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _FormKey = GlobalKey<FormState>();
  late String _Username, _Password;
  bool _IsHidePwdChar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _FormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _BuildTitleLogo(),
            _BuildTitleLogoLine(),
            const SizedBox(height: 60),
            _BuildUsername(),
            const SizedBox(height: 30),
            _BuildPassword(context),
            _BuildForgetPassword(context),
            const SizedBox(height: 30),
            _BuildLoginArea(context),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_BuildAnonymLogin(), const SizedBox(width: 20), _BuildRegister()]),
            const SizedBox(height: 40),
            _BuildOtherLogin(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _BuildOtherLogin() => Column(
        children: [
          const Center(child: Text("其他账号登录", style: TextStyle(color: Colors.grey, fontSize: 14))),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              //tag wx
              IconButton(
                  icon: Icon(Icons.wechat, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: const Text("wechat login"),
                          action: SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          )),
                    );
                  }),
              //tag qq
              IconButton(
                  icon: Icon(Icons.wechat, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: const Text("wechat login"),
                          action: SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          )),
                    );
                  }),
            ],
          )
        ],
      );

  ///
  Widget _BuildLoginArea(BuildContext context) => Align(
        child: SizedBox(
          height: 45,
          width: 270,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: WidgetStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
            child: Text("登录", style: Theme.of(context).textTheme.titleMedium),
            onPressed: () {
              if (_FormKey.currentState!.validate()) {
                _FormKey.currentState!.save();
                //tag 执行登录方法
                print("email: $_Username, password: $_Password");
              }
            },
          ),
        ),
      );

  ///
  Widget _BuildRegister() => TextButton(onPressed: () {}, child: const Text("注册用户"));

  ///
  Widget _BuildAnonymLogin() => TextButton(
      onPressed: () {
        context.read<UserProvider>().SetData(UserData());
        context.read<LedgerProvider>().LoadTemplate();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: const Text("试用一下"));

  ///
  Widget _BuildForgetPassword(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigator.pop(context);
              print("忘记密码");
            },
            child: const Text("忘记密码？", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ),
        ),
      );

  ///
  Widget _BuildPassword(BuildContext context) => TextFormField(
      validator: (value) {
        if (value?.isNotEmpty != true) return "";
        return null;
      },
      obscureText: _IsHidePwdChar,
      onSaved: (v) => _Password = v!,
      decoration: InputDecoration(
          labelText: "密码",
          suffixIcon: IconButton(
            icon: Icon(_IsHidePwdChar ? Icons.remove_red_eye : Icons.password),
            onPressed: () => setState(() => _IsHidePwdChar = !_IsHidePwdChar),
          )));

  ///
  Widget _BuildUsername() => TextFormField(
        validator: (value) {
          if (value?.isNotEmpty != true) return "";
          return null;
        },
        decoration: const InputDecoration(labelText: "邮箱 或 手机号"),
        onSaved: (v) => _Username = v!,
      );

  ///
  Widget _BuildTitleLogoLine() {
    return const Divider();
  }

  ///
  Widget _BuildTitleLogo() =>
      const Padding(padding: EdgeInsets.all(8), child: Icon(IconData(0xe776, fontFamily: "Ledger")));
}
