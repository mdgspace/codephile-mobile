import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/routes.dart';
import '../../../data/constants/styles.dart';
import '../../../domain/models/status.dart';
import '../../../utils/snackbar.dart';
import '../../components/inputs/text_input.dart';
import '../bloc/login_bloc.dart';

part 'background_decoration.dart';
part 'dialog_and_snackbar_wrapper.dart';
part 'forgot_password_button.dart';
part 'login_button.dart';
part 'remember_me_button.dart';
part 'signup_redirect_button.dart';
part 'text_fields.dart';

/// Contains all components required by [LoginScreen] as `part`s for easy importing.
