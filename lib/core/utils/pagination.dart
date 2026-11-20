List<int?> buildPageWindow(int current, int total) {
  if (total <= 5) return List.generate(total, (i) => i + 1);
  if (current <= 3) return [1, 2, 3, null, total];
  if (current >= total - 2) return [1, null, total - 2, total - 1, total];
  return [1, null, current, null, total];
}
