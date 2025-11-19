# Feature Example (Flutter)

一个 Flutter 功能示例集合项目，展示常用的移动端交互模式与UI组件实现。

## 功能特性

### 分页加载示例
基于 `infinite_scroll_pagination` 实现的三种布局分页：
- **列表 List** - PagedListView 实现
- **网格 Grid** - PagedGridView 实现
- **瀑布流 Masonry** - PagedMasonryGridView 实现

### 图片交互示例
- **Dismissible Page** - 微信朋友圈风格的图片拖动返回效果，支持多方向手势

### Shimmer 骨架屏
- 自定义 Shimmer 动画效果
- 分页加载骨架屏占位组件

### UI 设计
- 科技感渐变背景主题
- 玻璃态卡片设计
- 动画渐变首页入口

---

## 运行环境

### 依赖要求
- Flutter SDK: >= 3.0（项目使用 `^3.9.2`）
- Dart SDK: 对应版本

### 主要依赖包
```yaml
dependencies:
  go_router: ^14.x              # 路由管理
  infinite_scroll_pagination: ^5.1.1  # 分页加载
  dismissible_page: ^1.0.2      # 拖动返回
  shimmer: ^3.0.0               # 骨架屏动画
```

### 本地运行
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

## 使用示例

### 1. 分页混入使用

```dart
class MyPageState extends State<MyPage> with IntPagingMixin<AppItem> {
  @override
  Future<List<AppItem>> fetchPage(int pageKey) =>
      FakeRemoteApi.fetchItems(page: pageKey, pageSize: pageSize);
}
```

### 2. 列表分页

```dart
return AppPagedList<int, AppItem>(
  controller: pagingController,
  padding: EdgeInsets.zero,
  itemBuilder: (context, item, index) => AppItemCard(item: item),
);
```

### 3. 网格分页

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

### 4. 瀑布流分页

```dart
return AppPagedMasonry<int, AppItem>.count(
  controller: pagingController,
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemBuilder: (context, item, index) => AppItemMasonryTile(item: item),
);
```

### 5. 使用 TechScaffold 背景

```dart
return TechScaffold(
  title: '页面标题',
  variant: TechBackgroundVariant.purple,
  gradientColors: const [Color(0xFF8360c3), Color(0xFF2ebf91)],
  body: YourContent(),
);
```

---

## 自定义扩展

### hasMore 判断逻辑
覆写 `computeHasMore` 方法（`lib/examples/pagination/core/paging_mixin.dart`）：
- 默认：`items.length >= pageSize` 表示还有下一页
- 支持 total / cursor 协议扩展

### 状态组件定制
- List 布局：`pagination_widgets.dart`
- Grid/Masonry 布局：`pagination_grid_widgets.dart`
- 可通过 `firstPage.../newPage.../noItems...` 参数覆盖

### 离线与容错
- 图片使用 `errorBuilder` 处理加载失败
- Mock 数据确定性生成，离线友好

### 新增示例
1. 在 `lib/examples/<feature>/` 下创建功能目录
2. 添加 `{core, data, widgets, pages}` 子目录
3. 在 `app_routes.dart` 添加路由
4. 在 `home_page.dart` 的 `_demoEntries` 添加入口

---

## 设计规范

### 颜色主题
- 背景色：`#0F0F23`, `#1A1A3E`, `#0D1B2A`
- 强调色：`#6366F1`, `#8B5CF6`
- 卡片背景：白色 + elevation 阴影

### 背景变体
- `primary` - 深蓝紫渐变
- `cyan` - 青色渐变
- `purple` - 紫色渐变
- `green` - 绿色渐变

---

## 注意事项

- Masonry 示例的卡片高度为确定性伪随机，实际项目中应以内容高度为准
- Grid/Masonry 自定义状态组件需确保尺寸适配子项宽度
- 开发环境下 Dismissible 示例禁用了 SSL 证书验证，生产环境请移除

---

## 截图预览

（可添加应用截图）

---

## License

本项目仅用于学习与示例演示用途。
