# Technical Decisions — Breeze

## 1. Architecture
Feature-first folders (`features/<feature>/{data,logic,presentation}`) plus a small `core/`
(network, theme, shared widgets, utils) and `app/` (DI, navigation shell).
Why: UI, business logic, models and API access are separated, features can be changed
independently, and logic classes import no Flutter widgets so they are unit-testable.
I did not add a full Clean Architecture domain layer (entities / use cases) because it would
be over-engineering for this project's scope.

## 2. State management — Cubit (flutter_bloc)
Cubit gives explicit, immutable states (`Equatable`) with far less boilerplate than full Bloc
events. Products, Cart, Wishlist, History, Product Details and Navigation each have a Cubit.
Cart / Wishlist / History are singletons registered in GetIt, so every screen reads the same state.

## 3. API integration
- Before writing any code, I tested all the required endpoints in Postman to check the JSON
  structure, the optional fields (e.g. missing `brand`), and how `sortBy` / `order` behave
  together with search and category filters.
- `dio` client + `ProductRepository`; all six required endpoints are used.
- Pagination: `limit` / `skip`; numeric pagination replaces the list, "Load More" appends.
- Search: 500 ms debounce (`Timer`), immediate search on keyboard submit.
- Stale requests are cancelled with a `CancelToken` so an old response never overwrites a newer one.
- Errors are mapped to a `Failure` type; screens show an error view with **Retry**, and an
  empty state when a search has no results.
- Limitation: the API cannot combine search + category, so choosing one clears the other.

## 4. Data modeling
- `brand` is `String?` and is shown only when present (`hasBrand`).
- Numeric fields are parsed as `num` then `.toDouble()`; missing values fall back to safe defaults.
- Calculations live in the model: `originalPrice = price / (1 - discount/100)`,
  `savedAmount`, rating distribution (`RatingSummary.fromReviews`).

## 5. Cart & wishlist synchronization
`CartCubit` / `WishlistCubit` are the single source of truth. Product cards, the details
screen, the Bag tab and the bottom-bar badge all listen to them (`BlocSelector`), and
`ProductDetailsCubit` subscribes to the cart stream, so a change anywhere updates everywhere instantly.
Quantity rules (min = MOQ, max = stock) are enforced in `CartCubit.clampQuantity`.

## 6. Performance
`cached_network_image` for image caching, `shimmer` skeletons that match the card layout
(first load, search, category, sort, load more), slivers for the product list, small `const`
widgets, `BlocSelector` / `buildWhen` to limit rebuilds, request cancellation.

## 7. Responsiveness
Layouts use `Expanded`, `Wrap`, `FittedBox(scaleDown)` and `SafeArea` instead of fixed widths,
so text and prices shrink instead of overflowing on narrow phones.

## 8. AI assistance
I used Claude (free web interface, then Claude Code in Claude Desktop with the Flutter-Craft
plugin) for planning, architecture discussion, examples for models / API integration / Cubits,
debugging, and test scenarios. Details and the full conversation history:
[`AI_USAGE.md`](AI_USAGE.md).

Decisions and changes I made myself:
- Chose Cubit over full Bloc, `Navigator` over GoRouter, and a feature-first structure
  without a full Clean Architecture domain layer.
- Split large generated files into small reusable widgets and moved logic out of widgets
  into Cubits and models.
- Added GetIt to centralize creation of the repository and Cubits.
- Adjusted the UI manually against Figma and on a real device.
- Tested the API myself in Postman and handled the DummyJSON limitation that search and
  category cannot be combined.