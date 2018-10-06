# Оптимизация загрузки изображений #

1. Разработать приложение (сервис) для обмена фотографиями (на подобие instagram). Для реализации использовать любой серверный язык программирования.

2. При загрузке пользователем изображения реализовать механизм автоматической подготовки минифицированных версий изоражения (например `100*100`, `250*250`). Для работы можно использовать любой из инструментов (Imagemagick, Jpegtran, Jpegoptim, Optipng и тд). Можно скомбинировать несколько инструментов.

3. При отображении страницы с изображениями, на общей странице подгружать минифицированную версию, при клике по изображению открывать его полную версию.

4. Разработать web-worker, который по заданным правилам (по запуску адином, по таймингу и тд) будет проходить по папке с загруженными изображениями и достраивать отсутствующие минифицированные изображения.

5. Добавить ленивую загрузку изображений (подгружаются первые N фотографий, остальные догружаются при скролинге)

6. Произвести нагрузочное тестирование и оценить эффект от минификации.

7. Подготовить отчет о проделанной работе с выводами.