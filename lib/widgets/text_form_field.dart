import 'package:flutter/material.dart';

class CustTextForm extends StatelessWidget {
  final String titleText;
  final String hint;
  final TextEditingController textConroller;
  const CustTextForm({
    super.key,
    required this.titleText,
    required this.hint,
    required this.textConroller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          controller: textConroller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        Container(height: 25),
      ],
    );
  }
}

class CustReqTextForm extends StatelessWidget {
  final String titleText;
  final String hint;
  final TextEditingController textConroller;
  const CustReqTextForm({
    super.key,
    required this.titleText,
    required this.hint,
    required this.textConroller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          controller: textConroller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordForm({super.key, required this.passwordController});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool passShowStat = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          controller: widget.passwordController,
          obscureText: passShowStat,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passShowStat = !passShowStat;
                });
              },
              icon: passShowStat == true
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            hintText: "Enter Password",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }
}

class ConfirmPasswordForm extends StatefulWidget {
  final TextEditingController confirmPasswordController;
  final TextEditingController originalPasswordController;
  const ConfirmPasswordForm({
    super.key,
    required this.confirmPasswordController,
    required this.originalPasswordController,
  });

  @override
  State<ConfirmPasswordForm> createState() => _ConfirmPasswordFormState();
}

class _ConfirmPasswordFormState extends State<ConfirmPasswordForm> {
  bool passShowStat = true;
  bool isMatched = false;

  @override
  void initState() {
    super.initState();

    // متابعة التغيرات في الحقلين
    widget.confirmPasswordController.addListener(_checkPasswords);
    widget.originalPasswordController.addListener(_checkPasswords);
  }

  void _checkPasswords() {
    final confirm = widget.confirmPasswordController.text;
    final original = widget.originalPasswordController.text;
    final matched = confirm.isNotEmpty && confirm == original;

    if (matched != isMatched) {
      setState(() {
        isMatched = matched;
      });
    }
  }

  @override
  void dispose() {
    widget.confirmPasswordController.removeListener(_checkPasswords);
    widget.originalPasswordController.removeListener(_checkPasswords);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirm Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            if (value != widget.originalPasswordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
          controller: widget.confirmPasswordController,
          obscureText: passShowStat,
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isMatched)
                  const Icon(Icons.check_circle, color: Colors.green),
                IconButton(
                  onPressed: () {
                    setState(() {
                      passShowStat = !passShowStat;
                    });
                  },
                  icon: Icon(
                    passShowStat ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ],
            ),
            hintText: "Re-enter Password",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }
}
