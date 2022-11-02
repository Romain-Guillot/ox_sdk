extension EnumByName<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String name) {
    try {
      return byName(name);
    } catch (e) {
      return null;
    }
  }
}