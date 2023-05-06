bool isRelease() {
  bool isRelease;
  const bool.fromEnvironment('dart.vm.product')
      ? isRelease = true
      : isRelease = false;
  return isRelease;
}
