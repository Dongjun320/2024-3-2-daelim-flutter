import 'dart:convert';

class AuthData {
  final String tokenType; // 토큰 타입
  final String token; // 액세스 토큰
  final DateTime expiresAt; // 만료 시간
  final String email; // 이메일

  AuthData({
    required this.email,
    required this.tokenType,
    required this.token,
    required this.expiresAt,
  });

  // 복사 메서드 (optional)
  AuthData copyWith({
    String? email,
    String? tokenType,
    String? token,
    DateTime? expiresAt,
  }) {
    return AuthData(
      email: email ?? this.email,
      tokenType: tokenType ?? this.tokenType,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  // Map으로 변환
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'token_type': tokenType,
      'access_token': token,
      'expires_at': expiresAt.millisecondsSinceEpoch,
    };
  }

  // Map에서 객체 생성
  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      email: map['email'],
      tokenType: map['token_type'],
      token: map['access_token'],
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expires_at']),
    );
  }

  // JSON으로 변환
  String toJson() => json.encode(toMap());

  // JSON에서 객체 생성
  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthData(tokenType: $tokenType, token: $token, expiresAt: $expiresAt)';
}
