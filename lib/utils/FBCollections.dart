abstract class FBCollections {
  static const String membership = "membership";
  static const String groups = "groups";
  static const String projects = "projects";
  static const String profiles = "profiles";
  static const String stories = "stories";
  static List<String> get collectionsList => const <String>[membership, groups, projects, profiles, stories];
}