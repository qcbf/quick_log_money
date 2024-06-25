import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quick_log_money/Datas/Ledger/LedgerData.dart";
import "package:quick_log_money/Datas/UserData.dart";
import "package:quick_log_money/Utilities/Def.dart";
import "package:quick_log_money/Utilities/Pages.dart";

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
      body: SafeArea(
        child: Form(
          key: _FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              _BuildTitleLogo(),
              const SizedBox(height: 30),
              _BuildUsername(),
              const SizedBox(height: 30),
              _BuildPassword(context),
              _BuildForgetPassword(context),
              const SizedBox(height: 30),
              _BuildLogin(context),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [_BuildAnonymLogin(), const SizedBox(width: 6), _BuildRegister()]),
              const SizedBox(height: 40),
              _BuildOtherLogin(),
            ],
          ),
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
  Widget _BuildLogin(BuildContext context) => Align(
        child: SizedBox(
          height: 45,
          width: 270,
          child: ElevatedButton(
            style: ButtonStyle(shape: WidgetStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
            child: Text("登录", style: Theme.of(context).textTheme.titleMedium),
            onPressed: () {
              if (_FormKey.currentState!.validate()) {
                _FormKey.currentState!.save();
                print("email: $_Username, password: $_Password");
              }
            },
          ),
        ),
      );

  ///
  Widget _BuildRegister() => SizedBox(
        width: 132,
        height: 40,
        child: ElevatedButton(onPressed: () {}, child: const Text("注册用户")),
      );

  ///
  Widget _BuildAnonymLogin() => SizedBox(
        width: 132,
        height: 40,
        child: ElevatedButton(
            onPressed: () async {
              final user = UserData(Id: 1, Name: "临时用户", RegisterDate: DateTime.now());
              final ledgerData = await LedgerData.CreateFromTemplate(user.Id, Name: "临时账本");
              if (!mounted) return;
              await Future.wait([context.read<UserProvider>().SetData(user), context.read<LedgerProvider>().SetLedgerFromData(ledgerData)]);
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, Pages.Home);
            },
            child: const Text("试用一下")),
      );

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
  Widget _BuildTitleLogo() => Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        IconPath,
        width: 64,
        height: 64,
        color: Colors.black.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.15 : 0),
        colorBlendMode: BlendMode.darken,
      ));
}
