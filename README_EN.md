# Feature Example

English | [简体中文](./README.md)

A collection of Flutter feature examples accumulated from daily development, documenting common interaction patterns and component implementations.

## Features

### Pagination

Pagination components based on `infinite_scroll_pagination`:
- **List** - Standard list layout with pull-to-refresh support
- **Grid** - Fixed column grid layout
- **Masonry** - Pinterest-style staggered layout

Key Features:
- Unified pagination logic via Mixin to reduce code duplication
- Complete state handling (initial load, append load, empty state, error)
- Skeleton screen loading placeholders
- Customizable state components

### Dismissible Image Viewer

WeChat Moments-style image viewer
- Multi-directional swipe-to-dismiss gestures (up, down, left, right)
- Seamless Hero animation transitions
- Image loading progress and error handling

### Shimmer Skeleton

Loading placeholder animations based on `shimmer` package
- Custom Shimmer components
- Skeleton cards for pagination
- Adjustable animation speed and colors

### Theme & Styling

Homepage interaction design:
- Tech-inspired gradient backgrounds (dynamic)
- Grid pattern + floating light particle effects
- Glassmorphism cards
- Shine animation on cards

---

## Requirements

- Flutter SDK >= 3.0
- Corresponding Dart SDK version

## Main Dependencies

```yaml
dependencies:
  go_router: ^14.2.0               # Routing
  infinite_scroll_pagination: ^5.1.1  # Pagination
  dismissible_page: ^1.0.2         # Dismissible viewer
  shimmer: ^3.0.0                  # Skeleton animation
```

## Quick Start

```bash
flutter pub get
flutter run
```

---

## Project Structure

```
lib/
  main.dart                         // App entry point
  router/app_routes.dart            // GoRouter configuration
  home/home_page.dart               // Homepage (animated gradient card entries)

  shared/
    widgets/tech_background.dart    // Tech-themed background component

  examples/
    pagination/                     // Pagination examples
      core/
        paged_list.dart            // List pagination wrapper
        paging_mixin.dart          // Pagination logic mixin
        pagination_widgets.dart    // State widgets (loading/empty/error)
      data/
        app_item.dart              // Data model
        fake_remote_api.dart       // Mock API
      grid/
        core/paged_grid.dart       // Grid pagination wrapper
        widgets/                   // Grid item widgets
      masonry/
        core/paged_masonry.dart    // Masonry pagination wrapper
        widgets/                   // Masonry item widgets
      list/
        core/paged_list.dart       // List pagination wrapper
        widgets/                   // List item widgets
      pages/                       // Example pages
      widgets/
        skeleton_theme.dart        // Skeleton theme

    dismissible/
      pages/dismissible_demo_page.dart  // Dismissible image demo

    shimmer/
      pages/shimmer_demo_page.dart      // Shimmer effect demo
      widgets/custom_shimmer.dart       // Custom Shimmer widget
```

---

## Routing

File: `lib/router/app_routes.dart`

| Path | Page |
|------|------|
| `/` | Homepage |
| `/examples/pagination/list` | List pagination demo |
| `/examples/pagination/grid` | Grid pagination demo |
| `/examples/pagination/masonry` | Masonry pagination demo |
| `/examples/dismissible` | Dismissible image demo |
| `/examples/shimmer` | Shimmer skeleton demo |

---

## Code Snippets

### Pagination Mixin

```dart
class MyPageState extends State<MyPage> with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);
}
```

### List Pagination

```dart
return AppPagedList<int, AppItem>(
  controller: pagingController,
  padding: EdgeInsets.zero,
  itemBuilder: (context, item, index) => AppItemCard(item: item),
);
```

### Grid Pagination

```dart
return AppPagedGrid<int, AppItem>(
  controller: pagingController,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 3/4,
  ),
  itemBuilder: (context, item, index) => AppItemGridTile(item: item),
);
```

### Masonry Pagination

```dart
return AppPagedMasonry<int, AppItem>.count(
  controller: pagingController,
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemBuilder: (context, item, index) => AppItemMasonryTile(item: item),
);
```

### TechScaffold Background

```dart
return TechScaffold(
  title: 'Page Title',
  variant: TechBackgroundVariant.purple,
  gradientColors: const [Color(0xFF8360c3), Color(0xFF2ebf91)],
  body: YourContent(),
);
```

---

## Customization

### Custom Pagination End Condition

Override the `computeHasMore` method to customize pagination end logic:

```dart
@override
bool computeHasMore(List<AppItem> items) {
  // Default: items.length >= pageSize indicates more pages
  // Customize based on API's total or hasNext field
  return items.length >= pageSize;
}
```

### Custom State Widgets

Pagination components support custom loading, empty, and error state UI:

**List Layout** (`pagination_widgets.dart`):
```dart
AppPagedList(
  firstPageErrorIndicatorBuilder: (context) => CustomErrorWidget(),
  newPageErrorIndicatorBuilder: (context) => CustomLoadMoreError(),
  noItemsFoundIndicatorBuilder: (context) => CustomEmptyWidget(),
)
```

**Grid/Masonry Layout** (`pagination_grid_widgets.dart`):
```dart
AppPagedGrid(
  firstPageErrorIndicatorBuilder: (context) => SliverFillRemaining(...),
  noItemsFoundIndicatorBuilder: (context) => SliverFillRemaining(...),
)
```

### Adding New Examples

1. Create directory under `lib/examples/<feature>/`
2. Add `core`, `data`, `widgets`, `pages` subdirectories as needed
3. Add route configuration in `router/app_routes.dart`
4. Add entry card to `_demoEntries` list in `home/home_page.dart`

---

## Design Guidelines

### Color Theme

| Type | Colors |
|-----|-----|
| Dark Background | `#0F0F23` `#1A1A3E` `#0D1B2A` |
| Accent | `#6366F1` `#8B5CF6` |
| Card | White + Shadow |

### TechBackground Variants

- `primary` - Deep blue-purple gradient
- `cyan` - Cyan gradient
- `purple` - Purple gradient
- `green` - Green gradient

---

## Notes

- Masonry example uses deterministic pseudo-random card heights; real projects should calculate dynamically based on content
- Grid/Masonry custom state components should use Sliver widgets like `SliverFillRemaining`
- Dismissible example disables SSL verification in dev (for testing image API only); remove this in production
- Images use `errorBuilder` for failure handling; Mock data is deterministically generated and offline-friendly

---

## Roadmap

- [ ] RefreshIndicator pull-to-refresh
- [ ] Custom TabBar indicator animation
- [ ] Slidable list item dismissal
- [ ] AnimatedSwitcher page transitions
- [ ] CustomScrollView mixed scrolling layouts

---

## Technical Details

### Pagination Implementation

Uses `PagingController` from `infinite_scroll_pagination`:
- Monitors scroll position to trigger pagination
- Maintains page numbers and data state
- Unified management via Mixin

### Hero Animation

Image viewer uses `Hero` widget for shared element transitions:
```dart
Hero(
  tag: 'image_$index',
  child: Image.network(...),
)
```

### Skeleton Design

Uses Shimmer effect to simulate content loading:
- Height and width match actual content
- Uses grayscale colors to avoid interference
- Moderate animation speed (not too fast)

---

## FAQ

**Q: How to change items per page?**

A: Override the `pageSize` property in your State using `IntPagingMixin`:
```dart
@override
int get pageSize => 20; // Default is 10
```

**Q: How to integrate with real API?**

A: Implement the `fetchPage` method to call your API:
```dart
@override
Future<List<AppItem>> fetchPage(int pageKey) async {
  final response = await http.get('/api/items?page=$pageKey');
  return (json.decode(response.body) as List)
      .map((e) => AppItem.fromJson(e))
      .toList();
}
```

**Q: How to customize gradient colors?**

A: Use the `gradientColors` parameter of `TechScaffold`:
```dart
TechScaffold(
  gradientColors: const [Color(0xFFFF6B6B), Color(0xFF4ECDC4)],
  // ...
)
```

**Q: How to handle image loading failures?**

A: The example already uses `errorBuilder` to display an error icon. Customize as needed:
```dart
Image.network(
  url,
  errorBuilder: (context, error, stackTrace) {
    return YourCustomErrorWidget();
  },
)
```

---

## License

MIT
