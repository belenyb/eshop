String capitalize(text) {
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

getIcon(category) {
  switch (category) {
    case "electronics":
      return "📱";
    case "jewelery":
      return "💍";
    case "men's clothing":
      return "👔";
    case "women's clothing":
      return "👢";
    default:
      return "🛒";
  }
}
