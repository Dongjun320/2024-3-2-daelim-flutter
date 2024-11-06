import 'package:daelim_project/extensions/context_extension.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  //Note: Widgit 변수
  final _currentPwController = TextEditingController();
  final _newPwController = TextEditingController();
  final _newConfirmPwController = TextEditingController();

  final _currentPwFormKey = GlobalKey<FormState>();
  final _newFormKey = GlobalKey<FormState>();
  final _newConfirmFormKey = GlobalKey<FormState>();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureNewConfirm = true;

  @override
  void dispose() {
    _currentPwController.dispose();
    _newPwController.dispose();
    _newConfirmPwController.dispose();
    super.dispose();
  }

  String? _validater(String? value) {
    if (value == null || value.isEmpty) {
      return '이 입력란을 작성하세요.';
    }
    return null;
  }

  // 비밀번호 변경
  void _onChanged() {
    final currentValidate = _currentPwFormKey.currentState?.validate() ?? false;
    final newValidate = _newFormKey.currentState?.validate() ?? false;
    final newConfirmValidate =
        _newConfirmFormKey.currentState?.validate() ?? false;

    if (!currentValidate || !newValidate || !newConfirmValidate) {
      return;
    }
    Log.green("비밀번호 변경 시작");
  }

  //비밀번호 입력 위젯
  Widget _buildTextField({
    required String hintText,
    required TextEditingController textController,
    required Key formkey,
    bool obscureText = true,
    String? Function(String? value)? validator,
    VoidCallback? onObscurePressed,
    //! validater: (p0) {}
  }) {
    return ListTile(
      dense: true,
      title: Form(
        key: formkey,
        child: TextFormField(
          controller: textController,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: false,
            suffixIcon: InkWell(
              onTap: onObscurePressed,
              child: Icon(obscureText //
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "비밀번호 변경",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            50.heightBox,
            Card(
              elevation: 0,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.theme.dividerColor,
                  )),
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    _buildTextField(
                      formkey: _currentPwFormKey,
                      textController: _currentPwController,
                      hintText: '현재 비밀번호',
                      obscureText: _obscureCurrent,
                      onObscurePressed: () {
                        setState(() {
                          _obscureCurrent = !_obscureCurrent;
                        });
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    _buildTextField(
                      formkey: _newFormKey,
                      textController: _newPwController,
                      hintText: '새 비밀번호',
                      obscureText: _obscureNew,
                      onObscurePressed: () {
                        setState(() {
                          _obscureNew = !_obscureNew;
                        });
                      },
                      validator: _validater,
                    ),
                    _buildTextField(
                        formkey: _newConfirmFormKey,
                        textController: _newConfirmPwController,
                        hintText: '현재 비밀번호',
                        validator: (value) {
                          final isEmptyValidate = _validater(value);
                          if (isEmptyValidate != null) {
                            return isEmptyValidate;
                          }
                        },
                        obscureText: _obscureNewConfirm,
                        onObscurePressed: () {
                          setState(() {
                            _obscureNewConfirm = !_obscureNewConfirm;
                          });
                        }),
                  ],
                ).toList(),
              ),
            ),

            //const Placeholder(fallbackHeight: 70),
            //const Placeholder(fallbackHeight: 70),
            //const Placeholder(fallbackHeight: 70),
            40.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E46DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                '비밀번호 변경',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
