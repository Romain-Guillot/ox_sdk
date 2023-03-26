abstract class ModelConverter<O, D> {
  ModelConverter(this.object);

  final O object;

  D convert();
}
