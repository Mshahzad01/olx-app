import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../domain/providers/auth_provider.dart';
import '../widgets/social_button.dart';
import 'sigup_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(authStateProvider.notifier).signIn(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.getProportionateScreenWidth(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: SizeUtils.getProportionateScreenHeight(50)),
                // Logo or Welcome Text
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(30)),
                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter email';
                    }
                    if (!value!.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(16)),
                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                // Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(24)),
                // Sign In Button
                if (authState.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: _signIn,
                    child: const Text('Sign In'),
                  ),
                // Error Message
                if (authState.hasError)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      authState.error.toString(),
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(24)),
                // Or Divider
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Or Sign in with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(24)),
                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      icon: Icons.facebook,
                      color: Colors.blue,
                      onPressed: () {
                        // Implement Facebook sign in
                      },
                    ),
                    SocialButton(
                      icon: Icons.g_mobiledata,
                      color: Colors.red,
                      onPressed: () {
                        // Implement Google sign in
                      },
                    ),
                    SocialButton(
                      icon: Icons.apple,
                      color: Colors.black,
                      onPressed: () {
                        // Implement Apple sign in
                      },
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(24)),
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.getProportionateScreenHeight(16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
