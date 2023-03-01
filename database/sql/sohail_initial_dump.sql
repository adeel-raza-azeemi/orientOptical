SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

--
-- Database: `id19143540_optician`
--

-- --------------------------------------------------------
USE id19150315_optical;
--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2014_10_12_000000_create_users_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `authority` enum('admin','oper','guest') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `password`, `authority`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Adeel Raza Azeemi', 'adeel', 'mr.azeemi@gmail.com', '$2y$10$peaNEZWXI4id8YYZB8bSfe97S.GCEnz.79HL..qPabQMmh4bwUXi.', 'admin', NULL, '2022-06-22 07:07:09', '2022-06-22 07:07:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

DROP TABLE IF EXISTS previous_record;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
  id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255) NOT NULL,
  contact bigint(20) DEFAULT NULL,
  r_sph float DEFAULT NULL,
  r_cyl float DEFAULT NULL,
  r_aixs float DEFAULT NULL,
  l_sph float DEFAULT NULL,
  l_cpl float DEFAULT NULL,
  l_aixs float DEFAULT NULL,
  r_sph_multiplier float DEFAULT NULL,
  r_cyl_multiplier float DEFAULT NULL,
  r_aixs_multiplier float DEFAULT NULL,
  l_sph_multiplier float DEFAULT NULL,
  l_cyl_multiplier float DEFAULT NULL,
  l_aixs_multiplier float DEFAULT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;

CREATE TABLE previous_record (
  id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  customer_id int ,
  contact bigint(20) DEFAULT NULL,
  r_sph float DEFAULT NULL,
  r_cyl float DEFAULT NULL,
  r_aixs float DEFAULT NULL,
  l_sph float DEFAULT NULL,
  l_cpl float DEFAULT NULL,
  l_aixs float DEFAULT NULL,
  r_sph_multiplier float DEFAULT NULL,
  r_cyl_multiplier float DEFAULT NULL,
  r_aixs_multiplier float DEFAULT NULL,
  l_sph_multiplier float DEFAULT NULL,
  l_cyl_multiplier float DEFAULT NULL,
  l_aixs_multiplier float DEFAULT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP;

  FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE customer_order (
  id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  customer_id int,
  particular VARCHAR(255),
  order_date date,
  total DECIMAL(5,2),
  advance DECIMAL(5,2),
  balance DECIMAL(5,2),
  frame DECIMAL(5,2),
  glasses DECIMAL(5,2),
  delivery DATETIME,
  FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
 Pseudocode 
  on update customer 
    insert into previous the previous values  
*/
DELIMITER @@
DROP TRIGGER IF EXISTS maintaining_record_trigger @@
CREATE TRIGGER maintaining_record_trigger
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
    
    INSERT INTO previous_record (customer_id, contact, r_sph, r_cyl, r_aixs, l_sph, l_cpl, l_aixs, r_sph_multiplier, 
    r_cyl_multiplier, r_aixs_multiplier, l_sph_multiplier, l_cyl_multiplier, l_aixs_multiplier )
    SELECT id, contact, r_sph, r_cyl, r_aixs, l_sph, l_cpl, l_aixs, r_sph_multiplier, r_cyl_multiplier, r_aixs_multiplier, 
    l_sph_multiplier, l_cyl_multiplier, l_aixs_multiplier FROM customer 
    WHERE id = NEW.id;
    
END @@ 
DELIMITER ; 

COMMIT;

UPDATE customer SET `name` = 'Adeel Raza Azeemi', contact = 03159017006 WHERE id = 1;

DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (city varchar(19), lat decimal(6,4), lng decimal(6,4), admin_name varchar(18), capital varchar(7));

-- select * from cities WHERE admin_name = 'Khyber Pakhtunkhwa' ORDER BY city;

-- 158 recs
INSERT INTO cities (`city`, `lat`, `lng`, `admin_name`, `capital`) VALUES 
('Karachi', 24.86, 67.01, 'Sindh', 'admin'),
 ('Lahore', 31.5497, 74.3436, 'Punjab', 'admin'),
 ('Faisalabad', 31.418, 73.079, 'Punjab', 'minor'),
 ('Rawalpindi', 33.6007, 73.0679, 'Punjab', 'minor'),
 ('Gujranwala', 32.15, 74.1833, 'Punjab', 'minor'),
 ('Peshawar', 34, 71.5, 'Khyber Pakhtunkhwa', 'admin'),
 ('Multan', 30.1978, 71.4711, 'Punjab', 'minor'),
 ('Saidu Sharif', 34.75, 72.3572, 'Khyber Pakhtunkhwa', 'minor'),
 ('Hyderabad City', 25.3792, 68.3683, 'Sindh', 'minor'),
 ('Islamabad', 33.6989, 73.0369, 'Islāmābād', 'primary'),
 ('Quetta', 30.192, 67.007, 'Balochistān', 'admin'),
 ('Bahawalpur', 29.3956, 71.6722, 'Punjab', 'minor'),
 ('Sargodha', 32.0836, 72.6711, 'Punjab', 'minor'),
 ('Sialkot City', 32.5, 74.5333, 'Punjab', 'minor'),
 ('Sukkur', 27.6995, 68.8673, 'Sindh', 'minor'),
 ('Larkana', 27.56, 68.2264, 'Sindh', 'minor'),
 ('Chiniot', 31.7167, 72.9833, 'Punjab', 'minor'),
 ('Shekhupura', 31.7083, 74, 'Punjab', 'minor'),
 ('Jhang City', 31.2681, 72.3181, 'Punjab', 'minor'),
 ('Dera Ghazi Khan', 30.05, 70.6333, 'Punjab', 'minor'),
 ('Gujrat', 32.5736, 74.0789, 'Punjab', 'minor'),
 ('Rahimyar Khan', 28.4202, 70.2952, 'Punjab', ''),
 ('Kasur', 31.1167, 74.45, 'Punjab', 'minor'),
 ('Mardan', 34.1958, 72.0447, 'Khyber Pakhtunkhwa', 'minor'),
 ('Mingaora', 34.7717, 72.36, 'Khyber Pakhtunkhwa', ''),
 ('Nawabshah', 26.2442, 68.41, 'Sindh', 'minor'),
 ('Sahiwal', 30.6706, 73.1064, 'Punjab', 'minor'),
 ('Mirpur Khas', 25.5269, 69.0111, 'Sindh', 'minor'),
 ('Okara', 30.81, 73.4597, 'Punjab', 'minor'),
 ('Mandi Burewala', 30.15, 72.6833, 'Punjab', ''),
 ('Jacobabad', 28.2769, 68.4514, 'Sindh', 'minor'),
 ('Saddiqabad', 28.3006, 70.1302, 'Punjab', ''),
 ('Kohat', 33.5869, 71.4414, 'Khyber Pakhtunkhwa', 'minor'),
 ('Muridke', 31.802, 74.255, 'Punjab', ''),
 ('Muzaffargarh', 30.0703, 71.1933, 'Punjab', 'minor'),
 ('Khanpur', 28.6471, 70.662, 'Punjab', ''),
 ('Gojra', 31.15, 72.6833, 'Punjab', ''),
 ('Mandi Bahauddin', 32.5861, 73.4917, 'Punjab', 'minor'),
 ('Abbottabad', 34.15, 73.2167, 'Khyber Pakhtunkhwa', 'minor'),
 ('Turbat', 26.0031, 63.0544, 'Balochistān', 'minor'),
 ('Dadu', 26.7319, 67.775, 'Sindh', 'minor'),
 ('Bahawalnagar', 29.9944, 73.2536, 'Punjab', 'minor'),
 ('Khuzdar', 27.8, 66.6167, 'Balochistān', ''),
 ('Pakpattan', 30.35, 73.4, 'Punjab', 'minor'),
 ('Tando Allahyar', 25.4667, 68.7167, 'Sindh', 'minor'),
 ('Ahmadpur East', 29.1453, 71.2617, 'Punjab', ''),
 ('Vihari', 30.0419, 72.3528, 'Punjab', 'minor'),
 ('Jaranwala', 31.3342, 73.4194, 'Punjab', ''),
 ('New Mirpur', 33.1333, 73.75, 'Azad Kashmir', 'minor'),
 ('Kamalia', 30.7258, 72.6447, 'Punjab', ''),
 ('Kot Addu', 30.47, 70.9644, 'Punjab', ''),
 ('Nowshera', 34.0153, 71.9747, 'Khyber Pakhtunkhwa', 'minor'),
 ('Swabi', 34.1167, 72.4667, 'Khyber Pakhtunkhwa', 'minor'),
 ('Khushab', 32.2917, 72.35, 'Punjab', 'minor'),
 ('Dera Ismail Khan', 31.8167, 70.9167, 'Khyber Pakhtunkhwa', 'minor'),
 ('Chaman', 30.921, 66.4597, 'Balochistān', ''),
 ('Charsadda', 34.1453, 71.7308, 'Khyber Pakhtunkhwa', 'minor'),
 ('Kandhkot', 28.4, 69.3, 'Sindh', ''),
 ('Chishtian', 29.7958, 72.8578, 'Punjab', ''),
 ('Hasilpur', 29.6967, 72.5542, 'Punjab', ''),
 ('Attock Khurd', 33.7667, 72.3667, 'Punjab', ''),
 ('Muzaffarabad', 34.37, 73.4711, 'Azad Kashmir', ''),
 ('Mianwali', 32.5853, 71.5436, 'Punjab', 'minor'),
 ('Jalalpur Jattan', 32.7667, 74.2167, 'Punjab', ''),
 ('Bhakkar', 31.6333, 71.0667, 'Punjab', 'minor'),
 ('Zhob', 31.3417, 69.4486, 'Balochistān', 'minor'),
 ('Dipalpur', 30.6708, 73.6533, 'Punjab', ''),
 ('Kharian', 32.811, 73.865, 'Punjab', ''),
 ('Mian Channun', 30.4397, 72.3544, 'Punjab', ''),
 ('Bhalwal', 32.2653, 72.9028, 'Punjab', ''),
 ('Jamshoro', 25.4283, 68.2822, 'Sindh', 'minor'),
 ('Pattoki', 31.0214, 73.8528, 'Punjab', ''),
 ('Harunabad', 29.61, 73.1361, 'Punjab', ''),
 ('Kahror Pakka', 29.6236, 71.9167, 'Punjab', ''),
 ('Toba Tek Singh', 30.9667, 72.4833, 'Punjab', 'minor'),
 ('Samundri', 31.0639, 72.9611, 'Punjab', ''),
 ('Shakargarh', 32.2628, 75.1583, 'Punjab', ''),
 ('Sambrial', 32.475, 74.3522, 'Punjab', ''),
 ('Shujaabad', 29.8803, 71.295, 'Punjab', ''),
 ('Hujra Shah Muqim', 30.7408, 73.8219, 'Punjab', ''),
 ('Kabirwala', 30.4068, 71.8667, 'Punjab', ''),
 ('Mansehra', 34.3333, 73.2, 'Khyber Pakhtunkhwa', 'minor'),
 ('Lala Musa', 32.7006, 73.9558, 'Punjab', ''),
 ('Chunian', 30.9639, 73.9803, 'Punjab', ''),
 ('Nankana Sahib', 31.4492, 73.7124, 'Punjab', ''),
 ('Bannu', 32.9889, 70.6056, 'Khyber Pakhtunkhwa', 'minor'),
 ('Pasrur', 32.2681, 74.6675, 'Punjab', ''),
 ('Timargara', 34.8281, 71.8408, 'Khyber Pakhtunkhwa', 'minor'),
 ('Parachinar', 33.8992, 70.1008, 'Khyber Pakhtunkhwa', ''),
 ('Chenab Nagar', 31.75, 72.9167, 'Punjab', ''),
 ('Gwadar', 25.1264, 62.3225, 'Balochistān', 'minor'),
 ('Abdul Hakim', 30.5522, 72.1278, 'Punjab', ''),
 ('Hassan Abdal', 33.8195, 72.689, 'Punjab', ''),
 ('Tank', 32.2167, 70.3833, 'Khyber Pakhtunkhwa', 'minor'),
 ('Hangu', 33.5281, 71.0572, 'Khyber Pakhtunkhwa', 'minor'),
 ('Risalpur Cantonment', 34.0049, 71.9989, 'Khyber Pakhtunkhwa', ''),
 ('Karak', 33.1167, 71.0833, 'Khyber Pakhtunkhwa', 'minor'),
 ('Kundian', 32.4522, 71.4718, 'Punjab', ''),
 ('Umarkot', 25.3614, 69.7361, 'Sindh', 'minor'),
 ('Chitral', 35.8511, 71.7889, 'Khyber Pakhtunkhwa', 'minor'),
 ('Dainyor', 35.9206, 74.3783, 'Gilgit-Baltistan', ''),
 ('Kulachi', 31.9286, 70.4592, 'Khyber Pakhtunkhwa', ''),
 ('Kalat', 29.0258, 66.59, 'Balochistān', 'minor'),
 ('Kotli', 33.5156, 73.9019, 'Azad Kashmir', 'minor'),
 ('Gilgit', 35.9208, 74.3144, 'Gilgit-Baltistan', 'minor'),
 ('Narowal', 32.102, 74.873, 'Punjab', 'minor'),
 ('Khairpur Mir’s', 27.5295, 68.7592, 'Sindh', 'minor'),
 ('Khanewal', 30.3017, 71.9321, 'Punjab', 'minor'),
 ('Jhelum', 32.9333, 73.7333, 'Punjab', 'minor'),
 ('Haripur', 33.9942, 72.9333, 'Khyber Pakhtunkhwa', 'minor'),
 ('Shikarpur', 27.9556, 68.6382, 'Sindh', 'minor'),
 ('Rawala Kot', 33.8578, 73.7604, 'Azad Kashmir', 'minor'),
 ('Hafizabad', 32.0709, 73.688, 'Punjab', 'minor'),
 ('Lodhran', 29.5383, 71.6333, 'Punjab', 'minor'),
 ('Malakand', 34.5656, 71.9304, 'Khyber Pakhtunkhwa', 'minor'),
 ('Attock City', 33.7667, 72.3598, 'Punjab', 'minor'),
 ('Batgram', 34.6796, 73.0263, 'Khyber Pakhtunkhwa', 'minor'),
 ('Matiari', 25.5971, 68.4467, 'Sindh', 'minor'),
 ('Ghotki', 28.0064, 69.315, 'Sindh', 'minor'),
 ('Naushahro Firoz', 26.8401, 68.1227, 'Sindh', 'minor'),
 ('Alpurai', 34.9, 72.6556, 'Khyber Pakhtunkhwa', 'minor'),
 ('Bagh', 33.9803, 73.7747, 'Azad Kashmir', 'minor'),
 ('Daggar', 34.5111, 72.4844, 'Khyber Pakhtunkhwa', 'minor'),
 ('Leiah', 30.9646, 70.9444, 'Punjab', 'minor'),
 ('Tando Muhammad Khan', 25.1239, 68.5389, 'Sindh', 'minor'),
 ('Chakwal', 32.93, 72.85, 'Punjab', 'minor'),
 ('Badin', 24.6558, 68.8383, 'Sindh', 'minor'),
 ('Lakki', 32.6072, 70.9123, 'Khyber Pakhtunkhwa', 'minor'),
 ('Rajanpur', 29.1041, 70.3297, 'Punjab', 'minor'),
 ('Dera Allahyar', 28.4167, 68.1667, 'Balochistān', 'minor'),
 ('Shahdad Kot', 27.8473, 67.9068, 'Sindh', 'minor'),
 ('Pishin', 30.5833, 67, 'Balochistān', 'minor'),
 ('Sanghar', 26.0464, 68.9481, 'Sindh', 'minor'),
 ('Upper Dir', 35.2074, 71.8768, 'Khyber Pakhtunkhwa', 'minor'),
 ('Thatta', 24.7461, 67.9243, 'Sindh', 'minor'),
 ('Dera Murad Jamali', 28.5466, 68.2231, 'Balochistān', 'minor'),
 ('Kohlu', 29.8965, 69.2532, 'Balochistān', 'minor'),
 ('Mastung', 29.7997, 66.8455, 'Balochistān', 'minor'),
 ('Dasu', 35.2917, 73.2906, 'Khyber Pakhtunkhwa', 'minor'),
 ('Athmuqam', 34.5717, 73.8972, 'Azad Kashmir', 'minor'),
 ('Loralai', 30.3705, 68.5979, 'Balochistān', 'minor'),
 ('Barkhan', 29.8977, 69.5256, 'Balochistān', 'minor'),
 ('Musa Khel Bazar', 30.8594, 69.8221, 'Balochistān', 'minor'),
 ('Ziarat', 30.3814, 67.7258, 'Balochistān', 'minor'),
 ('Gandava', 28.6132, 67.4856, 'Balochistān', 'minor'),
 ('Sibi', 29.543, 67.8773, 'Balochistān', 'minor'),
 ('Dera Bugti', 29.0362, 69.1585, 'Balochistān', 'minor'),
 ('Eidgah', 35.3471, 74.8563, 'Gilgit-Baltistan', 'minor'),
 ('Uthal', 25.8072, 66.6228, 'Balochistān', 'minor'),
 ('Khuzdar', 27.7384, 66.6434, 'Balochistān', 'minor'),
 ('Chilas', 35.4206, 74.0967, 'Gilgit-Baltistan', 'minor'),
 ('Panjgur', 26.9644, 64.0903, 'Balochistān', 'minor'),
 ('Gakuch', 36.1736, 73.7667, 'Gilgit-Baltistan', 'minor'),
 ('Qila Saifullah', 30.7008, 68.3598, 'Balochistān', 'minor'),
 ('Kharan', 28.5833, 65.4167, 'Balochistān', 'minor'),
 ('Aliabad', 36.3078, 74.6178, 'Gilgit-Baltistan', 'minor'),
 ('Awaran', 26.4568, 65.2314, 'Balochistān', 'minor'),
 ('Dalbandin', 28.8885, 64.4062, 'Balochistān', 'minor');

DROP TABLE IF EXISTS cities2;
CREATE TABLE IF NOT EXISTS cities2 (city varchar(19), lat decimal(6,4), lng decimal(6,4), admin_name varchar(18), capital varchar(7));
-- 136 recs
LOAD DATA LOCAL INFILE '/var/www/html/orient.optical/database/sql/pk.csv' INTO TABLE cities2
 FIELDS TERMINATED BY ',' 
 OPTIONALLY ENCLOSED BY '"'
 ESCAPED BY '"'
 LINES TERMINATED BY '\n'
IGNORE 1 LINES;

ALTER TABLE cities ADD INDEX city (city);
ALTER TABLE cities2 ADD INDEX city (city);
SELECT * from cities WHERE city NOT IN (select city from cities2);