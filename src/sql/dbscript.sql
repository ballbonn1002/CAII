

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

# PROD 8 APR 2026

-- 24/04/2026 ochi(Intern): add 'description_appr / approved_at / appr_user_id' column to 'expense_group' table -- 
ALTER TABLE expense_group ADD COLUMN description_appr VARCHAR(1024) DEFAULT NULL;
ALTER TABLE expense_group ADD COLUMN approved_at timestamp DEFAULT NULL;
ALTER TABLE expense_group ADD COLUMN appr_user_id varchar(45) DEFAULT NULL;

-- PROD 28 APR 2026

-- 28/04/2026 Eric: Delete tag, article_tag
DELETE FROM `tag`;
DELETE FROM `article_tag`

-- PROD 29 APR 2026

-- 06/05/2026 boom(Intern): add new tables for Help & Support menu -- 
-- 1. Table: support_menu
CREATE TABLE support_menu (
    support_menu_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    menu_name VARCHAR(32) NULL,
    description VARCHAR(1024),
    user_create VARCHAR(32) NULL,
    user_update VARCHAR(32) NULL,
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
);

-- add menu options for help & support
INSERT INTO support_menu (
    menu_name, 
    description, 
    user_create, 
    user_update
) VALUES 
('Check In / Check Out', NULL, 'cft.admin', 'cft.admin'),
('Calendar and Check List', NULL, 'cft.admin', 'cft.admin'),
('My Leave', NULL, 'cft.admin', 'cft.admin'),
('Overtime Request', NULL, 'cft.admin', 'cft.admin'),
('My Travel', NULL, 'cft.admin', 'cft.admin'),
('Equipment', NULL, 'cft.admin', 'cft.admin'),
('Borrow', NULL, 'cft.admin', 'cft.admin'),
('Master', NULL, 'cft.admin', 'cft.admin'),
('Other', NULL, 'cft.admin', 'cft.admin');

-- 2. Table: support
CREATE TABLE support (
    support_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(32) NULL,
    issue_date DATE NULL,
    categorized VARCHAR(32) NULL,
    support_menu_id VARCHAR(32) NULL,
    status VARCHAR(32) NULL,
    description VARCHAR(1024),
    user_create VARCHAR(32) NULL,
    user_update VARCHAR(32) NULL,
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
);

-- 3. Table: support_detail
CREATE TABLE support_detail (
    support_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    support_id VARCHAR(32) NULL,
    message VARCHAR(1024) NULL,
    status VARCHAR(32) NULL,
    description VARCHAR(1024),
    user_create VARCHAR(32) NULL,
    user_update VARCHAR(32) NULL,
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
);

-- Add permissions for Help & Support --
INSERT INTO authorized_object (authorized_object_id, name, description, active, authorized_object_group_id) 
VALUES ('helpsupport.view', 'helpsupport.view', 'เมนู Help & Support', '1', '1');
INSERT INTO authorized_object (authorized_object_id, name, description, active, authorized_object_group_id) 
VALUES ('helpsupport.manage', 'helpsupport.manage', 'จัดการ Help & Support (Admin)', '1', '1');

-- PROD 6 May 2026

-- 07/05/2026 boom(Intern): modify Help & Support table for Thai Language support -- 
-- แปลง Character Set ของตาราง support_menu
ALTER TABLE support_menu 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- แปลง Character Set ของตาราง support
ALTER TABLE support 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- แปลง Character Set ของตาราง support_detail
ALTER TABLE support_detail 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


-- 08/05/2026 boom(Intern): Modify 'announcement' table for viewer logs --
ALTER TABLE announcement 
ADD COLUMN viewer_logs LONGTEXT NULL,
ADD COLUMN unique_readcount INT DEFAULT 0;

-- PROD 12 MAY 2026

-- 13/05/2026 boom(Intern) : Update categorized field in support table to use numeric values -- 
UPDATE support SET categorized = '1' WHERE categorized = 'Technical Issue';
UPDATE support SET categorized = '2' WHERE categorized = 'Inquiry / Question';
UPDATE support SET categorized = '3' WHERE categorized = 'Feature Request';

-- 15/05/2026 Eric: CREATE TABLE log_action
CREATE TABLE `log_action` (
`log_action_id` BIGINT(20) NOT NULL PRIMARY KEY, 
`log_data` TEXT NULL , 
`user_create` VARCHAR(32) NULL , 
`user_update` VARCHAR(32) NULL , 
`time_create` TIMESTAMP NULL , 
`time_update` TIMESTAMP NULL ) ENGINE = InnoDB;

-- 15/05/2026 Koy: Add permission 'announcement.read' in 'authorized_object' table.
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) VALUES 
('announcement.read', 'announcement.read', 'อ่าน announcement ได้', '1', '2026-05-12 14:56:43', '2026-05-12 14:56:43', '1');

# PROD 15 MAY 2026

-- 20/05/2026 boom(Intern) : Add column employee_status in user table -- 
ALTER TABLE `user`
ADD `employee_status` VARCHAR(1) COLLATE utf8mb3_general_ci NOT NULL DEFAULT '1'

-- 21/05/2026 June: add delivery / return columns to 'borrow' table --
ALTER TABLE `borrow`
ADD COLUMN `user_delivery` VARCHAR(32) NULL DEFAULT NULL,
ADD COLUMN `time_delivery` TIMESTAMP NULL DEFAULT NULL,
ADD COLUMN `user_receive` VARCHAR(32) NULL DEFAULT NULL,
ADD COLUMN `time_receive` TIMESTAMP NULL DEFAULT NULL,
ADD COLUMN `user_return` VARCHAR(32) NULL DEFAULT NULL,
ADD COLUMN `time_return` TIMESTAMP NULL DEFAULT NULL,
ADD COLUMN `user_return_receive` VARCHAR(32) NULL DEFAULT NULL,
ADD COLUMN `time_return_receive` TIMESTAMP NULL DEFAULT NULL;

# PROD 22 MAY 2026


-- 22/05/2026 ochi(Intern) : Add column active in exp_travel_type table -- 
ALTER TABLE `exp_travel_type`
ADD `active` VARCHAR(1) COLLATE utf8mb3_general_ci NOT NULL DEFAULT '1';

# PROD 27 MAY 2026


-- 27/05/2026 Got(Intern) : Add permissions File Management in authorized_object table --
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES 
('file.view', 'file.view', 'ดูและจัดการไฟล์ของตนเอง (File Management)', '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1'),
('file.viewall', 'file.viewall', 'ดูและจัดการไฟล์ทั้งหมดในระบบ (File Management)', '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1');

-- Add permissions for File Management to admin role in role_authorized_object table --
INSERT INTO `role_authorized_object` (`role_id`, `authorized_object_id`, `time_create`, `time_update`) 
VALUES 
('admin', 'file.view', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('admin', 'file.viewall',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

# PROD 27 MAY 2026 #2




-- 27/05/2026 June: Update borrow records created before 22 May 2026 --
-- Update records with status = 'B' --
UPDATE borrow
SET 
    user_delivery = user_create,
    user_receive  = user_borrowid,
    time_delivery = time_create,
    time_receive  = time_create
WHERE 
    status = 'B'
    AND time_create < '2026-05-22 00:00:00'
    AND user_delivery IS NULL   
    AND user_receive  IS NULL
    AND time_delivery IS NULL
    AND time_receive  IS NULL;

-- Update records with status = 'R' --
UPDATE borrow
SET 
    user_delivery        = user_create,
    user_receive         = user_borrowid,
    time_delivery        = time_create,
    time_receive         = time_create,
    user_return          = user_borrowid,
    user_return_receive  = user_update,
    time_return          = time_update,
    time_return_receive  = time_update
WHERE 
    status = 'R'
    AND time_create < '2026-05-22 00:00:00'
    AND user_delivery       IS NULL
    AND user_receive        IS NULL
    AND time_delivery       IS NULL
    AND time_receive        IS NULL
    AND user_return         IS NULL
    AND user_return_receive IS NULL
    AND time_return         IS NULL
    AND time_return_receive IS NULL;

-- 28/05/2026 team(Intern) : Add permission 'careers.view' in 'authorized_object' table.
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES ('careers.view', 'careers.view', 'จัดการ careers ได้', '1', '2026-05-18 15:37:00', '2026-05-18 15:37:00', '1');

-- PROD 15 JUNE 2026

-- 15/06/2026 team(Intern) : Add column 'changepass_code' in 'user' table.
ALTER TABLE user ADD COLUMN changepass_code VARCHAR(6) DEFAULT NULL;

-- PROD 29 JUNE 2026

-- 23/06/2026 June: Add permission 'pageurl.view','pageurl.edit','worklocation.view' in 'authorized_object' table.
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES ('pageurl.view', 'pageurl.view', 'สามารถดูรายการ page url ได้', '1', '2026-06-18 11:57:00', '2026-06-18 11:57:00', '6'),
('pageurl.edit', 'pageurl.edit', 'สามารถแก้ไขรายการ page url ได้', '1', '2026-06-18 11:57:00', '2026-06-18 11:57:00', '6'),
('worklocation.view', 'worklocation.view', 'สามารถดูรายการ work location ได้', '1', '2026-06-18 11:57:00', '2026-06-18 11:57:00', '100');

--  PROD 1 JULY 2026 12:30

-- 07/03/2026 ochi(Intern) : Add permissions Footer in authorized_object table.
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `active`, `time_create`, `time_update`, `authorized_object_group_id`) 
VALUES 
('footer.view', 'footer.view', 'ดูแลจัดการ footer ของ เว็บ CubeSoftTech', '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1');


--  PROD 6 JULY 2026 10:00

-- 07/07/2026 Eric : Add column uid_line_oa in user TABLE
ALTER TABLE `user` ADD COLUMN uid_line_oa VARCHAR(64) DEFAULT NULL AFTER line_id;

-- PROD 14 JULY 2026 13:10


-- 07/07/2026 Eric : Add column uid_line_oa in user TABLE
ALTER TABLE `user` ADD COLUMN uid_line_oa VARCHAR(64) DEFAULT NULL AFTER line_id;

-- PROD 10 JULY 2026 10:40



-- 14/07/2026 Best(Intern) : Create company, contact, address tables

CREATE TABLE company (
    company_id BIGINT(32) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    file_id VARCHAR(32),
    industry_id VARCHAR(32) NOT NULL,
    company_code VARCHAR(32) NOT NULL UNIQUE,
    tax_number VARCHAR(13) NOT NULL,
    company_en VARCHAR(128) NOT NULL,
    company_th VARCHAR(128) NOT NULL,
    is_active VARCHAR(1) DEFAULT true,
    user_create VARCHAR(32),
    user_update VARCHAR(32),
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

CREATE TABLE company_address (
    company_address_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    company_id VARCHAR(32) NOT NULL,
    address_name VARCHAR(64) NOT NULL,
    address VARCHAR(1024) NOT NULL,
    google_map VARCHAR(1024),
    user_create VARCHAR(32),
    user_update VARCHAR(32),
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

CREATE TABLE company_contact (
    company_contact_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    company_id VARCHAR(32),
    file_id VARCHAR(32),
    company_address_id VARCHAR(32),
    title_name_en VARCHAR(32) NOT NULL,
    contact_name VARCHAR(256) NOT NULL,
    title_name_th VARCHAR(32) NOT NULL,
    contact_name_th VARCHAR(256) NOT NULL,
    position VARCHAR(64) NOT NULL,
    phone VARCHAR(64) NOT NULL,
    email VARCHAR(256) NOT NULL,
    is_active VARCHAR(1) ,
    user_create VARCHAR(32),
    user_update VARCHAR(32),
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- 17/07/2026 June: CREATE TABLE catalog_equipment and catalog_consumables
CREATE TABLE catalog_equipment (
	catalog_equipment_id BIGINT(11) NOT NULL, 
	equipment_name 		VARCHAR(64)  NOT NULL,
	items_type			VARCHAR(32)  NULL,
    active              VARCHAR(8)   NOT NULL,
    user_create         VARCHAR(32)  NULL,
    user_update         VARCHAR(32)  NULL,
    time_create         TIMESTAMP    NULL,
    time_update         TIMESTAMP    NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `catalog_equipment` (`catalog_equipment_id`, `equipment_name`, `items_type`, `active`, `user_create`, `user_update`, `time_create`, `time_update`) VALUES
(1, 'Adapter Lan', '1', '1', 'cft.admin', 'cft.admin', '2026-07-21 06:23:09', '2026-07-21 06:23:09'),
(2, 'Computer', '1', '0', 'cft.admin', 'cft.admin', '2026-07-21 06:23:52', '2026-07-21 06:23:56');

CREATE TABLE catalog_consumables (
	catalog_consumables_id BIGINT(11) NOT NULL, 
	product_id 			BIGINT(11)  NOT NULL,
	parent_product_id 	VARCHAR(32) NOT NULL,
	items_type			VARCHAR(32) NULL,
	sub_product_active 	VARCHAR(8)  NOT NULL,
    active              VARCHAR(8)   NOT NULL,
    user_create         VARCHAR(32)  NULL,
    user_update         VARCHAR(32)  NULL,
    time_create         TIMESTAMP    NULL,
    time_update         TIMESTAMP    NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `catalog_consumables` (`catalog_consumables_id`, `product_id`, `parent_product_id`, `items_type`, `sub_product_active`, `active`, `user_create`, `user_update`, `time_create`, `time_update`) VALUES
(1, 1, 0, '2', '1', '1', 'cft.admin', 'cft.admin', '2026-07-21 08:17:30', '2026-07-23 03:01:01'),
(2, 2, 0, '2', '0', '0', 'cft.admin', 'cft.admin', '2026-07-21 08:17:30', '2026-07-21 08:17:30');

-- 22/07/2026 Best(Intern): CREATE TABLE company_industry 
CREATE TABLE company_industry (
    industry_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    industry_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(1024),
    user_create VARCHAR(32),
    user_update VARCHAR(32),
    time_create TIMESTAMP NULL,
    time_update TIMESTAMP NULL 
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- 21/07/2026 Koy: create table 'product' and insert mockup data
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `product_no` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_product_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_create` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_update` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_create` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product` (`product_id`, `sequence`, `product_no`, `product_name`, `product_type`, `parent_product_id`, `description`, `user_create`, `user_update`, `time_create`, `time_update`) VALUES
(1, 1, 'Item-Shirt2026-Black', 'เสื้อบริษัท 2026 (สีดำ)', '2', '0', 'เสื้อบริษัท 2026 (สีดำ)', 'cft.admin', NULL, NULL, NULL),
(2, 2, 'Item-Trash', 'ถุงขยะ', '2', '0', 'ถุงขยะ', 'cft.admin', NULL, NULL, NULL),
(3, 1, 'Item-Shirt2026-Black-S', 'S', '2', '1', 'อก 32', 'cft.admin', NULL, NULL, NULL),
(4, 3, 'Item-Shirt2026-Black-L', 'L', '2', '1', 'อก 36', 'cft.admin', NULL, NULL, NULL),
(5, 2, 'Item-Shirt2026-Black-M', 'M', '2', '1', 'อก 34', 'cft.admin', NULL, NULL, NULL),
(6, 4, 'Item-Shirt2026-Black-XL', 'XL', '2', '1', 'อก 38', 'cft.admin', NULL, NULL, NULL),
(7, 5, 'Item-Shirt2026-Black-2XL', '2XL', '2', '1', 'อก 40', 'cft.admin', NULL, NULL, NULL);

-- 27/07/2026 Best(Intern): create table warehouse
CREATE TABLE warehouse (
    warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(64) NOT NULL,
    parent BIGINT NOT NULL DEFAULT 0,
    description VARCHAR(1024),
    user_create VARCHAR(32),
    user_update VARCHAR(32),
    time_create TIMESTAMP NULL DEFAULT NULL,
    time_update TIMESTAMP NULL DEFAULT NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- PROD 24 JUL 2026

-- 27/07/2026 Koy: add column 'sub_product_active' and 'active' in table product.
ALTER TABLE `product` ADD `sub_product_active` VARCHAR(8) DEFAULT NULL AFTER `description`, ADD `active` VARCHAR(8) DEFAULT NULL AFTER `sub_product_active`;

-- 30/07/2026 June: Delete Table Catalog_consumables.
DROP TABLE catalog_consumables;

-- 30/07/2026 June: Update Product Table Information.
UPDATE product SET active ='0', sub_product_active ='0' WHERE user_create='cft.admin';

-- PROD 31 Jul 2026

-- 04/08/2026 Chaiwit: Create table mr and doc_status for material request system
CREATE TABLE `mr` (
  `mr_id` varchar(16) NOT NULL,
  `catalog_items_id` varchar(8) NOT NULL,
  `item_type` varchar(32) DEFAULT NULL,
  `item_sub_id` varchar(32) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status_id` varchar(8) DEFAULT NULL,
  `request_user` varchar(50) DEFAULT NULL,
  `request_date` date DEFAULT NULL,
  `approve_user` varchar(32) DEFAULT NULL,
  `approve_date` date DEFAULT NULL,
  `receive_user` varchar(32) DEFAULT NULL,
  `receive_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url_ref` text DEFAULT NULL,
  `user_update` timestamp NULL DEFAULT NULL,
  `time_create` varchar(32) DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `doc_status` (
  `doc_status_id` VARCHAR(32) NOT NULL,
  `status_code` VARCHAR(32) NOT NULL,
  `status_name` VARCHAR(200) DEFAULT NULL,
  `group` VARCHAR(200) DEFAULT NULL,
  `decscription` VARCHAR(1024) NOT NULL,
  `user_create` VARCHAR(32) DEFAULT NULL,
  `user_update` VARCHAR(32) DEFAULT NULL,
  `time_create` TIMESTAMP NULL DEFAULT NULL,
  `time_update` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`doc_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 04/08/2026 Koy: add auto_increment to unit_id in table unit_of_measure.
ALTER TABLE `unit_of_measure` CHANGE `unit_id` `unit_id` INT(11) NOT NULL AUTO_INCREMENT, add PRIMARY KEY (`unit_id`);

-- 05/08/2026 Koy: add column 'warehouse_id' in table stock.
CREATE TABLE `stock` (
    `stock_id` varchar(16) NOT NULL,
    `product_id` varchar(16) DEFAULT NULL,
    `action_type` varchar(32) DEFAULT NULL COMMENT 'gr_issue, mr_issue, direct_issue',
    `action_ref` varchar(32) DEFAULT NULL,
    `unit` varchar(32) DEFAULT NULL COMMENT 'unit ที่ใช้ใน action_type',
    `amount_unit` double DEFAULT NULL COMMENT 'จำนวนตาม action_type',
    `amount_convert` double DEFAULT NULL COMMENT 'จำนวนตาม Unit หลัก',
    `reconcile` double DEFAULT NULL COMMENT 'ผลรวมกระทบยอด',
    `warehouse_id` varchar(16) DEFAULT NULL,
    `description` text DEFAULT NULL,
    `user_create` varchar(32) DEFAULT NULL,
    `user_update` varchar(32) DEFAULT NULL,
    `time_create` timestamp NOT NULL DEFAULT current_timestamp(),
    `time_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`stock_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4

-- 05/08/2026 Koy: create table good_receipt, good_receipt_detail and unit_of_measure.
CREATE TABLE `good_receipt` (
    `good_receipt_id` int(11) NOT NULL AUTO_INCREMENT,
    `gr_ref` varchar(256) DEFAULT NULL,
    `receive_date` datetime DEFAULT NULL,
    `recipient_user` varchar(32) DEFAULT NULL COMMENT 'ผู้รับ',
    `warehouse_id` varchar(32) DEFAULT NULL,
    `description` text DEFAULT NULL,
    `user_create` varchar(32) DEFAULT NULL,
    `user_update` varchar(32) DEFAULT NULL,
    `time_create` timestamp NULL DEFAULT NULL,
    `time_update` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`good_receipt_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4

CREATE TABLE `good_receipt_detail` (
    `good_receipt_detail_id` int(11) NOT NULL AUTO_INCREMENT,
    `good_receipt_id` varchar(32) DEFAULT NULL,
    `po_id` varchar(32) DEFAULT NULL,
    `product_id` varchar(32) DEFAULT NULL,
    `parent` varchar(32) DEFAULT NULL COMMENT 'sub product',
    `amount` double DEFAULT NULL,
    `unit` varchar(32) DEFAULT NULL,
    `warehouse_id` varchar(32) DEFAULT NULL,
    `description` text DEFAULT NULL,
    `user_create` varchar(32) DEFAULT NULL,
    `user_update` varchar(32) DEFAULT NULL,
    `time_create` timestamp NULL DEFAULT NULL,
    `time_update` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`good_receipt_detail_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4

CREATE TABLE `unit_of_measure` (
    `unit_id` int(11) NOT NULL AUTO_INCREMENT,
    `product_id` varchar(32) NOT NULL,
    `sequence` varchar(32) DEFAULT NULL,
    `unit_name` varchar(32) DEFAULT NULL,
    `conversion_rate` int(11) DEFAULT NULL,
    `description` text DEFAULT NULL,
    `user_create` varchar(32) DEFAULT NULL,
    `user_update` varchar(32) DEFAULT NULL,
    `time_create` timestamp NULL DEFAULT NULL,
    `time_update` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`unit_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4

-- PROD 10 AUG 2026 9:50

