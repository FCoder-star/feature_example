# Feature Example

日常开发中积累的 Flutter 功能示例，记录一些常见交互和组件的实现方案。

## 包含功能

### 分页加载
基于 `infinite_scroll_pagination` 封装的分页组件：
- **列表 List** - 常规列表形式，支持下拉刷新
- **网格 Grid** - 固定列数网格布局
- **瀑布流 Masonry** - Pinterest 风格错落布局

功能特性：
- 统一的分页逻辑 Mixin，减少重复代码
- 完整的状态处理（首次加载、追加加载、空数据、错误）
- 骨架屏加载占位
- 支持自定义状态组件

### 图片拖动返回
仿微信朋友圈的图片查看器
- 支持多方向手势拖拽关闭（上下左右）
- Hero 动画无缝过渡
- 图片加载进度与错误处理

### 骨架屏
基于 `shimmer` 包的加载占位动画
- 自定义 Shimmer 组件
- 配合分页使用的骨架屏卡片
- 可调节动画速度和颜色

### 主题样式
首页交互设计：
- 科技感渐变背景（动态变化）
- 网格图案 + 浮动光球粒子效果
- 玻璃态材质卡片
- 卡片内的扫光动画

---

## 环境要求

- Flutter SDK >= 3.0
- Dart SDK 对应版本

## 主要依赖

```yaml
dependencies:
  go_router: ^14.2.0               # 路由管理
  infinite_scroll_pagination: ^5.1.1  # 分页加载
  dismissible_page: ^1.0.2         # 拖动返回
  shimmer: ^3.0.0                  # 骨架屏动画
```

## 快速开始

```bash
flutter pub get
flutter run
```

---

## 项目结构

```
lib/
  main.dart                         // 应用入口
  router/app_routes.dart            // GoRouter 路由配置
  home/home_page.dart               // 首页（动画渐变卡片入口）

  shared/
    widgets/tech_background.dart    // 通用科技感背景组件

  examples/
    pagination/                     // 分页加载示例
      core/
        paged_list.dart            // 列表分页封装
        paging_mixin.dart          // 分页逻辑混入
        pagination_widgets.dart    // 状态组件（加载/空态/错误）
      data/
        app_item.dart              // 数据模型
        fake_remote_api.dart       // Mock 数据接口
      grid/
        core/paged_grid.dart       // 网格分页封装
        widgets/                   // 网格项组件
      masonry/
        core/paged_masonry.dart    // 瀑布流分页封装
        widgets/                   // 瀑布流项组件
      list/
        core/paged_list.dart       // 列表分页封装
        widgets/                   // 列表项组件
      pages/                       // 示例页面
      widgets/
        skeleton_theme.dart        // 骨架屏主题

    dismissible/
      pages/dismissible_demo_page.dart  // 图片拖动返回示例

    shimmer/
      pages/shimmer_demo_page.dart      // Shimmer 效果示例
      widgets/custom_shimmer.dart       // 自定义 Shimmer 组件
```

---

## 路由配置

文件：`lib/router/app_routes.dart`

| 路径 | 页面 |
|------|------|
| `/` | 首页 |
| `/examples/pagination/list` | 列表分页示例 |
| `/examples/pagination/grid` | 网格分页示例 |
| `/examples/pagination/masonry` | 瀑布流分页示例 |
| `/examples/dismissible` | 图片拖动返回示例 |
| `/examples/shimmer` | Shimmer 骨架屏示例 |

---

## 代码片段

### 分页 Mixin

```dart
class MyPageState extends State<MyPage> with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);
}
```

### 列表分页

```dart
return AppPagedList<int, AppItem>(
  controller: pagingController,
  padding: EdgeInsets.zero,
  itemBuilder: (context, item, index) => AppItemCard(item: item),
);
```

### 网格分页

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

### 瀑布流分页

```dart
return AppPagedMasonry<int, AppItem>.count(
  controller: pagingController,
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemBuilder: (context, item, index) => AppItemMasonryTile(item: item),
);
```

### TechScaffold 背景

```dart
return TechScaffold(
  title: '页面标题',
  variant: TechBackgroundVariant.purple,
  gradientColors: const [Color(0xFF8360c3), Color(0xFF2ebf91)],
  body: YourContent(),
);
```

---

## 扩展说明

### 自定义分页结束条件

覆写 `computeHasMore` 方法可自定义分页结束判断逻辑：

```dart
@override
bool computeHasMore(List<AppItem> items) {
  // 默认：items.length >= pageSize 表示有下一页
  // 可根据 API 返回的 total 或 hasNext 字段自定义
  return items.length >= pageSize;
}
```

### 自定义状态组件

分页组件支持自定义加载、空数据、错误状态的 UI：

**List 布局**（`pagination_widgets.dart`）：
```dart
AppPagedList(
  firstPageErrorIndicatorBuilder: (context) => CustomErrorWidget(),
  newPageErrorIndicatorBuilder: (context) => CustomLoadMoreError(),
  noItemsFoundIndicatorBuilder: (context) => CustomEmptyWidget(),
)
```

**Grid/Masonry 布局**（`pagination_grid_widgets.dart`）：
```dart
AppPagedGrid(
  firstPageErrorIndicatorBuilder: (context) => SliverFillRemaining(...),
  noItemsFoundIndicatorBuilder: (context) => SliverFillRemaining(...),
)
```

### 添加新示例

1. 在 `lib/examples/<feature>/` 下创建目录
2. 按需添加 `core`、`data`、`widgets`、`pages` 子目录
3. 在 `router/app_routes.dart` 添加路由配置
4. 在 `home/home_page.dart` 的 `_demoEntries` 列表添加入口卡片

---

## 设计规范

### 颜色主题

| 类型 | 色值 |
|-----|-----|
| 深色背景 | `#0F0F23` `#1A1A3E` `#0D1B2A` |
| 强调色 | `#6366F1` `#8B5CF6` |
| 卡片 | 白色 + 阴影 |

### TechBackground 变体

- `primary` - 深蓝紫渐变
- `cyan` - 青色渐变
- `purple` - 紫色渐变
- `green` - 绿色渐变

---

## 注意事项

- Masonry 示例中卡片高度使用确定性伪随机生成，实际项目应根据内容动态计算
- Grid/Masonry 自定义状态组件需使用 `SliverFillRemaining` 等 Sliver 组件
- Dismissible 示例在开发环境禁用了 SSL 证书验证（仅用于测试图片 API），生产环境需移除相关代码
- 图片使用 `errorBuilder` 处理加载失败，Mock 数据确定性生成，离线环境友好

---

## 后续计划

- [ ] RefreshIndicator 下拉刷新
- [ ] 自定义 TabBar 指示器动画
- [ ] Slidable 滑动删除列表项
- [ ] AnimatedSwitcher 页面切换动画
- [ ] CustomScrollView 混合滚动布局

---

## 技术要点

### 分页实现原理

使用 `infinite_scroll_pagination` 包的 `PagingController`：
- 监听滚动位置，触发翻页
- 维护页码和数据状态
- 通过 Mixin 统一管理分页逻辑

### Hero 动画

图片查看器使用 `Hero` widget 实现共享元素过渡：
```dart
Hero(
  tag: 'image_$index',
  child: Image.network(...),
)
```

### 骨架屏设计

使用 Shimmer 效果模拟内容加载：
- 高度、宽度与真实内容保持一致
- 颜色使用灰度系，避免干扰
- 动画速度适中，不宜过快

---

## 常见问题

**Q: 如何修改每页加载的数量？**

A: 在使用 `IntPagingMixin` 的 State 中覆写 `pageSize` 属性：
```dart
@override
int get pageSize => 20; // 默认为 10
```

**Q: 分页数据如何对接真实 API？**

A: 实现 `fetchPage` 方法，调用你的 API：
```dart
@override
Future<List<AppItem>> fetchPage(int pageKey) async {
  final response = await http.get('/api/items?page=$pageKey');
  return (json.decode(response.body) as List)
      .map((e) => AppItem.fromJson(e))
      .toList();
}
```

**Q: 如何自定义背景渐变色？**

A: 使用 `TechScaffold` 的 `gradientColors` 参数：
```dart
TechScaffold(
  gradientColors: const [Color(0xFFFF6B6B), Color(0xFF4ECDC4)],
  // ...
)
```

**Q: 图片加载失败如何处理？**

A: 示例中已使用 `errorBuilder` 处理，显示错误图标。可根据需求自定义：
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

