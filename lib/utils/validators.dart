class Validators{
  Validators._();

  static bool username(String username) =>
      username.length>=4;
}