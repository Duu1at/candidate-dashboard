enum SortOption {
  name('По имени', 'name'),
  experience('По опыту', 'experience'),
  dateAdded('По дате добавления', 'date_added');

  const SortOption(this.label, this.value);
  final String label;
  final String value;
}
