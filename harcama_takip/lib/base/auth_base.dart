abstract class AuthBase{
  Future<dynamic>signInWithEmailAndPassword(String mail,String password);
  Future<void>signOut();
  Future<dynamic>signUpWithEmailAndPassword(String email,String password,String userName,String fullName);
}