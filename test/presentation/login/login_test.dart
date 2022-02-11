import 'package:bloc_test/bloc_test.dart';
import 'package:codephile/data/services/remote/api_service.dart';
import 'package:codephile/domain/models/status.dart';
import 'package:codephile/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void blocTests() {
  group('LoginBloc - ', () {
    setUpAll(ApiService.init);

    test('emits correct initial state', () {
      final bloc = LoginBloc();
      expect(
        bloc.state,
        const LoginState(
          rememberMe: true,
          isUsernameFocused: false,
          isPasswordFocused: false,
          obscurePassword: true,
          showDialog: false,
          status: Status(),
          username: '',
          password: '',
        ),
      );
    });

    group('toggles - ', () {
      blocTest<LoginBloc, LoginState>(
        'obscure password',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const ToggleObscure())
          ..add(const ToggleObscure()),
        expect: () => const <LoginState>[
          LoginState(obscurePassword: false),
          LoginState(),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'remember me',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const ToggleRememberMe())
          ..add(const ToggleRememberMe()),
        expect: () => const <LoginState>[
          LoginState(rememberMe: false),
          LoginState(),
        ],
      );
    });

    group('text fields - ', () {
      blocTest<LoginBloc, LoginState>(
        'tracks focus correctly',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const UsernameInput(''))
          ..add(const PasswordInput(''))
          ..add(const UsernameInput('A')),
        expect: () => const <LoginState>[
          LoginState(isUsernameFocused: true),
          LoginState(isPasswordFocused: true),
          LoginState(isUsernameFocused: true, username: 'A'),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits username and password entered',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const UsernameInput('username'))
          ..add(const PasswordInput('password')),
        expect: () => const <LoginState>[
          LoginState(
            username: 'username',
            isUsernameFocused: true,
          ),
          LoginState(
            username: 'username',
            password: 'password',
            isPasswordFocused: true,
          ),
        ],
      );
    });

    test('calculates state of login button', () async {
      final bloc = LoginBloc();
      expect(bloc.state.isLoginButtonActive(), false);

      bloc.emit(bloc.state.copyWith(username: 'username'));
      expect(bloc.state.isLoginButtonActive(), false);

      bloc.emit(bloc.state.copyWith(password: 'password'));
      expect(bloc.state.isLoginButtonActive(), true);

      bloc.emit(bloc.state.copyWith(status: const Status.loading()));
      expect(bloc.state.isLoginButtonActive(), false);

      bloc.emit(bloc.state.copyWith(
        status: const Status.error('error message'),
      ));
      expect(bloc.state.isLoginButtonActive(), true);

      bloc.emit(bloc.state.copyWith(status: const Status()));
      expect(bloc.state.isLoginButtonActive(), true);

      bloc.emit(bloc.state.copyWith(password: ''));
      expect(bloc.state.isLoginButtonActive(), false);
    });

    group('forgot password dialog - ', () {
      blocTest<LoginBloc, LoginState>(
        'opens dialog',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(const ToggleDialog()),
        expect: () => const <LoginState>[LoginState(showDialog: true)],
      );

      blocTest<LoginBloc, LoginState>(
        'exits dialog without entering anything',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const ToggleDialog())
          ..add(const ToggleDialog()),
        expect: () => const <LoginState>[
          LoginState(showDialog: true),
          LoginState(),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'exits dialog after entering email',
        build: () => LoginBloc(),
        act: (bloc) => bloc
          ..add(const ToggleDialog())
          ..add(const ToggleDialog(email: 'john.doe@example.com')),
        expect: () => const <LoginState>[
          LoginState(showDialog: true),
          LoginState(status: Status.loading()),
        ],
      );
    });

    group('submit - ', () {
      blocTest<LoginBloc, LoginState>(
        'does nothing if fields are empty',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(const Submit()),
        expect: () => const <LoginState>[],
      );

      blocTest<LoginBloc, LoginState>(
        'submits if fields are filled',
        build: () => LoginBloc(),
        seed: () => const LoginState(
          username: 'username',
          password: 'password',
        ),
        act: (bloc) => bloc.add(const Submit()),
        expect: () => const <LoginState>[
          LoginState(
            username: 'username',
            password: 'password',
            status: Status.loading(),
          ),
        ],
      );
    });
  });
}
