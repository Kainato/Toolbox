import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/design/images_path.dart';
import 'package:toolbox/services/auth_service.dart';
import 'package:toolbox/widgets/components/input_text_field.dart';
import 'package:toolbox/widgets/components/transparent_divider.dart';
import 'package:toolbox/widgets/layouts/background_blank.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers para os campos de email e senha
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variáveis para controlar o estado da tela, alternando entre login e cadastro
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
    setState(() {});
  }

  void setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        titulo = 'Login';
        actionButton = 'Entrar';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora!';
      } else {
        titulo = 'Cadastro';
        actionButton = 'Cadastrar';
        toggleButton = 'Já tem uma conta? Voltar para o login';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBlank(
      title: 'Bem vindo!',
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                toolboxLogo,
                width: 200,
                height: 200,
              ),
              const TransparentDivider(height: 30),
              InputTextField(
                controller: emailController,
                label: 'Email',
                hint: 'Digite seu email',
                errorLabel: 'Por favor, insira um email válido.',
                keyboardType: TextInputType.emailAddress,
              ),
              const TransparentDivider(),
              InputTextField(
                controller: passwordController,
                obscureText: true,
                label: 'Senha',
                hint: 'Digite sua senha',
                errorLabel: 'Por favor, insira uma senha válida.',
                keyboardType: TextInputType.visiblePassword,
              ),
              const TransparentDivider(),
              ElevatedButton(
                onPressed: () => _loginRegister(
                  context,
                  isLoading: isLoading,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: isLoading
                      ? const [CircularProgressIndicator()]
                      : [Text(actionButton)],
                ),
              ),
              const TransparentDivider(),
              TextButton(
                onPressed: () => setFormAction(!isLogin),
                child: Text(toggleButton),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _loginRegister(
    BuildContext context, {
    required bool isLoading,
  }) async {
    // Função para realizar o login ou cadastro do usuário
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      // Se o formulário for válido, realizar o login ou cadastro
      if (isLogin) {
        // Realizar login
        try {
          await context.read<AuthService>().login(
                email: emailController.text,
                senha: passwordController.text,
              );
        } on AuthException catch (e) {
          // Exibir mensagem de erro
          context.mounted
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message),
                  ),
                )
              : null;
        }
        setState(() => isLoading = false);
      } else {
        // Realizar cadastro
        try {
          await context.read<AuthService>().register(
                email: emailController.text,
                senha: passwordController.text,
              );
        } on AuthException catch (e) {
          // Exibir mensagem de erro
          context.mounted
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message),
                  ),
                )
              : null;
        }
        setState(() => isLoading = false);
      }
    } else {
      // Se o formulário não for válido, exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente!'),
        ),
      );
    }
  }
}
