import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static const usersCollection = 'allusers';

  Future<void> regUser(User user, {name, email, uid}) async {
    // Reference storageReference = FirebaseStorage.instance
    //     .ref()
    //     .child('$email/${Path.basename(photo.path)}/$uid/"profile"');
    //UploadTask uploadTask = storageReference.putFile(photo);
    // await uploadTask.then((res) {
    //   res.ref.getDownloadURL();
    // });
    //   await storageReference.getDownloadURL().then((fileURL) async {
    try {
      await FirebaseFirestore.instance.collection(usersCollection).doc(uid).set({
        'name': name,
        'email': email,
        'userid': uid,
        //'image': fileURL,
      }).then((value) {
        user.updateDisplayName(name);
        // user.updatePhotoURL(fileURL);
        user.updateEmail(email);
      });
    } catch (e) {
      print("Can not upload data: ${e.toString()}");
    }
  }
}
