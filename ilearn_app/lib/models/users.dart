import '../../theme/role_theme.dart'; // Asegúrate de usar la ruta correcta

class User {
  final String userId;
  final String name;
  final String role; // Valores esperados: "student", "parent"

  User({
    required this.userId,
    required this.name,
    required this.role,
  });

  /// Getter que convierte el string 'role' en un enum UserRole
  UserRole get userRole {
    return switch (role) {
      'student' => UserRole.student,
      'parent' => UserRole.parent,
      _ => UserRole.student, // por defecto
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String id) {
    final roleValue = map['role'] ?? '';
    if (roleValue != 'student' && roleValue != 'parent') {
      throw Exception("Rol no válido: $roleValue");
    }

    return User(
      userId: id,
      name: map['name'] ?? 'Sin nombre',
      role: roleValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
    };
  }

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, role: $role)';
  }
}
