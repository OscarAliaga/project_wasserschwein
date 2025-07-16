import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users.dart';

class UserService {
  static final _db = FirebaseFirestore.instance;
  static const _collectionName = 'Usuarios ILearn';

  /// Obtiene un usuario desde Firestore por su ID
  static Future<User> getUserById(String userId) async {
    DocumentSnapshot doc = await _db.collection(_collectionName).doc(userId).get();

    if (doc.exists) {
      return User.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      throw Exception('Usuario no encontrado');
    }
  }

  /// Guarda o actualiza un usuario en Firestore
  static Future<void> saveUser(User user) async {
    await _db.collection(_collectionName).doc(user.userId).set(user.toMap());
  }

  /// Prueba de conexión con Firestore (debug)
  static Future<void> testFirebaseConnection() async {
    try {
      final user = await getUserById("oscar123");
      print("Usuario cargado: ${user.name}, Rol: ${user.role}");
    } catch (e) {
      print("Error al cargar usuario: $e");
    }
  }
}
