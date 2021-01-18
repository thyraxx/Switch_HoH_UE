
namespace PlayerComboStyle {
  array<PlayerComboStyle@> Instances;
  void LoadSingle(SValue@ sv) {
    PlayerComboStyle@ obj = null;
    if (sv.GetType() == SValueType::Dictionary) {
      auto svClassName = sv.GetDictionaryEntry("class");
      string className = "PlayerComboStyle";
      if (svClassName !is null && svClassName.GetType() == SValueType::String) {
        className = svClassName.GetString();
      }
      @obj = cast<PlayerComboStyle>(InstantiateClass(className, sv));
      if (obj is null) {
        PrintError("Unable to instantiate class '" + className + "'. Did you forget to inherit from PlayerComboStyle?");
        return;
      }
    }
    if (obj is null) {
      @obj = PlayerComboStyle(sv);
    }
    Instances.insertLast(obj);
  }
  void LoadMultiple(SValue@ sv) {
    if (sv.GetType() != SValueType::Array) {
      PrintError("SValue must be an array!");
      return;
    }
    auto arr = sv.GetArray();
    for (uint i = 0; i < arr.length(); i++) {
      LoadSingle(arr[i]);
    }
  }
  PlayerComboStyle@ Get(const string &in id) {
    return Get(HashString(id));
  }
  PlayerComboStyle@ Get(uint idHash) {
    for (uint i = 0; i < Instances.length(); i++) {
      auto obj = Instances[i];
      if (obj.m_idHash == idHash) {
        return obj;
      }
    }
    return null;
  }
}

