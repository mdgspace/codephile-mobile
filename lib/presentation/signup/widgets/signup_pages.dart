part of 'signup_widgets.dart';

Widget _pageOne() {
  return BlocBuilder<SignUpBloc, SignUpState>(
    buildWhen: (previous, current) =>
        previous.isEmailUnique ^ current.isEmailUnique,
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInput(
            hint: 'Enter your name',
            title: 'Name',
            controller: state.nameController,
            onChanged: (value) =>
                context.read<SignUpBloc>().add(NameInput(value)),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 34.r),
          FormInput(
            hint: 'Enter your email id',
            title: 'Email ID',
            controller: state.emailController,
            errorText: state.isEmailUnique ? null : AppStrings.duplicateEmail,
            onChanged: (value) =>
                context.read<SignUpBloc>().add(EmailInput(value)),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 34.r),
          Text(
            'Institute (optional)',
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.w900),
          ),
          _buildInstituteInput(),
          SizedBox(height: 8.r),
        ],
      );
    },
  );
}

Widget _buildInstituteInput() {
  return BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
    selector: (state) => state.instituteController,
    builder: (context, controller) {
      return TypeAheadFormField<String>(
        onSuggestionSelected: (value) =>
            context.read<SignUpBloc>().add(InstituteInput(value)),
        itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion)),
        textFieldConfiguration: TextFieldConfiguration(
          onSubmitted: (value) =>
              context.read<SignUpBloc>().add(InstituteInput(value)),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter the name of your institute',
            hintStyle: AppStyles.h6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.r),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
        suggestionsCallback: (pattern) {
          pattern = pattern.toLowerCase();
          return SignUpBloc.institutes.where(
            (element) => element.toLowerCase().contains(pattern),
          );
        },
      );
    },
  );
}

Widget _pageTwo() {
  return BlocBuilder<SignUpBloc, SignUpState>(
    buildWhen: (previous, current) => false,
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter handles for the platforms you use',
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 8.r),
          Text(
            "Leave it blank if you don't use it",
            style: AppStyles.h6,
          ),
          SizedBox(height: 24.r),
          _handleInput(
            context,
            state,
            platformName: 'CodeChef',
            assetPath: AppAssets.codechef,
          ),
          SizedBox(height: 16.r),
          _handleInput(
            context,
            state,
            platformName: 'HackerRank',
            assetPath: AppAssets.hackerRank,
          ),
          SizedBox(height: 16.r),
          _handleInput(
            context,
            state,
            platformName: 'Codeforces',
            assetPath: AppAssets.codeforces,
          ),
          SizedBox(height: 16.r),
          _handleInput(
            context,
            state,
            platformName: 'SPOJ',
            assetPath: AppAssets.spoj,
          ),
          SizedBox(height: 16.r),
          _handleInput(
            context,
            state,
            platformName: 'LeetCode',
            assetPath: AppAssets.leetCode,
          ),
        ],
      );
    },
  );
}

Widget _handleInput(
  BuildContext context,
  SignUpState state, {
  required String platformName,
  required String assetPath,
}) {
  return TextInput(
    hint: '$platformName handle',
    onChanged: (value) => context.read<SignUpBloc>().add(PlatformHandleInput(
          platform: platformName.toLowerCase(),
          value: value,
        )),
    controller: state.handleControllers[platformName.toLowerCase()],
    prefix: Container(
      height: 50.r,
      width: 116.r,
      margin: EdgeInsets.only(right: 10.r),
      decoration: const BoxDecoration(
        color: AppColors.transparent,
        border: Border(
          right: BorderSide(color: AppColors.grey1),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.r),
          Image.asset(
            assetPath,
            width: 20.r,
            height: 20.r,
          ),
          SizedBox(width: 10.r),
          Text(
            platformName,
            style: AppStyles.h6.copyWith(
              color: AppColors.grey3,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ),
    prefixIconConstraints: const BoxConstraints(),
  );
}

Widget _pageThree() {
  return BlocSelector<SignUpBloc, SignUpState, File?>(
    selector: (state) => state.image,
    builder: (context, image) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Upload a profile photo',
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(width: 1.sw, height: 8.r),
          Text(
            'This photo will be visible to your followers',
            style: AppStyles.h6,
          ),
          SizedBox(height: 60.r),
          GestureDetector(
            onTap: () => context.read<SignUpBloc>().add(const SelectImage()),
            child: Center(
              child: Stack(
                children: <Widget>[
                  if (image == null)
                    Container(
                      width: 180.r,
                      height: 180.r,
                      padding: EdgeInsets.all(40.r),
                      decoration: BoxDecoration(
                        color: AppColors.grey1.withOpacity(0.06),
                        border: Border.all(color: AppColors.grey1),
                        borderRadius: BorderRadius.circular(90.r),
                      ),
                      child: svg.SvgPicture.asset(
                        AppAssets.defaultUserIcon,
                        fit: BoxFit.fill,
                      ),
                    )
                  else
                    Container(
                      width: 180.r,
                      height: 180.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(image),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    bottom: 16.r,
                    child: Container(
                      width: 45.r,
                      height: 45.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        image == null ? Icons.add_rounded : Icons.edit_rounded,
                        size: 24.r,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _pageFour() {
  return BlocBuilder<SignUpBloc, SignUpState>(
    buildWhen: (previous, current) =>
        previous.obscurePassword ^ current.obscurePassword,
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Setup a username and password for Codephile',
            style: AppStyles.h4.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 24.r),
          TextInput(
            hint: 'Username',
            controller: state.usernameController,
            onChanged: (value) =>
                context.read<SignUpBloc>().add(UsernameInput(value)),
            errorText:
                state.isUsernameUnique ? null : AppStrings.duplicateUsername,
            prefix: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.r,
                vertical: 10.r,
              ),
              child: const ImageIcon(
                Svg(AppAssets.person),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 34.r),
          TextInput(
            action: TextInputAction.done,
            hint: 'Password',
            keyboard: TextInputType.visiblePassword,
            obscureText: state.obscurePassword,
            controller: state.passwordController,
            onChanged: (value) =>
                context.read<SignUpBloc>().add(PasswordInput(value)),
            prefix: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.r,
                vertical: 10.r,
              ),
              child: const ImageIcon(
                Svg(AppAssets.lock),
              ),
            ),
            suffix: IconButton(
              icon: ImageIcon(
                Svg(
                  state.obscurePassword ? AppAssets.eyeOff : AppAssets.eyeOn,
                ),
              ),
              onPressed: () =>
                  context.read<SignUpBloc>().add(const ToggleObscure()),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ],
      );
    },
  );
}

List<Widget Function()> signUpPages = [
  _pageOne,
  _pageTwo,
  _pageThree,
  _pageFour,
];
