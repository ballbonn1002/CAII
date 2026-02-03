

-- 01/10/2025 Koy : add 'work_type' column to 'work_hour' table
ALTER TABLE `work_hours` ADD `work_type` CHAR(1) NULL DEFAULT NULL AFTER `work_hours_time_work`;

-- 01/10/2025 Koy : update work_type, onsite_num in all user
UPDATE `user` SET `work_type`='1',`onsite_num`='3'

-- INIT PROD -- 2025 Nov 10

-- 16/12/2025 fluke(Intern): add 'type_text' column to 'equipment_type' table --
ALTER TABLE `equipment_type` ADD `type_text` VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `time_update`;

-- 24/12/2025 fluke(Intern): add 'color_2' column to 'equipment_status' table --
ALTER TABLE `equipment_status` ADD `color_2` VARCHAR(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `color`;

-- 25/12/2025 fluke(Intern): modify 'status' column in 'equipment' table from VARCHAR(1) to VARCHAR(3) --
ALTER TABLE `equipment` MODIFY COLUMN `status` VARCHAR(3);

-- 5/1/2026 fluke(Intern): Populate 'color_2' column in 'equipment_status' table --
UPDATE `equipment_status` SET `color_2` = 'success' WHERE `status` = 'A';
UPDATE `equipment_status` SET `color_2` = 'primary' WHERE `status` = 'B';
UPDATE `equipment_status` SET `color_2` = 'danger' WHERE `status` = 'C';
UPDATE `equipment_status` SET `color_2` = 'cyan' WHERE `status` = 'F';
UPDATE `equipment_status` SET `color_2` = 'dark' WHERE `status` = 'L';
UPDATE `equipment_status` SET `color_2` = 'info' WHERE `status` = 'S';
UPDATE `equipment_status` SET `color_2` = 'warning' WHERE `status` = 'W';
UPDATE `equipment_status` SET `color_2` = 'secondary' WHERE `status` = 'Z';

-- 6/01/2026 fluk(Intern): Populate 'type_text' column in 'equipment_type' table --
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-laptop' WHERE `Type` = 'c';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-keyboard' WHERE `Type` = 'in';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-verify' WHERE `Type` = 'L';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-phone' WHERE `Type` = 'Mob';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-dots-square' WHERE `Type` = 'o';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-wifi-square' WHERE `Type` = 'p';
UPDATE `equipment_type` SET `type_text` = 'ki-solid ki-verify' WHERE `Type` = 'sl';

-- PROD 2026 JAN 06

-- 07/01/2026 Koy : change length of 'head' in holiday
ALTER TABLE `holiday` CHANGE `head` `head` VARCHAR(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

-- 7/01/2026 max(Intern): Modify 'description' column in 'job_site' table to support Thai characters --
ALTER TABLE job_site MODIFY description VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- PROD 2026 JAN 08
-- PROD 2026 JAN 16

-- 16/01/2026 max(Intern): Add 'highlight' column to 'announcement' table --
ALTER TABLE announcement ADD COLUMN highlight VARCHAR(1) DEFAULT NULL;

-- PROD 2026 FEB 3


