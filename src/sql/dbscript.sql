

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

-- PROD 2026 FEB 19

-- 23/02/2026 max(Intern): create 'overtime_status' table --
CREATE TABLE `overtime_status` (
  `status` VARCHAR(2) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `color` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 23/02/2026 max(Intern): insert initial status data (W, A, C, R) --
INSERT INTO `overtime_status` (status, description, color) VALUES ('W', 'Wait for approve', 'warning');
INSERT INTO `overtime_status` (status, description, color) VALUES ('A', 'Approved', 'success');
INSERT INTO `overtime_status` (status, description, color) VALUES ('C', 'Cancelled', 'dark');
INSERT INTO `overtime_status` (status, description, color) VALUES ('R', 'Rejected', 'danger');

-- 23/02/2026 max(Intern): create 'overtime' table with updated description and user fields --
CREATE TABLE `overtime` (
  `ot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ot_date` DATE NOT NULL,
  `start_time` DATETIME DEFAULT NULL, 
  `end_time` DATETIME DEFAULT NULL,
  `req_hours` DECIMAL(5,2) DEFAULT '0.00',
   `appr_hours` DECIMAL(5,2) DEFAULT '0.00',
  `type_of_ot` DECIMAL(3,1) DEFAULT NULL,
  `description` VARCHAR(1024) DEFAULT NULL,
  `description_appr` VARCHAR(1024) DEFAULT NULL,
  `status` VARCHAR(2) NOT NULL,
  `user_id` VARCHAR(45) DEFAULT NULL,
  `appr_user_id` VARCHAR(45) DEFAULT NULL,
  `approved_at` TIMESTAMP NULL DEFAULT NULL,
  `user_create` VARCHAR(45) NOT NULL,
  `time_create` TIMESTAMP NULL DEFAULT NULL,
  `user_update` VARCHAR(45) DEFAULT NULL,
  `time_update` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`ot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- PROD 2026 FEB 25

-- 26/02/2026 jang(Intern): create 'expense_detail' table --
CREATE TABLE expense_detail (
  `expense_detail_id` bigint(20) NOT NULL,
  `expense_id` bigint(20) NOT NULL,
  `go_by` bigint(1) NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user_create` varchar(32) DEFAULT NULL,
  `user_update` varchar(32) DEFAULT NULL,
  `time_create` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL,
  `kilometers` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 26/02/2026 jang(Intern): add 'requested_by','requested_at','received_by','received_at' column to 'expense_group' table --
ALTER TABLE `expense_group`
  ADD COLUMN `requested_by` VARCHAR(32) NULL AFTER paid_year,
  ADD COLUMN `requested_at`    DATETIME    NULL AFTER requested_by,
  ADD COLUMN `received_by`  VARCHAR(32) NULL AFTER requested_at,
  ADD COLUMN `received_at`     DATETIME    NULL AFTER received_by;
  
  -- PROD 2026 MAR 17
  
-- 17/03/2026 Eric: ALTER TABLE authorized_object and SET active
ALTER TABLE `authorized_object` ADD `active` VARCHAR(1) NULL AFTER `description`;
UPDATE `authorized_object` SET active = "1";

-- 17/03/2026 Eric: script add new authorized_object_id for work_log
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES ('worklog.view', 'worklog.view', 'สามารถดู work log ได้', '1', '2026-03-12 09:15:03', '2026-03-12 09:15:03', '2');
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES ('worklog.edit', 'worklog.edit', 'สามารถแก้ไข work log ได้', '1', '2026-03-12 09:15:03', '2026-03-12 09:15:03', '2');
-- 25/02/2026 june(Intern): add 'path_signature' column to 'user' table --
ALTER TABLE user ADD COLUMN path_signature VARCHAR(1024) DEFAULT NULL;
  
# PROD 17 MAR 2026

-- 17/03/2026 Koy : add 'daily monitor' permission   

# PROD 2 APR 2026
  
