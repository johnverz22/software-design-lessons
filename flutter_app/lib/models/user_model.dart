class UserModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  UserModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(
      uid: user?.uid,
      email: user?.email,
      displayName: user?.displayName,
      photoURL: user?.photoURL,
    );
  }

  // Empty user which represents an unauthenticated user
  factory UserModel.empty() {
    return UserModel(
      uid: null,
      email: null,
      displayName: null,
      photoURL: null,
    );
  }

  bool get isAuthenticated => uid != null;
} 