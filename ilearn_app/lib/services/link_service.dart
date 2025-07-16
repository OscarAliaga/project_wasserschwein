import 'package:cloud_firestore/cloud_firestore.dart';

class LinkService {
  /// Obtiene los estudiantes vinculados a un apoderado con su nombre y ID.
static Future<List<Map<String, String>>> getLinkedStudents(String parentId) async {
  try {
    final vinculosSnapshot = await FirebaseFirestore.instance
        .collection('vinculos')
        .where('parentId', isEqualTo: parentId)
        .get();

     if (vinculosSnapshot.docs.isEmpty) {
      print("⚠️ No se encontraron vínculos para el apoderado: $parentId");
    }

    final studentIds = vinculosSnapshot.docs
        .map((doc) => doc['studentId'] as String)
        .toList();

     print("🧩 IDs de estudiantes vinculados: $studentIds");

    final List<Map<String, String>> students = [];

    for (final id in studentIds) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Usuarios ILearn')
          .doc(id)
          .get();

      if (userDoc.exists) {
        final name = userDoc['name'] ?? '';
        print("✅ Estudiante encontrado: $id, nombre: $name");
        students.add({'id': id, 'name': name});
      } else {
        print("❌ No se encontró el estudiante con ID: $id");
        students.add({'id': id, 'name': 'Nombre no disponible'});
      }
    }

    return students;
  } catch (e) {
    print("❌ Error al obtener información de estudiantes vinculados: $e");
    return [];
  }
}


  /// Desvincula un estudiante de un apoderado.
  static Future<void> unlinkParentFromStudent(String parentId, String studentId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('vinculos')
          .where('parentId', isEqualTo: parentId)
          .where('studentId', isEqualTo: studentId)
          .get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("❌ Error al desvincular estudiante: $e");
      rethrow;
    }
  }

  /// Vincula un estudiante a un apoderado, si no existe ya el vínculo.
  static Future<void> linkParentToStudent(String parentId, String studentId) async {
    try {
      final collection = FirebaseFirestore.instance.collection('vinculos');

      final existing = await collection
          .where('parentId', isEqualTo: parentId)
          .where('studentId', isEqualTo: studentId)
          .get();

      if (existing.docs.isEmpty) {
        await collection.add({
          'parentId': parentId,
          'studentId': studentId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        throw Exception('El estudiante ya está vinculado.');
      }
    } catch (e) {
      print("❌ Error al vincular estudiante: $e");
      rethrow;
    }
  }
static Future<List<String>> getLinkedStudentIds(String parentId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('vinculos')
        .where('parentId', isEqualTo: parentId)
        .get();

    return snapshot.docs.map((doc) => doc['studentId'] as String).toList();
  } catch (e) {
    print("❌ Error al obtener estudiantes vinculados: $e");
    return [];
  }
}
}

