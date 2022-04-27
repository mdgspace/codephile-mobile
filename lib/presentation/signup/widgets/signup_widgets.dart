import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../data/constants/styles.dart';
import '../../../domain/models/status.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/failures.dart';
import '../../../utils/snackbar.dart';
import '../../components/inputs/form_input.dart';
import '../../components/inputs/text_input.dart';
import '../../onboarding/widgets/onboarding_widgets.dart';
import '../bloc/sign_up_bloc.dart';
import '../verify_screen.dart';

part 'login_button.dart';
part 'next_button.dart';
part 'pop_button.dart';
part 'progress_bar.dart';
part 'resend_email_button.dart';
part 'scroll_and_nav_wrapper.dart';
part 'signup_pages.dart';
part 'snackbar_wrapper.dart';

/// Contains all components required by [SignUpScreen] as `part`s for easy importing.
