
namespace TransportPoint {
  array<TransportPoint@> Instances;
  void LoadSingle(SValue@ sv) {
    TransportPoint@ obj = null;
    if (sv.GetType() == SValueType::Dictionary) {
      auto svClassName = sv.GetDictionaryEntry("class");
      string className = "TransportPoint";
      if (svClassName !is null && svClassName.GetType() == SValueType::String) {
        className = svClassName.GetString();
      }
      @obj = cast<TransportPoint>(InstantiateClass(className, sv));
      if (obj is null) {
        PrintError("Unable to instantiate class '" + className + "'. Did you forget to inherit from TransportPoint?");
        return;
      }
    }
    if (obj is null) {
      @obj = TransportPoint(sv);
    }
    Reflect::UnpackObject(@obj, sv, true);
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
  TransportPoint@ Get(const string &in id) {
    return Get(HashString(id));
  }
  TransportPoint@ Get(uint idHash) {
    for (uint i = 0; i < Instances.length(); i++) {
      auto obj = Instances[i];
      if (obj.m_idHash == idHash) {
        return obj;
      }
    }
    return null;
  }
}

