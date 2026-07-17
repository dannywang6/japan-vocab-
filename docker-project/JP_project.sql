/*
 Navicat Premium Dump SQL

 Source Server         : 1
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3306
 Source Schema         : JP_project

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 12/07/2026 13:50:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for quiz_record
-- ----------------------------
DROP TABLE IF EXISTS `quiz_record`;
CREATE TABLE `quiz_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vocab_id` bigint NOT NULL,
  `quiz_type` varchar(20) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `answered_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of quiz_record
-- ----------------------------
BEGIN;
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (1, 22, 'jp_to_cn', 1, '2026-07-01 23:21:55');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (2, 23, 'jp_to_cn', 1, '2026-07-01 23:21:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (3, 16, 'jp_to_cn', 1, '2026-07-01 23:22:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (4, 26, 'jp_to_cn', 1, '2026-07-01 23:22:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (5, 39, 'jp_to_cn', 1, '2026-07-01 23:22:09');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (6, 21, 'jp_to_cn', 1, '2026-07-01 23:22:12');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (7, 28, 'jp_to_cn', 1, '2026-07-01 23:22:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (8, 2, 'jp_to_cn', 1, '2026-07-01 23:22:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (9, 5, 'jp_to_cn', 1, '2026-07-01 23:22:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (10, 8, 'jp_to_cn', 1, '2026-07-01 23:22:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (11, 40, 'jp_to_cn', 1, '2026-07-01 23:22:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (12, 14, 'jp_to_cn', 1, '2026-07-01 23:22:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (13, 1, 'jp_to_cn', 0, '2026-07-01 23:22:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (14, 28, 'jp_to_cn', 1, '2026-07-01 23:22:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (15, 16, 'jp_to_cn', 1, '2026-07-01 23:22:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (16, 1, 'jp_to_cn', 1, '2026-07-01 23:22:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (17, 23, 'jp_to_cn', 1, '2026-07-01 23:22:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (18, 1, 'jp_to_cn', 1, '2026-07-01 23:22:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (19, 24, 'jp_to_cn', 1, '2026-07-01 23:23:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (20, 21, 'jp_to_cn', 1, '2026-07-01 23:23:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (21, 1, 'jp_to_cn', 1, '2026-07-01 23:23:04');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (22, 8, 'jp_to_cn', 1, '2026-07-01 23:23:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (23, 26, 'jp_to_cn', 1, '2026-07-01 23:23:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (24, 30, 'jp_to_cn', 1, '2026-07-01 23:23:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (25, 1, 'jp_to_cn', 1, '2026-07-01 23:23:15');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (26, 1, 'jp_to_cn', 1, '2026-07-01 23:23:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (27, 15, 'jp_to_cn', 1, '2026-07-01 23:23:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (28, 1, 'jp_to_cn', 1, '2026-07-01 23:23:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (29, 1, 'jp_to_cn', 1, '2026-07-01 23:23:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (30, 1, 'jp_to_cn', 1, '2026-07-01 23:23:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (31, 32, 'jp_to_cn', 1, '2026-07-01 23:23:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (32, 16, 'jp_to_cn', 1, '2026-07-01 23:23:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (33, 1, 'jp_to_cn', 1, '2026-07-01 23:23:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (34, 36, 'jp_to_cn', 1, '2026-07-01 23:23:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (35, 30, 'jp_to_cn', 1, '2026-07-01 23:23:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (36, 1, 'jp_to_cn', 1, '2026-07-01 23:23:34');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (37, 1, 'jp_to_cn', 1, '2026-07-01 23:23:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (38, 30, 'jp_to_cn', 1, '2026-07-01 23:23:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (39, 1, 'cn_to_jp', 0, '2026-07-01 23:23:55');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (40, 18, 'cn_to_jp', 0, '2026-07-01 23:24:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (41, 33, 'cn_to_jp', 1, '2026-07-01 23:24:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (42, 5, 'cn_to_jp', 1, '2026-07-01 23:24:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (43, 15, 'cn_to_jp', 1, '2026-07-01 23:24:15');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (44, 26, 'cn_to_jp', 1, '2026-07-01 23:24:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (45, 18, 'jp_to_cn', 1, '2026-07-01 23:24:37');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (46, 18, 'jp_to_cn', 1, '2026-07-01 23:24:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (47, 24, 'jp_to_cn', 1, '2026-07-01 23:24:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (48, 41, 'jp_to_cn', 1, '2026-07-01 23:24:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (49, 13, 'jp_to_cn', 1, '2026-07-01 23:25:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (50, 10, 'jp_to_cn', 1, '2026-07-01 23:25:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (51, 18, 'jp_to_cn', 1, '2026-07-01 23:25:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (52, 2, 'jp_to_cn', 0, '2026-07-01 23:25:30');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (53, 4, 'jp_to_cn', 1, '2026-07-01 23:30:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (54, 18, 'jp_to_cn', 0, '2026-07-01 23:38:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (55, 37, 'jp_to_cn', 0, '2026-07-01 23:38:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (56, 10, 'jp_to_cn', 0, '2026-07-01 23:39:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (57, 10, 'jp_to_cn', 1, '2026-07-01 23:39:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (58, 2, 'jp_to_cn', 0, '2026-07-01 23:39:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (59, 2, 'jp_to_cn', 1, '2026-07-01 23:39:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (60, 13, 'jp_to_cn', 0, '2026-07-01 23:39:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (61, 6, 'jp_to_cn', 1, '2026-07-01 23:39:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (62, 18, 'jp_to_cn', 0, '2026-07-01 23:39:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (63, 27, 'jp_to_cn', 0, '2026-07-01 23:39:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (64, 27, 'jp_to_cn', 0, '2026-07-01 23:40:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (65, 34, 'jp_to_cn', 0, '2026-07-01 23:40:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (66, 2, 'jp_to_cn', 1, '2026-07-01 23:40:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (67, 38, 'jp_to_cn', 0, '2026-07-01 23:40:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (68, 28, 'jp_to_cn', 0, '2026-07-01 23:41:04');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (69, 20, 'jp_to_cn', 0, '2026-07-01 23:41:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (70, 35, 'jp_to_cn', 1, '2026-07-01 23:41:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (71, 24, 'jp_to_cn', 0, '2026-07-01 23:42:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (72, 17, 'jp_to_cn', 1, '2026-07-01 23:42:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (73, 35, 'jp_to_cn', 0, '2026-07-01 23:42:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (74, 19, 'jp_to_cn', 0, '2026-07-01 23:45:15');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (75, 30, 'jp_to_cn', 1, '2026-07-01 23:46:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (76, 38, 'jp_to_cn', 1, '2026-07-01 23:46:22');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (77, 12, 'jp_to_cn', 1, '2026-07-01 23:46:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (78, 38, 'jp_to_cn', 1, '2026-07-01 23:46:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (79, 23, 'jp_to_cn', 1, '2026-07-01 23:46:30');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (80, 8, 'jp_to_cn', 1, '2026-07-01 23:46:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (81, 30, 'jp_to_cn', 1, '2026-07-01 23:46:34');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (82, 19, 'jp_to_cn', 0, '2026-07-01 23:46:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (83, 13, 'jp_to_cn', 0, '2026-07-01 23:46:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (84, 27, 'jp_to_cn', 1, '2026-07-01 23:46:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (85, 9, 'jp_to_cn', 1, '2026-07-01 23:46:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (86, 32, 'jp_to_cn', 1, '2026-07-01 23:47:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (87, 18, 'jp_to_cn', 0, '2026-07-01 23:47:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (88, 24, 'jp_to_cn', 1, '2026-07-01 23:47:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (89, 20, 'jp_to_cn', 0, '2026-07-01 23:47:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (90, 29, 'jp_to_cn', 1, '2026-07-01 23:47:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (91, 11, 'jp_to_cn', 0, '2026-07-01 23:47:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (92, 24, 'jp_to_cn', 1, '2026-07-01 23:47:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (93, 26, 'jp_to_cn', 1, '2026-07-01 23:47:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (94, 20, 'jp_to_cn', 0, '2026-07-01 23:47:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (95, 8, 'jp_to_cn', 1, '2026-07-01 23:47:34');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (96, 27, 'jp_to_cn', 1, '2026-07-01 23:47:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (97, 39, 'jp_to_cn', 0, '2026-07-01 23:47:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (98, 8, 'jp_to_cn', 0, '2026-07-01 23:47:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (99, 32, 'jp_to_cn', 1, '2026-07-01 23:47:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (100, 13, 'jp_to_cn', 0, '2026-07-01 23:47:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (101, 25, 'jp_to_cn', 1, '2026-07-01 23:47:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (102, 2, 'jp_to_cn', 0, '2026-07-01 23:47:55');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (103, 1, 'jp_to_cn', 0, '2026-07-01 23:48:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (104, 41, 'jp_to_cn', 0, '2026-07-01 23:48:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (105, 25, 'jp_to_cn', 1, '2026-07-01 23:48:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (106, 12, 'jp_to_cn', 1, '2026-07-01 23:48:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (107, 20, 'jp_to_cn', 1, '2026-07-01 23:48:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (108, 36, 'jp_to_cn', 1, '2026-07-01 23:48:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (109, 9, 'jp_to_cn', 1, '2026-07-01 23:48:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (110, 12, 'jp_to_cn', 1, '2026-07-01 23:48:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (111, 2, 'jp_to_cn', 1, '2026-07-01 23:48:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (112, 32, 'jp_to_cn', 1, '2026-07-01 23:48:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (113, 2, 'jp_to_cn', 1, '2026-07-01 23:48:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (114, 34, 'jp_to_cn', 1, '2026-07-01 23:48:50');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (115, 34, 'jp_to_cn', 1, '2026-07-01 23:48:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (116, 39, 'jp_to_cn', 1, '2026-07-01 23:48:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (117, 37, 'jp_to_cn', 0, '2026-07-01 23:48:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (118, 4, 'jp_to_cn', 1, '2026-07-01 23:49:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (119, 27, 'jp_to_cn', 1, '2026-07-01 23:49:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (120, 13, 'jp_to_cn', 1, '2026-07-01 23:49:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (121, 8, 'jp_to_cn', 1, '2026-07-01 23:49:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (122, 33, 'jp_to_cn', 1, '2026-07-01 23:49:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (123, 13, 'jp_to_cn', 1, '2026-07-01 23:49:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (124, 35, 'jp_to_cn', 1, '2026-07-01 23:49:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (125, 40, 'cn_to_jp', 1, '2026-07-01 23:49:22');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (126, 17, 'cn_to_jp', 1, '2026-07-01 23:49:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (127, 36, 'cn_to_jp', 1, '2026-07-01 23:49:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (128, 35, 'cn_to_jp', 1, '2026-07-01 23:49:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (129, 26, 'cn_to_jp', 1, '2026-07-01 23:49:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (130, 18, 'jp_to_cn', 1, '2026-07-01 23:49:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (131, 22, 'jp_to_cn', 1, '2026-07-01 23:49:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (132, 23, 'jp_to_cn', 1, '2026-07-01 23:49:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (133, 16, 'jp_to_cn', 1, '2026-07-01 23:49:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (134, 17, 'jp_to_cn', 1, '2026-07-01 23:49:54');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (135, 32, 'jp_to_cn', 1, '2026-07-01 23:49:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (136, 1, 'jp_to_cn', 0, '2026-07-01 23:49:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (137, 31, 'cn_to_jp', 0, '2026-07-02 00:51:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (138, 11, 'jp_to_cn', 1, '2026-07-02 00:51:55');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (139, 7, 'jp_to_cn', 0, '2026-07-02 00:52:04');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (140, 17, 'jp_to_cn', 1, '2026-07-02 00:52:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (141, 11, 'jp_to_cn', 1, '2026-07-02 00:52:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (142, 7, 'jp_to_cn', 1, '2026-07-02 00:52:22');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (143, 22, 'jp_to_cn', 1, '2026-07-02 00:52:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (144, 33, 'jp_to_cn', 1, '2026-07-02 12:14:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (145, 7, 'jp_to_cn', 1, '2026-07-02 12:14:32');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (146, 35, 'jp_to_cn', 1, '2026-07-02 12:14:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (147, 10, 'jp_to_cn', 1, '2026-07-02 12:14:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (148, 33, 'jp_to_cn', 1, '2026-07-02 12:14:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (149, 11, 'jp_to_cn', 1, '2026-07-02 12:14:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (150, 17, 'jp_to_cn', 1, '2026-07-02 12:14:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (151, 18, 'jp_to_cn', 1, '2026-07-02 12:14:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (152, 6, 'jp_to_cn', 1, '2026-07-02 12:14:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (153, 31, 'jp_to_cn', 1, '2026-07-02 12:14:54');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (154, 26, 'jp_to_cn', 1, '2026-07-02 12:14:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (155, 1, 'jp_to_cn', 1, '2026-07-02 12:15:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (156, 1, 'jp_to_cn', 1, '2026-07-02 12:15:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (157, 11, 'jp_to_cn', 1, '2026-07-02 12:15:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (158, 31, 'jp_to_cn', 1, '2026-07-02 12:15:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (159, 30, 'jp_to_cn', 1, '2026-07-02 12:15:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (160, 37, 'jp_to_cn', 1, '2026-07-02 12:15:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (161, 19, 'jp_to_cn', 1, '2026-07-02 12:15:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (162, 33, 'jp_to_cn', 1, '2026-07-02 12:15:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (163, 29, 'jp_to_cn', 1, '2026-07-02 12:15:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (164, 8, 'jp_to_cn', 1, '2026-07-02 12:15:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (165, 4, 'jp_to_cn', 1, '2026-07-02 12:15:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (166, 31, 'jp_to_cn', 1, '2026-07-02 12:15:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (167, 8, 'jp_to_cn', 1, '2026-07-02 12:15:22');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (168, 14, 'jp_to_cn', 1, '2026-07-02 12:15:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (169, 13, 'jp_to_cn', 1, '2026-07-02 12:15:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (170, 4, 'jp_to_cn', 1, '2026-07-02 12:15:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (171, 36, 'jp_to_cn', 1, '2026-07-02 12:15:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (172, 31, 'jp_to_cn', 1, '2026-07-02 12:15:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (173, 41, 'jp_to_cn', 1, '2026-07-02 12:15:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (174, 33, 'jp_to_cn', 1, '2026-07-02 12:15:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (175, 27, 'jp_to_cn', 1, '2026-07-02 12:15:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (176, 12, 'jp_to_cn', 1, '2026-07-02 12:15:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (177, 6, 'jp_to_cn', 1, '2026-07-02 12:15:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (178, 31, 'cn_to_jp', 1, '2026-07-02 12:15:50');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (179, 28, 'cn_to_jp', 1, '2026-07-02 12:15:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (180, 1, 'cn_to_jp', 1, '2026-07-02 12:15:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (181, 9, 'cn_to_jp', 1, '2026-07-02 12:15:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (182, 13, 'cn_to_jp', 1, '2026-07-02 12:16:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (183, 38, 'jp_to_cn', 1, '2026-07-02 15:40:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (184, 40, 'jp_to_cn', 1, '2026-07-02 15:40:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (185, 6, 'jp_to_cn', 1, '2026-07-02 15:40:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (186, 8, 'jp_to_cn', 1, '2026-07-02 15:40:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (187, 37, 'jp_to_cn', 1, '2026-07-02 15:40:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (188, 33, 'jp_to_cn', 1, '2026-07-02 15:40:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (189, 29, 'jp_to_cn', 1, '2026-07-02 15:40:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (190, 36, 'jp_to_cn', 1, '2026-07-02 15:40:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (191, 8, 'jp_to_cn', 1, '2026-07-03 00:47:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (192, 10, 'jp_to_cn', 1, '2026-07-03 00:47:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (193, 32, 'jp_to_cn', 1, '2026-07-03 00:47:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (194, 12, 'jp_to_cn', 1, '2026-07-03 00:47:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (195, 33, 'jp_to_cn', 1, '2026-07-03 00:47:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (196, 39, 'jp_to_cn', 1, '2026-07-03 00:47:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (197, 34, 'jp_to_cn', 1, '2026-07-03 00:47:32');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (198, 11, 'jp_to_cn', 1, '2026-07-03 00:47:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (199, 26, 'jp_to_cn', 1, '2026-07-03 00:47:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (200, 21, 'jp_to_cn', 1, '2026-07-03 00:47:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (201, 20, 'jp_to_cn', 0, '2026-07-03 00:47:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (202, 20, 'jp_to_cn', 0, '2026-07-03 00:47:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (203, 36, 'jp_to_cn', 1, '2026-07-03 00:47:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (204, 33, 'jp_to_cn', 1, '2026-07-03 00:47:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (205, 15, 'jp_to_cn', 0, '2026-07-03 00:47:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (206, 8, 'jp_to_cn', 0, '2026-07-03 00:48:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (207, 32, 'jp_to_cn', 0, '2026-07-03 00:48:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (208, 7, 'jp_to_cn', 1, '2026-07-03 00:48:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (209, 39, 'jp_to_cn', 0, '2026-07-03 00:48:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (210, 2, 'jp_to_cn', 0, '2026-07-03 00:48:04');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (211, 31, 'jp_to_cn', 0, '2026-07-03 00:48:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (212, 35, 'jp_to_cn', 0, '2026-07-03 00:48:07');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (213, 8, 'jp_to_cn', 1, '2026-07-03 00:48:07');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (214, 16, 'jp_to_cn', 0, '2026-07-03 00:48:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (215, 33, 'jp_to_cn', 0, '2026-07-03 00:48:09');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (216, 31, 'jp_to_cn', 1, '2026-07-03 00:48:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (217, 7, 'jp_to_cn', 1, '2026-07-03 00:48:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (218, 21, 'jp_to_cn', 0, '2026-07-03 00:48:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (219, 40, 'jp_to_cn', 0, '2026-07-03 00:48:12');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (220, 14, 'jp_to_cn', 0, '2026-07-03 00:48:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (221, 36, 'cn_to_jp', 0, '2026-07-03 00:48:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (222, 32, 'cn_to_jp', 0, '2026-07-03 00:48:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (223, 38, 'jp_to_cn', 0, '2026-07-03 00:48:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (224, 39, 'jp_to_cn', 1, '2026-07-03 00:50:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (225, 12, 'jp_to_cn', 0, '2026-07-03 00:50:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (226, 22, 'jp_to_cn', 1, '2026-07-03 00:50:37');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (227, 24, 'jp_to_cn', 1, '2026-07-03 00:50:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (228, 30, 'jp_to_cn', 1, '2026-07-03 00:50:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (229, 5, 'jp_to_cn', 1, '2026-07-03 00:50:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (230, 5, 'jp_to_cn', 1, '2026-07-03 00:50:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (231, 40, 'jp_to_cn', 1, '2026-07-03 00:50:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (232, 17, 'jp_to_cn', 1, '2026-07-03 00:51:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (233, 4, 'jp_to_cn', 1, '2026-07-03 00:51:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (234, 35, 'jp_to_cn', 1, '2026-07-03 00:51:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (235, 30, 'jp_to_cn', 1, '2026-07-03 00:51:07');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (236, 35, 'jp_to_cn', 1, '2026-07-03 00:51:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (237, 35, 'jp_to_cn', 1, '2026-07-03 00:53:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (238, 10, 'jp_to_cn', 0, '2026-07-03 00:53:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (239, 34, 'jp_to_cn', 1, '2026-07-03 00:53:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (240, 17, 'jp_to_cn', 1, '2026-07-03 00:54:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (241, 36, 'jp_to_cn', 1, '2026-07-03 00:54:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (242, 18, 'jp_to_cn', 1, '2026-07-03 00:54:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (243, 6, 'jp_to_cn', 1, '2026-07-03 00:54:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (244, 25, 'jp_to_cn', 1, '2026-07-03 00:54:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (245, 7, 'jp_to_cn', 0, '2026-07-03 00:54:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (246, 17, 'jp_to_cn', 0, '2026-07-03 00:54:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (247, 30, 'jp_to_cn', 1, '2026-07-03 00:55:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (248, 4, 'jp_to_cn', 1, '2026-07-03 00:55:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (249, 30, 'jp_to_cn', 0, '2026-07-03 00:56:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (250, 28, 'jp_to_cn', 0, '2026-07-03 00:57:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (251, 4, 'jp_to_cn', 0, '2026-07-03 00:58:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (252, 17, 'jp_to_cn', 0, '2026-07-03 00:58:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (253, 25, 'jp_to_cn', 1, '2026-07-03 01:01:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (254, 7, 'jp_to_cn', 1, '2026-07-03 01:04:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (255, 40, 'jp_to_cn', 0, '2026-07-03 01:04:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (256, 1, 'jp_to_cn', 0, '2026-07-03 01:05:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (257, 20, 'jp_to_cn', 0, '2026-07-03 01:05:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (258, 29, 'jp_to_cn', 0, '2026-07-03 01:06:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (259, 19, 'jp_to_cn', 0, '2026-07-03 01:11:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (260, 41, 'jp_to_cn', 0, '2026-07-03 01:11:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (261, 9, 'jp_to_cn', 1, '2026-07-03 01:11:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (262, 21, 'jp_to_cn', 1, '2026-07-03 01:11:55');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (263, 14, 'jp_to_cn', 0, '2026-07-03 01:11:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (264, 17, 'jp_to_cn', 0, '2026-07-03 01:12:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (265, 40, 'jp_to_cn', 0, '2026-07-03 01:15:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (266, 6, 'jp_to_cn', 0, '2026-07-03 01:18:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (267, 25, 'jp_to_cn', 0, '2026-07-03 01:19:54');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (268, 22, 'jp_to_cn', 0, '2026-07-03 01:20:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (269, 21, 'jp_to_cn', 1, '2026-07-03 01:21:07');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (270, 8, 'jp_to_cn', 0, '2026-07-03 01:21:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (271, 22, 'jp_to_cn', 1, '2026-07-03 01:21:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (272, 24, 'jp_to_cn', 1, '2026-07-03 01:21:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (273, 32, 'jp_to_cn', 0, '2026-07-03 01:21:31');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (274, 23, 'jp_to_cn', 0, '2026-07-03 01:21:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (275, 22, 'jp_to_cn', 0, '2026-07-03 01:22:37');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (276, 28, 'jp_to_cn', 1, '2026-07-03 01:23:09');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (277, 2, 'jp_to_cn', 1, '2026-07-03 01:23:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (278, 9, 'jp_to_cn', 1, '2026-07-03 01:23:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (279, 23, 'jp_to_cn', 1, '2026-07-03 01:23:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (280, 22, 'jp_to_cn', 1, '2026-07-03 01:23:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (281, 39, 'jp_to_cn', 1, '2026-07-03 01:23:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (282, 8, 'jp_to_cn', 0, '2026-07-03 01:26:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (283, 7, 'jp_to_cn', 0, '2026-07-03 01:26:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (284, 14, 'jp_to_cn', 1, '2026-07-03 01:27:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (285, 34, 'jp_to_cn', 1, '2026-07-03 01:27:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (286, 5, 'jp_to_cn', 0, '2026-07-03 01:27:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (287, 32, 'jp_to_cn', 1, '2026-07-03 01:27:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (288, 31, 'jp_to_cn', 1, '2026-07-03 01:27:12');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (289, 4, 'jp_to_cn', 1, '2026-07-03 01:27:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (290, 9, 'jp_to_cn', 0, '2026-07-03 01:27:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (291, 16, 'jp_to_cn', 0, '2026-07-03 01:27:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (292, 40, 'jp_to_cn', 0, '2026-07-03 01:27:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (293, 24, 'jp_to_cn', 0, '2026-07-03 01:28:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (294, 4, 'jp_to_cn', 1, '2026-07-03 01:29:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (295, 41, 'jp_to_cn', 1, '2026-07-03 01:29:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (296, 24, 'jp_to_cn', 1, '2026-07-03 01:30:01');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (297, 20, 'jp_to_cn', 0, '2026-07-03 01:30:09');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (298, 32, 'jp_to_cn', 1, '2026-07-03 01:30:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (299, 55, 'jp_to_cn', 1, '2026-07-03 01:30:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (300, 5, 'jp_to_cn', 1, '2026-07-03 01:30:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (301, 69, 'jp_to_cn', 1, '2026-07-03 01:30:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (302, 65, 'jp_to_cn', 1, '2026-07-03 01:30:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (303, 46, 'jp_to_cn', 1, '2026-07-03 01:30:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (304, 10, 'jp_to_cn', 1, '2026-07-03 01:30:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (305, 15, 'jp_to_cn', 1, '2026-07-03 01:30:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (306, 24, 'jp_to_cn', 1, '2026-07-03 01:30:29');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (307, 6, 'jp_to_cn', 1, '2026-07-03 01:30:30');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (308, 19, 'jp_to_cn', 1, '2026-07-03 01:30:32');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (309, 44, 'jp_to_cn', 1, '2026-07-03 01:30:34');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (310, 42, 'jp_to_cn', 1, '2026-07-03 01:30:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (311, 48, 'jp_to_cn', 1, '2026-07-03 01:30:37');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (312, 45, 'jp_to_cn', 1, '2026-07-03 01:30:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (313, 64, 'jp_to_cn', 0, '2026-07-03 01:30:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (314, 63, 'jp_to_cn', 0, '2026-07-03 01:30:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (315, 66, 'jp_to_cn', 0, '2026-07-03 01:30:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (316, 51, 'jp_to_cn', 0, '2026-07-03 01:30:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (317, 68, 'jp_to_cn', 0, '2026-07-03 01:30:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (318, 69, 'jp_to_cn', 0, '2026-07-03 01:30:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (319, 48, 'jp_to_cn', 0, '2026-07-03 01:30:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (320, 18, 'jp_to_cn', 0, '2026-07-03 01:30:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (321, 22, 'jp_to_cn', 0, '2026-07-03 01:30:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (322, 19, 'jp_to_cn', 0, '2026-07-03 01:30:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (323, 50, 'jp_to_cn', 0, '2026-07-03 01:30:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (324, 71, 'jp_to_cn', 1, '2026-07-03 01:30:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (325, 17, 'jp_to_cn', 1, '2026-07-03 01:30:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (326, 33, 'jp_to_cn', 0, '2026-07-03 01:30:50');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (327, 48, 'jp_to_cn', 0, '2026-07-03 01:30:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (328, 42, 'jp_to_cn', 0, '2026-07-03 01:30:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (329, 26, 'jp_to_cn', 0, '2026-07-03 01:30:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (330, 49, 'jp_to_cn', 0, '2026-07-03 01:37:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (331, 24, 'jp_to_cn', 0, '2026-07-03 01:37:59');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (332, 43, 'jp_to_cn', 1, '2026-07-03 01:38:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (333, 52, 'jp_to_cn', 0, '2026-07-03 01:38:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (334, 15, 'jp_to_cn', 0, '2026-07-03 01:38:50');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (335, 61, 'jp_to_cn', 1, '2026-07-03 01:47:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (336, 45, 'jp_to_cn', 0, '2026-07-03 01:47:18');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (337, 43, 'jp_to_cn', 1, '2026-07-03 01:47:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (338, 49, 'jp_to_cn', 0, '2026-07-03 01:47:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (339, 19, 'jp_to_cn', 0, '2026-07-03 11:08:11');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (340, 48, 'jp_to_cn', 1, '2026-07-03 11:08:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (341, 71, 'jp_to_cn', 1, '2026-07-03 11:08:21');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (342, 71, 'jp_to_cn', 1, '2026-07-03 11:08:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (343, 44, 'jp_to_cn', 1, '2026-07-03 11:08:27');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (344, 44, 'jp_to_cn', 1, '2026-07-06 12:25:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (345, 41, 'jp_to_cn', 1, '2026-07-06 12:34:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (346, 39, 'jp_to_cn', 1, '2026-07-06 15:15:52');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (347, 61, 'jp_to_cn', 1, '2026-07-06 15:16:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (348, 17, 'jp_to_cn', 1, '2026-07-06 15:16:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (349, 67, 'jp_to_cn', 1, '2026-07-06 15:16:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (350, 52, 'jp_to_cn', 0, '2026-07-06 15:16:12');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (351, 39, 'jp_to_cn', 1, '2026-07-06 15:18:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (352, 34, 'jp_to_cn', 1, '2026-07-06 15:18:02');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (353, 28, 'jp_to_cn', 1, '2026-07-06 15:18:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (354, 43, 'jp_to_cn', 0, '2026-07-06 15:18:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (355, 29, 'jp_to_cn', 1, '2026-07-06 15:18:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (356, 12, 'jp_to_cn', 1, '2026-07-06 15:18:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (357, 46, 'jp_to_cn', 1, '2026-07-06 15:18:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (358, 61, 'jp_to_cn', 1, '2026-07-06 15:18:30');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (359, 55, 'jp_to_cn', 1, '2026-07-06 15:18:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (360, 8, 'jp_to_cn', 1, '2026-07-06 15:18:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (361, 62, 'jp_to_cn', 1, '2026-07-06 15:18:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (362, 64, 'jp_to_cn', 1, '2026-07-06 15:18:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (363, 62, 'jp_to_cn', 1, '2026-07-06 15:18:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (364, 60, 'jp_to_cn', 1, '2026-07-06 15:18:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (365, 7, 'jp_to_cn', 1, '2026-07-06 15:18:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (366, 62, 'jp_to_cn', 1, '2026-07-06 15:18:48');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (367, 62, 'jp_to_cn', 1, '2026-07-06 15:18:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (368, 60, 'jp_to_cn', 1, '2026-07-06 15:18:51');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (369, 1, 'jp_to_cn', 1, '2026-07-06 15:18:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (370, 67, 'jp_to_cn', 1, '2026-07-06 15:18:54');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (371, 66, 'jp_to_cn', 1, '2026-07-06 15:18:57');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (372, 45, 'jp_to_cn', 1, '2026-07-06 15:18:58');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (373, 37, 'jp_to_cn', 1, '2026-07-06 15:19:00');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (374, 48, 'jp_to_cn', 1, '2026-07-06 15:19:03');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (375, 5, 'jp_to_cn', 1, '2026-07-06 15:19:05');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (376, 24, 'jp_to_cn', 1, '2026-07-06 15:19:06');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (377, 32, 'jp_to_cn', 1, '2026-07-06 15:19:08');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (378, 8, 'jp_to_cn', 1, '2026-07-06 15:19:09');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (379, 70, 'jp_to_cn', 1, '2026-07-06 15:19:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (380, 46, 'jp_to_cn', 1, '2026-07-06 15:19:12');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (381, 69, 'jp_to_cn', 1, '2026-07-06 15:19:13');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (382, 15, 'jp_to_cn', 1, '2026-07-06 15:19:14');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (383, 54, 'jp_to_cn', 1, '2026-07-06 15:19:16');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (384, 44, 'jp_to_cn', 1, '2026-07-06 15:19:17');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (385, 27, 'jp_to_cn', 1, '2026-07-06 15:19:19');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (386, 57, 'jp_to_cn', 1, '2026-07-06 15:19:20');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (387, 11, 'jp_to_cn', 1, '2026-07-06 15:19:24');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (388, 67, 'jp_to_cn', 1, '2026-07-06 15:19:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (389, 24, 'jp_to_cn', 1, '2026-07-06 15:19:26');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (390, 62, 'jp_to_cn', 1, '2026-07-06 15:19:28');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (391, 9, 'jp_to_cn', 1, '2026-07-06 15:19:30');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (392, 51, 'jp_to_cn', 1, '2026-07-06 15:19:33');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (393, 33, 'jp_to_cn', 1, '2026-07-06 15:19:35');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (394, 29, 'jp_to_cn', 1, '2026-07-06 15:19:36');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (395, 12, 'jp_to_cn', 1, '2026-07-06 15:19:39');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (396, 2, 'jp_to_cn', 1, '2026-07-06 15:19:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (397, 46, 'jp_to_cn', 1, '2026-07-06 15:19:44');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (398, 44, 'jp_to_cn', 1, '2026-07-06 15:19:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (399, 41, 'jp_to_cn', 1, '2026-07-06 15:19:47');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (400, 32, 'jp_to_cn', 1, '2026-07-06 15:19:49');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (401, 17, 'jp_to_cn', 1, '2026-07-06 15:19:50');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (402, 47, 'jp_to_cn', 1, '2026-07-06 15:19:53');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (403, 55, 'jp_to_cn', 0, '2026-07-06 19:20:42');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (404, 63, 'jp_to_cn', 1, '2026-07-06 19:20:54');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (405, 32, 'jp_to_cn', 0, '2026-07-06 19:20:56');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (406, 5, 'jp_to_cn', 1, '2026-07-06 19:29:38');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (407, 46, 'jp_to_cn', 1, '2026-07-06 19:29:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (408, 47, 'jp_to_cn', 1, '2026-07-06 19:29:43');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (409, 9, 'jp_to_cn', 1, '2026-07-06 19:29:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (410, 41, 'jp_to_cn', 1, '2026-07-06 19:51:45');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (411, 70, 'jp_to_cn', 0, '2026-07-06 19:51:46');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (412, 23, 'jp_to_cn', 1, '2026-07-06 19:52:40');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (413, 5, 'jp_to_cn', 0, '2026-07-06 19:52:41');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (414, 55, 'jp_to_cn', 1, '2026-07-08 16:05:23');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (415, 67, 'jp_to_cn', 1, '2026-07-08 16:05:25');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (416, 12, 'jp_to_cn', 0, '2026-07-08 16:05:32');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (417, 44, 'jp_to_cn', 1, '2026-07-11 20:48:10');
INSERT INTO `quiz_record` (`id`, `vocab_id`, `quiz_type`, `is_correct`, `answered_at`) VALUES (418, 20, 'jp_to_cn', 0, '2026-07-11 20:48:14');
COMMIT;

-- ----------------------------
-- Table structure for study_record
-- ----------------------------
DROP TABLE IF EXISTS `study_record`;
CREATE TABLE `study_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vocab_id` bigint NOT NULL,
  `review_stage` int DEFAULT '0',
  `next_review_at` date NOT NULL,
  `last_reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_vocab` (`vocab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of study_record
-- ----------------------------
BEGIN;
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (2, 2, 4, '2026-07-19', '2026-07-03 00:39:24', '2026-06-29 14:20:48');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (3, 3, 0, '2026-06-30', NULL, '2026-06-29 14:24:43');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (4, 4, 0, '2026-06-03', NULL, '2026-06-29 14:25:32');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (5, 41, 4, '2026-07-27', '2026-07-11 20:47:53', '2026-07-01 00:26:28');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (6, 49, 1, '2026-07-05', '2026-07-03 01:41:32', '2026-07-03 01:38:02');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (7, 24, 4, '2026-07-19', '2026-07-03 01:57:36', '2026-07-03 01:38:02');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (8, 52, 1, '2026-07-09', '2026-07-07 17:07:31', '2026-07-03 01:38:53');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (9, 15, 5, '2026-08-04', '2026-07-03 01:54:33', '2026-07-03 01:38:53');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (10, 19, 0, '2026-07-04', NULL, '2026-07-03 11:08:32');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (12, 73, 0, '2026-07-07', NULL, '2026-07-06 12:19:04');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (13, 43, 0, '2026-07-09', '2026-07-08 16:05:49', '2026-07-06 15:20:01');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (14, 12, 0, '2026-07-09', NULL, '2026-07-08 16:05:38');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (15, 74, 0, '2026-07-09', NULL, '2026-07-08 16:06:25');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (16, 75, 0, '2026-07-09', NULL, '2026-07-08 16:07:07');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (17, 76, 1, '2026-07-12', '2026-07-10 10:21:48', '2026-07-09 22:07:31');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (18, 77, 1, '2026-07-13', '2026-07-11 20:48:00', '2026-07-10 16:14:05');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (19, 78, 0, '2026-07-12', NULL, '2026-07-11 20:47:13');
INSERT INTO `study_record` (`id`, `vocab_id`, `review_stage`, `next_review_at`, `last_reviewed_at`, `created_at`) VALUES (20, 20, 0, '2026-07-12', NULL, '2026-07-11 20:48:20');
COMMIT;

-- ----------------------------
-- Table structure for vocabulary
-- ----------------------------
DROP TABLE IF EXISTS `vocabulary`;
CREATE TABLE `vocabulary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kana` varchar(100) NOT NULL COMMENT '假名',
  `kanji` varchar(100) DEFAULT NULL COMMENT '日汉字',
  `romaji` varchar(100) DEFAULT NULL COMMENT '罗马音',
  `meaning` varchar(255) NOT NULL COMMENT '中文意思',
  `english` varchar(255) DEFAULT NULL COMMENT '英文意思，可选',
  `example` varchar(500) DEFAULT NULL COMMENT '例句',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `important` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否重点词汇：0否，1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of vocabulary
-- ----------------------------
BEGIN;
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (2, 'おはよう', NULL, 'ohayou', '早上好', NULL, 'おはようございます。', '早晨问候', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (4, 'こんばんは', NULL, 'konbanwa', '晚上好', NULL, 'こんばんは。', '晚上问候', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (5, 'さようなら', NULL, 'sayounara', '再见', NULL, 'さようなら、また明日。', '正式告别', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (6, 'すみません', NULL, 'sumimasen', '不好意思；对不起', NULL, 'すみません、駅はどこですか。', '道歉或搭话', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (7, 'ごめんなさい', NULL, 'gomennasai', '对不起', NULL, 'ごめんなさい、遅れました。', '道歉', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (8, 'はい', NULL, 'hai', '是；好的', NULL, 'はい、わかりました。', '肯定回答', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (9, 'いいえ', NULL, 'iie', '不是；不', NULL, 'いいえ、違います。', '否定回答', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (10, 'お願いします', NULL, 'onegaishimasu', '拜托了；请', NULL, 'よろしくお願いします。', '请求表达', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (11, 'たべる', '食べる', 'taberu', '吃', 'eat', 'ご飯を食べる。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (12, 'のむ', '飲む', 'nomu', '喝', 'drink', '水を飲む。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (13, 'みる', '見る', 'miru', '看', 'see; watch', '映画を見る。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (14, 'きく', '聞く', 'kiku', '听；问', 'listen; ask', '音楽を聞く。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (15, 'はなす', '話す', 'hanasu', '说话', 'speak', '日本語を話す。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (16, 'いく', '行く', 'iku', '去', 'go', '学校へ行く。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (17, 'くる', '来る', 'kuru', '来', 'come', '友達が来る。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (18, 'かえる', '帰る', 'kaeru', '回去；回家', 'return', '家に帰る。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (19, 'かう', '買う', 'kau', '买', 'buy', '本を買う。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (20, 'よむ', '読む', 'yomu', '读', 'read', '本を読む。', '动词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (21, 'みず', '水', 'mizu', '水', 'water', '水をください。', '名词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (22, 'ごはん', 'ご飯', 'gohan', '米饭；饭', 'rice; meal', 'ご飯を食べます。', '名词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (23, 'にほん', '日本', 'nihon', '日本', 'Japan', '日本へ行きます。', '国家', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (24, 'にほんご', '日本語', 'nihongo', '日语', 'Japanese language', '日本語を勉強します。', '语言', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (25, 'がっこう', '学校', 'gakkou', '学校', 'school', '学校へ行きます。', '地点', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (26, 'せんせい', '先生', 'sensei', '老师', 'teacher', '先生に聞きます。', '人物', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (27, 'ともだち', '友達', 'tomodachi', '朋友', 'friend', '友達と話します。', '人物', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (28, 'いえ', '家', 'ie', '家；房子', 'house; home', '家に帰ります。', '地点', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (29, 'えき', '駅', 'eki', '车站', 'station', '駅はどこですか。', '地点', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (30, 'でんしゃ', '電車', 'densha', '电车', 'train', '電車に乗ります。', '交通', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (31, 'コーヒー', NULL, 'koohii', '咖啡', 'coffee', 'コーヒーを飲みます。', '片假名外来语', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (32, 'テレビ', NULL, 'terebi', '电视', 'television', 'テレビを見ます。', '片假名外来语', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (33, 'パン', NULL, 'pan', '面包', 'bread', 'パンを食べます。', '片假名外来语', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (34, 'コンビニ', NULL, 'konbini', '便利店', 'convenience store', 'コンビニへ行きます。', '片假名外来语', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (35, 'タクシー', NULL, 'takushii', '出租车', 'taxi', 'タクシーに乗ります。', '片假名外来语', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (36, 'あつい', '暑い', 'atsui', '热的；天气热', 'hot', '今日は暑いです。', '形容词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (37, 'さむい', '寒い', 'samui', '冷的；天气冷', 'cold', '今日は寒いです。', '形容词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (38, 'おいしい', NULL, 'oishii', '好吃的', 'delicious', 'この料理はおいしいです。', '形容词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (39, 'たのしい', '楽しい', 'tanoshii', '开心的；愉快的', 'fun', '旅行は楽しいです。', '形容词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (40, 'むずかしい', '難しい', 'muzukashii', '难的', 'difficult', '日本語は難しいです。', '形容词', '2026-06-27 18:52:51', '2026-06-27 18:52:51', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (41, 'ありがとう', '有難う', 'arigatou', '谢谢', 'thank you', 'ありがとうございます。', '日常常用', '2026-07-01 00:26:28', '2026-07-01 00:26:28', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (42, 'わたし', '私', 'watashi', '我', 'I', '私は学生です。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (43, 'あなた', NULL, 'anata', '你', 'you', 'あなたは先生ですか。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (44, 'せんせい', '先生', 'sensei', '老师', 'teacher', '先生は亲切です。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (45, 'がっこう', '学校', 'gakkou', '学校', 'school', '学校へ行きます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (46, 'ともだち', '友達', 'tomodachi', '朋友', 'friend', '友達と遊びます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (47, 'たべる', '食べる', 'taberu', '吃', 'eat', 'ご飯を食べます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (48, 'のむ', '飲む', 'nomu', '喝', 'drink', '水を飲みます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (49, 'みる', '見る', 'miru', '看', 'see/look', 'テレビを見ます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (50, 'きく', '聞く', 'kiku', '听', 'listen', '音楽を聞きます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (51, 'はなす', '話す', 'hanasu', '说话', 'speak', '日本語を話します。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (52, 'よむ', '読む', 'yomu', '读', 'read', '本を読みます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (53, 'かく', '書く', 'kaku', '写', 'write', '手紙を書きます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (54, 'あるく', '歩く', 'aruku', '走路', 'walk', '駅まで歩きます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (55, 'はしる', '走る', 'hashiru', '跑', 'run', '公園を走ります。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (56, 'おおきい', '大きい', 'ookii', '大的', 'big', '大きい犬です。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (57, 'ちいさい', '小さい', 'chiisai', '小的', 'small', '小さい猫です。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (58, 'あつい', '暑い', 'atsui', '热', 'hot', '今日は暑いです。', '天气热', '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (59, 'さむい', '寒い', 'samui', '冷', 'cold', '冬は寒いです。', '天气冷', '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (60, 'たかい', '高い', 'takai', '高的/贵的', 'high/expensive', 'この本は高いです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 4);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (61, 'やすい', '安い', 'yasui', '便宜的', 'cheap', 'この店は安いです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (62, 'うつくしい', '美しい', 'utsukushii', '美丽的', 'beautiful', '花が美しいです。', '注意う的发音', '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (63, 'おもしろい', '面白い', 'omoshiroi', '有趣的', 'interesting', '映画は面白いです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (64, 'いそがしい', '忙しい', 'isogashii', '忙碌的', 'busy', '毎日忙しいです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (65, 'たのしい', '楽しい', 'tanoshii', '快乐的', 'enjoyable', '旅行は楽しいです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (66, 'くだもの', '果物', 'kudamono', '水果', 'fruit', '果物が好きです。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (67, 'やさい', '野菜', 'yasai', '蔬菜', 'vegetable', '野菜を食べます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (68, 'でんわ', '電話', 'denwa', '电话', 'telephone', '電話をかけます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (69, 'くすり', '薬', 'kusuri', '药', 'medicine', '薬を飲みます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (70, 'びょういん', '病院', 'byouin', '医院', 'hospital', '病院へ行きます。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 1);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (71, 'えき', '駅', 'eki', '车站', 'station', '駅はどこですか。', NULL, '2026-07-03 01:29:41', '2026-07-03 01:29:41', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (74, 'きょうはやすみ', '', 'kyouhayasumi', '我今天休息', 'I have a day off today', '', '', '2026-07-08 16:06:26', '2026-07-08 16:06:26', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (75, 'こんにちは', '', 'konnichiha', '你好', 'Hello', '', '', '2026-07-08 16:07:08', '2026-07-08 16:07:08', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (76, 'くうこう', '空港', 'kuukou', '飞机场', 'airport', '', '', '2026-07-09 22:07:32', '2026-07-09 22:07:32', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (77, 'スマホ', '', 'sumaho', '手机', 'smartphone', '', '', '2026-07-10 16:14:05', '2026-07-10 16:14:05', 0);
INSERT INTO `vocabulary` (`id`, `kana`, `kanji`, `romaji`, `meaning`, `english`, `example`, `note`, `created_at`, `updated_at`, `important`) VALUES (78, '食べる', '', 'beru', '吃饭', 'to eat', '', '', '2026-07-11 20:47:13', '2026-07-11 20:47:13', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
