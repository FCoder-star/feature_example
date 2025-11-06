# Feature Example (Flutter)

一个围绕分页加载的 Flutter 示例集合项目，基于 `infinite_scroll_pagination` v5.1.1 与 `go_router` 实现。

包含三种布局的分页示例：
- 列表 List（PagedListView）
- 网格 Grid（PagedGridView）
- 瀑布流 Masonry（PagedMasonryGridView）

首页使用可配置的渐变卡片入口（带轻微动画）统一导航到各示例页。

---

## 运行与环境

依赖（见 `pubspec.yaml`）
- Flutter SDK: >= 3.0（本项目 `environment.sdk` 为 `^3.9.2`）
- go_router: ^14.x
- infinite_scroll_pagination: ^5.1.1

本地运行
```
flutter pub get
flutter run
```

---

## 功能概览

- 路由：使用 `go_router`，首页 → 三个分页示例，示例页返回回到首页
  - 首页入口为 ListView 卡片，背景色跟随主题
- 分页：抽象出 `IntPagingMixin<T>`，统一 `PagingController` 初始化与 `hasMore` 逻辑
- 统一状态组件（List）：加载中、空态、错误（可重试）
- Grid/Masonry 使用更紧凑的状态组件（尺寸适配网格子项）
- Mock 数据：更接近商业场景（公司/品类/状态/价格/评分/时间等），且离线友好（图片失败有占位）

---

## 目录结构

```
lib/
  main.dart                         // MaterialApp.router + go_router 挂载
  router/app_routes.dart            // 路由常量与 GoRouter 配置
  home/home_page.dart               // 首页（可配置的渐变卡片入口）

  examples/pagination/
    core/
      paged_list.dart              // 列表分页封装（PagingListener + PagedListView + RefreshIndicator）
      paging_mixin.dart            // IntPagingMixin<T>，统一 pageSize / hasMore / controller
      pagination_widgets.dart      // List 布局用的状态组件（加载/空态/错误）

    data/
      app_item.dart                // 示例数据模型
      fake_remote_api.dart         // Mock 接口（确定性伪随机，离线友好）

    grid/
      core/paged_grid.dart         // Grid 封装（PagedGridView）
      widgets/app_item_grid_tile.dart
      widgets/pagination_grid_widgets.dart // Grid/Masonry 的状态组件（紧凑版）

    masonry/
      core/paged_masonry.dart      // Masonry 封装（PagedMasonryGridView.count/extent）
      widgets/app_item_masonry_tile.dart   // 含随机高度与美化样式

  examples/pages/
    pagination_list_page.dart      // 列表示例页（使用 AppPagedList + AppItemCard）
    pagination_grid_page.dart      // 网格示例页（使用 AppPagedGrid + AppItemGridTile）
    pagination_masonry_page.dart   // 瀑布流示例页（使用 AppPagedMasonry + AppItemMasonryTile）
```

---

## 路由说明

文件：`lib/router/app_routes.dart`
- `/`                      → 首页
- `/examples/pagination/list`    → 列表分页示例
- `/examples/pagination/grid`    → 网格分页示例
- `/examples/pagination/masonry` → 瀑布流分页示例

首页使用 `context.push(routePath)` 进入示例页；返回键将 `pop` 回首页。

首页入口配置在：`lib/home/home_page.dart` 的 `_demoEntries` 列表，新增示例只需在此添加一项。

---

## 使用方式（示例）

1) 在页面中混入分页 mixin（整数翻页）
```dart
class MyPageState extends State<MyPage> with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);
}
```

2) 列表分页（List）
```dart
return AppPagedList<int, AppItem>(
  controller: pagingController,
  padding: EdgeInsets.zero,
  itemBuilder: (context, item, index) => AppItemCard(item: item),
);
```

3) 网格分页（Grid）
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

4) 瀑布流分页（Masonry）
```dart
return AppPagedMasonry<int, AppItem>.count(
  controller: pagingController,
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemBuilder: (context, item, index) => AppItemMasonryTile(item: item),
);
```

---

## 自定义与扩展

- hasMore 规则：覆写 `computeHasMore`（`lib/examples/pagination/core/paging_mixin.dart`）
  - 默认：`items.length >= pageSize` 表示还有下一页
  - 若使用 total / cursor 协议，可在页面 State 中重写该方法

- 状态组件：
  - List 使用 `pagination_widgets.dart`
  - Grid/Masonry 使用 `grid/widgets/pagination_grid_widgets.dart`
  - 均可通过 AppPagedList/AppPagedGrid/AppPagedMasonry 的 `firstPage.../newPage.../noItems...` 参数按页覆盖

- 离线与容错：
  - 图片使用 `Image.network(..., errorBuilder: ...)`，网络失败时显示占位
  - Mock 数据确定性生成，更接近商业项目

- 新增示例：
  - 新页面建议放在 `lib/examples/pages/` 下
  - 对应功能代码放入 `lib/examples/<feature>/{core,data,widgets}`
  - 在 `home_page.dart` 的 `_demoEntries` 新增入口即可

---

## 已知事项

- Masonry 示例的卡片高度为确定性“伪随机”，用于展示瀑布流效果，实际项目中请改为以内容高度为准
- 若自定义 Grid/Masonry 的状态组件，请确保组件尺寸适配子项宽度，否则可能出现布局不协调

---

## License

本项目仅用于学习与示例演示用途。
