# Breeze

Flutter e-commerce app (Browse Products + Product Details) powered by the
[DummyJSON](https://dummyjson.com/docs/products) REST API. All product data is
fetched dynamically; nothing about products is hardcoded.

## Features

- **Splash** with a real initialization step (warms the categories cache), then Browse Products.
- **Browse Products**
  - Debounced search (`/products/search`, 500 ms; the keyboard search key searches immediately).
  - Top departments (`/products/categories`) + "View All" sheet + filter sheet, filtering with `/products/category/{slug}`.
  - Sorting by price / rating / title (`sortBy` + `order`).
  - `Load More` (appends, 2 shimmer cards, spinner, `{n} remaining`) and numeric pagination `< Prev 1 2 3 … N Next >` (replaces the page).
  - Shimmer skeletons for: first load, search, category, sort, Load More.
  - Product card: discount badge, brand (only when present), rating, stock/`In Bag (n)`, shipping, price + strikethrough original price, `+ Add` → `✓ Added (n)`.
- **Product Details**
  - Image carousel (`PageView` + dots + zoom), discount / category badges, favorite.
  - Brand (if any), SKU, rating, `n Verified Reviews ->` (smooth scroll to reviews), stock, `#tags`.
  - Price, original price, `Save $x (y%)`, MOQ notice, 2×2 info grid, description, specs table.
  - Reviews: average, 5★–1★ distribution (count + %), review cards with initials and formatted date.
  - Bottom bar: quantity (min = MOQ, max = stock), `Add to Bag • $total`, `✓ Added to Bag (n)`, dark floating snackbar with `View Bag ->` and close.
- **Cart, wishlist and history** are shared singletons, so Browse, Details, Bag and the bottom bar are always in sync.
- **Errors**: error view with Retry, empty state for no results, safe handling of null / missing API fields.

## Tech

Flutter / Dart · `flutter_bloc` (Cubit) · `dio` · `get_it` · `equatable` ·
`cached_network_image` · `shimmer` · `intl` · `flutter_native_splash`.

Tools: Postman (API exploration and endpoint testing), Figma (design reference).
## Architecture (logic is separated from UI)

```
lib/
  app/            app widget, DI (GetIt), navigation shell + NavCubit
  core/           network (Dio, endpoints, Failure, request guard), theme,
                  shared widgets, utils (formatters, pagination window)
  features/<feature>/
    data/         models (+ calculations) and repository
    logic/        Cubit + State (no Flutter widgets imported)
    presentation/ screens and small reusable widgets
```

Rules followed in this repo:

- Widgets only render state and forward events to a Cubit. Search debounce,
  pagination, cart rules and quantity limits live in cubits / models.
- Calculations (original price, savings, rating distribution, totals) are in
  models/cubits and are unit tested.
- Widgets and classes are kept small and reusable (one responsibility per file).

More detail: [`docs/TECHNICAL_DECISIONS.md`](docs/TECHNICAL_DECISIONS.md) and
[`docs/AI_USAGE.md`](docs/AI_USAGE.md).

## Setup and run

Requirements: Flutter (stable, Dart SDK as in `pubspec.yaml`), Android Studio or VS Code.

```bash
flutter pub get
flutter run                  # run on a device / emulator
flutter test                 # unit tests (models, cubits, calculations)
flutter analyze

flutter build apk --release  # APK: build/app/outputs/flutter-apk/app-release.apk
```

## Tests

`test/` covers price / discount calculations, nullable fields, rating
distribution, cart rules (MOQ / stock), products cubit (pagination, load more,
search vs category, retry), product details cubit (quantity limits, live cart
sync) and the bottom-bar selection logic. The repository is replaced by an
in-memory fake, so tests never touch the network.

## Known limitations

- The API cannot combine search with a category filter: choosing a category clears the search and vice versa.
- Cart, wishlist and history are kept in memory (no persistence between app launches).
- Chat / notification badges, profile and Settings are static placeholders.
- The Browse "recently added" sort means "API default order" (DummyJSON has no creation date).
- Navigation uses `Navigator` (no GoRouter).
