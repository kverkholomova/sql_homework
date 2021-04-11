-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 11 2021 г., 17:32
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `librarydb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `N` int(11) NOT NULL,
  `book_code` int(11) NOT NULL,
  `book_new` tinyint(1) DEFAULT NULL,
  `book_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_price` float NOT NULL,
  `book_id_publishing` int(11) NOT NULL,
  `book_pages` int(11) NOT NULL,
  `book_format` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_datee` date NOT NULL,
  `book_circulation` int(11) DEFAULT NULL,
  `book_id_topic` int(11) NOT NULL,
  `book_id_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`N`, `book_code`, `book_new`, `book_name`, `book_price`, `book_id_publishing`, `book_pages`, `book_format`, `book_datee`, `book_circulation`, `book_id_topic`, `book_id_category`) VALUES
(1, 5141, 0, 'Структуры данных и алгоритмы.', 37.8, 5, 384, '70х100/16', '2000-09-29', 5000, 1, 1),
(2, 5127, 0, 'Автоматизация инженерно- графических работ', 11.58, 6, 256, '70х100/16', '2000-06-15', 5000, 1, 1),
(3, 5110, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 1, 6),
(4, 5199, 0, 'Железо IBM 2001. ', 30.07, 2, 368, '70х100/16', '2000-12-02', 5000, 1, 6),
(5, 3851, 0, 'Защита информации и безопасность компьютерных систем', 26, 4, 480, '84х108/16', '1999-02-04', 5000, 1, 6),
(6, 3932, 0, 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 7, 144, '60х88/16', '1999-06-09', 5000, 1, 2),
(7, 4713, 0, 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 7, 144, '70х100/16', '2000-02-22', 5000, 1, 2),
(8, 5217, 0, 'Windows МЕ. Новейшие версии программ', 16.57, 8, 320, '70х100/16', '2000-08-25', 5000, 2, 3),
(9, 4829, 0, 'Windows 2000 Professional шаг за шагом с СD', 27.25, 9, 320, '70х100/16', '2000-04-28', 5000, 2, 3),
(10, 5170, 0, 'Linux Русские версии', 24.43, 7, 346, '70х100/16', '2000-09-29', 5000, 2, 4),
(11, 860, 0, 'Операционная система UNIX', 3.5, 1, 395, '84х10016', '1997-05-05', 5000, 2, 5),
(12, 44, 0, 'Ответы на актуальные вопросы по OS/2 Warp', 5, 4, 352, '60х84/16', '1996-03-20', 5000, 2, 6),
(13, 5176, 0, 'Windows Ме. Спутник пользователя', 12.79, 9, 306, '-', '2000-10-10', 5000, 2, 6),
(14, 5462, 0, 'Язык программирования С++. Лекции и упражнения', 29, 4, 656, '84х108/16', '2000-12-12', 5000, 3, 7),
(15, 4982, 0, 'Язык программирования С. Лекции и упражнения', 29, 4, 432, '84х108/16', '2000-07-12', 5000, 3, 7),
(16, 4687, 0, 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.6, 7, 240, '70х100/16', '2000-02-03', 5000, 3, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `book_category`
--

CREATE TABLE `book_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `book_category`
--

INSERT INTO `book_category` (`id`, `name`) VALUES
(1, 'Підручники'),
(2, 'Інші книги'),
(3, 'Windows 2000'),
(4, 'Linux'),
(5, 'Unix'),
(6, 'Інші операційні системи'),
(7, 'C&C++');

-- --------------------------------------------------------

--
-- Структура таблицы `book_publishing`
--

CREATE TABLE `book_publishing` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `book_publishing`
--

INSERT INTO `book_publishing` (`id`, `name`) VALUES
(1, 'BHV С.-Петербург'),
(2, 'МикроАрт'),
(3, 'МикроАрт'),
(4, 'DiaSoft'),
(5, 'Вильямс'),
(6, 'Питер'),
(7, 'ДМК'),
(8, 'Триумф'),
(9, 'Русская редакция');

-- --------------------------------------------------------

--
-- Структура таблицы `book_topic`
--

CREATE TABLE `book_topic` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `book_topic`
--

INSERT INTO `book_topic` (`id`, `name`) VALUES
(1, 'Використання ПК в цілому'),
(2, 'Операційні системи'),
(3, 'Програмування');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`N`),
  ADD KEY `book_id_publishing` (`book_id_publishing`),
  ADD KEY `book_id_topic` (`book_id_topic`),
  ADD KEY `book_id_category` (`book_id_category`);

--
-- Индексы таблицы `book_category`
--
ALTER TABLE `book_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `book_publishing`
--
ALTER TABLE `book_publishing`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `book_topic`
--
ALTER TABLE `book_topic`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `N` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `book_category`
--
ALTER TABLE `book_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `book_publishing`
--
ALTER TABLE `book_publishing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `book_topic`
--
ALTER TABLE `book_topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`book_id_publishing`) REFERENCES `book_publishing` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`book_id_topic`) REFERENCES `book_topic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_3` FOREIGN KEY (`book_id_publishing`) REFERENCES `book_publishing` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_4` FOREIGN KEY (`book_id_topic`) REFERENCES `book_topic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_5` FOREIGN KEY (`book_id_category`) REFERENCES `book_category` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
