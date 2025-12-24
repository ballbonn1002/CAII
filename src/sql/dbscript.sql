

-- 01/10/2025 Koy : add 'work_type' column to 'work_hour' table
ALTER TABLE `work_hours` ADD `work_type` CHAR(1) NULL DEFAULT NULL AFTER `work_hours_time_work`;

-- 01/10/2025 Koy : update work_type, onsite_num in all user
UPDATE `user` SET `work_type`='1',`onsite_num`='3'

-- INIT PROD -- 2025 Nov 10
-- 24/12/2025 fluke(Intern): add 'color_2' column to 'equipment_status' table --
ALTER TABLE `equipment_status` ADD `color_2` VARCHAR(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `color`;