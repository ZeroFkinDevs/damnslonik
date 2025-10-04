# Пример конфигурации экспорта для Godot Web

## Настройки экспорта в Godot

1. **Откройте Project → Export**
2. **Добавьте новый экспорт для Web**
3. **Настройте следующие параметры:**

### Основные настройки:

- **Name**: `Web`
- **Platform**: `Web`
- **Custom Features**: (оставьте пустым или добавьте нужные)

### Настройки Web:

- **Variant**: `Release`
- **Custom HTML Shell**: (оставьте пустым для стандартного)
- **HTML Template**: (используйте стандартный)

### Дополнительные настройки:

- **Export Mode**: `Export all resources in the project`
- **Resources**: `Export all resources in the project`
- **Features**: (оставьте пустым)

## Важные замечания:

1. **Путь к проекту**: Убедитесь, что ваш Godot проект находится в папке `project/` в корне репозитория
2. **Экспорт пресет**: Сохраните экспорт пресет с именем "Web"
3. **Версия Godot**: Система настроена для Godot 4.3

## Структура проекта должна быть:

```
damnslonik/
├── project/           # Ваш Godot проект
│   ├── project.godot
│   ├── scenes/
│   ├── scripts/
│   └── ...
├── .github/workflows/
├── web-interface/
├── scripts/
└── ...
```

## Тестирование экспорта локально:

Для тестирования экспорта локально:

1. Откройте проект в Godot
2. Выберите Project → Export
3. Выберите пресет "Web"
4. Нажмите "Export Project"
5. Сохраните файлы в папку `test-build/`
6. Откройте `test-build/index.html` в браузере

Если экспорт работает локально, то и в GitHub Actions будет работать корректно.
