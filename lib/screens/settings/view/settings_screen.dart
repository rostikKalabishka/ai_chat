import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:ai_chat/screens/settings/widgets/settings_action_card.dart';
import 'package:ai_chat/screens/settings/widgets/settings_toggle_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:user_repository/user_repository.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (BuildContext context, state) {
        if (state is SettingsSignOutSuccessState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const SignInRoute(), predicate: (_) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final userModel = state.userModel;
                return Column(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () => _uploadPicture(context, userModel),
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: userModel.userImage != ''
                              ? Image.network(
                                  userModel.userImage,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AssetsManager.userImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SettingsActionCard(
                        title: userModel.username, iconData: Icons.people_alt),
                    SettingsActionCard(
                        title: userModel.email, iconData: Icons.email),
                    const SettingsToggleCard(
                      title: 'Dark mode',
                      value: false,
                    ),
                    const SettingsActionCard(
                        title: 'Application info', iconData: Icons.info),
                    SettingsActionCard(
                      title: 'Sign out',
                      iconData: Icons.login,
                      iconColor: Colors.redAccent,
                      onTap: () {
                        context
                            .read<SettingsBloc>()
                            .add(SettingsSignOutEvent());
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadPicture(BuildContext context, UserModel userModel) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 40);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        context.read<UserBloc>().add(
            UpdateUserInfo(userImage: croppedFile.path, userModel: userModel));
      }
    }
  }
}
