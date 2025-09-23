
// PROD / UAT 13 MAR 2025

--4/4/2025/Maetha/create table announcement
CREATE TABLE `announcement` (
  `announcement_id` bigint(20) NOT NULL,
  `topic` varchar(8) NOT NULL,
  `file_id` varchar(8) DEFAULT NULL,
  `detail` mediumtext DEFAULT NULL,
  `status` varchar(9) DEFAULT NULL,
  `announcement_date` date DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `user_create` varchar(32) DEFAULT NULL,
  `user_update` varchar(32) DEFAULT NULL,
  `time_create` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--10/4/2025/Maetha/Edit Structure table announcement
CREATE TABLE `announcement` (
  `announcement_id` bigint(20) NOT NULL,
  `topic` varchar(1024) NOT NULL,
  `file_id` varchar(8) DEFAULT NULL,
  `detail` mediumtext DEFAULT NULL,
  `status` varchar(9) DEFAULT NULL,
  `announcement_date` date DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `user_create` varchar(32) DEFAULT NULL,
  `user_update` varchar(32) DEFAULT NULL,
  `time_create` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

// PROD / UAT 10 APR 2025

--10/4/2025/Maetha/Create permission Announcement
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `time_create`, `time_update`, `authorized_object_group_id`) VALUES ('announcement.view', 'announcement.view', '����ö�� announcement ��', '2025-04-21 11:28:39', '2025-04-21 11:28:39', '1');
INSERT INTO `authorized_object` (`authorized_object_id`, `name`, `description`, `time_create`, `time_update`, `authorized_object_group_id`) VALUES ('announcement.edit', 'announcement.edit', '����ö���� announcement ��', '2025-04-21 12:01:32', '2025-04-21 12:01:32', '1');

// PROD / UAT 24 APR 2025

-- 20/5/2025/Book/Alter Table Announcement && Table Ticket Collation
ALTER TABLE announcement ADD readcount INT(11) NOT NULL DEFAULT 0 AFTER time_update;
ALTER TABLE `ticket` CHANGE `title` `title` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `tag` `tag` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL;

-- 22/5/2025/Book/Add Announcement Permissions to Admin Role
INSERT INTO role_authorized_object (role_id, authorized_object_id, time_create, time_update)
VALUES ('admin', 'announcement.view', NOW(), NOW());
INSERT INTO role_authorized_object (role_id, authorized_object_id, time_create, time_update)
VALUES ('admin', 'announcement.edit', NOW(), NOW());

-- 27
ALTER TABLE article ADD COLUMN time_post TIMESTAMP NULL DEFAULT NULL AFTER topic_en;
ALTER TABLE `user` ADD `inc_da` VARCHAR(1) NULL AFTER `passport_id`, ADD `inc_nb` VARCHAR(1) NULL AFTER `inc_da`;

update user
set inc_da = '0'
where user.employee_type_id = '3' or user.employee_type_id = '2'  ;

update user
set inc_nb = '0';

// PROD / UAT 2 JUN 2025

-- 16/06/2025 Koy : add colummn for alt name in File
ALTER TABLE `file` ADD `alt_name` VARCHAR(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `path`;

-- 16/06/2025 Koy : add payment_remark to User
ALTER TABLE `user` ADD `payment_remark` VARCHAR(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `inc_nb`;

-- 18/6/2025/Book/Alter Table equipment
ALTER TABLE equipment ADD COLUMN fix_detail VARCHAR(1024) CHARACTER SET utf8 COLLATE utf8_general_ci;

// PROD / UAT 20 JUN 2025

-- 24/6/2025/Book/Fix table readcount
ALTER TABLE `announcement` CHANGE `readcount` `readcount` INT(11) NULL DEFAULT '0';

-- 24/6/2025/ Eric : alter table ticket and ticket_reply
ALTER TABLE `ticket` CHANGE `file_id` `file_id` VARCHAR(200) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `title` `title` VARCHAR(1024) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `tag` `tag` VARCHAR(200) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `status` `status` VARCHAR(8) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `priority` `priority` VARCHAR(1) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `detail` `detail` VARCHAR(1024) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `description` `description` VARCHAR(1024) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `user_create` `user_create` VARCHAR(32) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket` CHANGE `user_update` `user_update` VARCHAR(32) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;

ALTER TABLE `ticket_reply` CHANGE `ticket_id` `ticket_id` VARCHAR(8) COLLATE utf8mb4_general_ci NOT NULL;
ALTER TABLE `ticket_reply` CHANGE `file_id` `file_id` VARCHAR(200) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket_reply` CHANGE `status` `status` VARCHAR(1) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket_reply` CHANGE `detail` `detail` VARCHAR(1024) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket_reply` CHANGE `description` `description` VARCHAR(1024) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket_reply` CHANGE `user_create` `user_create` VARCHAR(32) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `ticket_reply` CHANGE `user_update` `user_update` VARCHAR(32) COLLATE utf8mb4_general_ci NULL DEFAULT NULL;

// PROD / UAT 25 JUN 2025

-- 18/07/2025 Koy : add 'time_post' column to Article
ALTER TABLE article ADD COLUMN time_post TIMESTAMP NULL DEFAULT NULL AFTER topic_en;


-- 22/07/2025 Book : change column name for collect status log change
ALTER TABLE `equipment` CHANGE `fix_detail` `status_log` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL;

-- PROD / UAT 6 AUG 2025 -- #2 

-- 23/09/2025/Benz/create table sso_token
CREATE TABLE IF NOT EXISTS sso_token (
  token_id      CHAR(36)     NOT NULL PRIMARY KEY,
  user_id       VARCHAR(64)  NOT NULL,
  issued_at     DATETIME     NOT NULL,
  expires_at    DATETIME     NOT NULL,
  last_seen_at  DATETIME     NULL,
  status        ENUM('ACTIVE','REVOKED','EXPIRED') NOT NULL DEFAULT 'ACTIVE',
  user_agent    VARCHAR(255) NULL,
  ip_addr       VARCHAR(64)  NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_sso_token_user ON sso_token (user_id, status);
CREATE INDEX idx_sso_token_exp  ON sso_token (expires_at);





