import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SingInEvent extends AuthEvent {
  final String email;
  final String password;

  SingInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class SingUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SingUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}


final class SingOut extends AuthEvent{}