import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../shared/dialog_utils.dart';
import 'user_manager.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';

  EditProfile(User? user, {super.key}) {
    if (user == null) {
      this.user = User(uname: '', fullname: '', password: '', avatarUrl: '');
    } else {
      this.user = user;
    }
  }

  late final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late User _editedUser;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') ||
        value.startsWith('https') &&
            (value.endsWith('.png') ||
                value.endsWith('.jpg') ||
                value.endsWith('.jpeg')));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });

    _editedUser = widget.user;
    _imageUrlController.text = _editedUser.avatarUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveProfileForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final userManager = context.read<UsersManager>();
      if (_editedUser.id != null) {
        userManager.editUser(_editedUser);
      }
    } catch (error) {
      await showErrorDialog(context, 'Có gì đó sai sai');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  //Dùng để ẩn văn bản (VD: Mật khẩu), nếu giá trị này được đặt thành TRUE thì sẽ ẩn đi
  // bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa hồ sơ'),
        actions: <Widget>[
          IconButton(onPressed: _saveProfileForm, icon: const Icon(Icons.save))
        ],
      ),
      
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildCircleAvatar(),
                    buildFullNameField(),
                    buildPasswordField()
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildFullNameField() {
    return TextFormField(
      initialValue: _editedUser.fullname,
      decoration: const InputDecoration(labelText: 'Fullname'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Xin hãy nhập tên.';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(fullname: value);
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      initialValue: _editedUser.password,
      decoration: const InputDecoration(labelText: 'Password'),
      textInputAction: TextInputAction.next,
      obscureText: true,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Xin hãy nhập password.';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(password: value);
      },
    );
  }

  Widget buildCircleAvatar() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(
                    side: BorderSide(
                  width: 2,
                  color: Color(0xff242f60),
                ))),
            child: ClipOval(
              child: _imageUrlController.text.isEmpty
                  ? const Text('Nhập URL')
                  : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          buildAvatarURLField()
        ],
      ),
    );
  }

  TextFormField buildAvatarURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Ảnh URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveProfileForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Hãy nhập đường link ảnh URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Hãy nhập link ảnh khả dụng URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(avatarUrl: value);
      },
    );
  }
}
