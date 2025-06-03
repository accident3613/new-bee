/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : dao

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 03/06/2025 15:33:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_id` bigint NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `type` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_message
-- ----------------------------
INSERT INTO `chat_message` VALUES (1, 104, '2', '123456', '1234', '2025-06-03 14:46:17', 1);
INSERT INTO `chat_message` VALUES (2, 104, '5', 'eisa', '2345', '2025-06-03 14:46:21', 1);
INSERT INTO `chat_message` VALUES (3, 104, '2', '123456', '如2', '2025-06-03 15:08:55', 1);
INSERT INTO `chat_message` VALUES (4, 104, '2', '123456', '213213', '2025-06-03 15:13:16', 1);
INSERT INTO `chat_message` VALUES (5, 104, '2', '123456', '畏惧神是正常的', '2025-06-03 15:14:58', 1);
INSERT INTO `chat_message` VALUES (6, 104, '2', '123456', '个人', '2025-06-03 15:15:05', 1);

-- ----------------------------
-- Table structure for friend_requests
-- ----------------------------
DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `requester_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发起好友请求的用户ID',
  `addressee_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收好友请求的用户ID',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending' COMMENT '请求状态: pending(待处理), accepted(已接受), rejected(已拒绝)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '请求创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '请求状态更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `requester_id`(`requester_id` ASC, `addressee_id` ASC) USING BTREE,
  INDEX `addressee_id`(`addressee_id` ASC) USING BTREE,
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`addressee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend_requests
-- ----------------------------
INSERT INTO `friend_requests` VALUES (2, '2', '5', 'accepted', '2025-06-02 18:01:24', '2025-06-02 19:36:33');

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id1` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id2` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_friendship`(`user_id1` ASC, `user_id2` ASC) USING BTREE,
  INDEX `user_id2`(`user_id2` ASC) USING BTREE,
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`user_id1`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`user_id2`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friends
-- ----------------------------
INSERT INTO `friends` VALUES (1, '2', '3', '2025-06-02 18:00:34');
INSERT INTO `friends` VALUES (2, '2', '5', '2025-06-02 19:36:33');
INSERT INTO `friends` VALUES (3, '5', '2', '2025-06-02 19:36:33');

-- ----------------------------
-- Table structure for games
-- ----------------------------
DROP TABLE IF EXISTS `games`;
CREATE TABLE `games`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `room_id` bigint UNSIGNED NOT NULL,
  `black_player_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `white_player_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `current_player` enum('black','white') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `winner` enum('black','white','draw') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `board_state` json NULL,
  `game_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_black_player`(`black_player_id` ASC) USING BTREE,
  INDEX `idx_white_player`(`white_player_id` ASC) USING BTREE,
  CONSTRAINT `fk_games_black_player` FOREIGN KEY (`black_player_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_games_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_games_white_player` FOREIGN KEY (`white_player_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of games
-- ----------------------------
INSERT INTO `games` VALUES ('555e5eaf-571b-434b-8e72-5398c489a37e', 101, '2', '2', 'black', NULL, '[[\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"white\", \"black\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"black\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"white\", \"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"]]', NULL, '2025-06-02 15:06:29', '2025-06-02 15:06:34');
INSERT INTO `games` VALUES ('67afd196-3866-408f-882f-a6e4ff99f747', 100, '2', '5', 'black', NULL, '[[\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"white\", \"white\", \"white\", \"\", \"black\", \"white\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"]]', NULL, '2025-05-31 19:51:15', '2025-06-02 19:37:53');
INSERT INTO `games` VALUES ('67bd623a-852a-45d3-a429-648df97ebb66', 104, '2', '5', 'black', NULL, '[[\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"white\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"white\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"black\", \"\", \"white\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"white\", \"\", \"white\", \"\", \"black\", \"\", \"black\", \"black\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"white\", \"\", \"black\", \"\", \"white\", \"white\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"black\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"], [\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"]]', NULL, '2025-06-03 13:44:19', '2025-06-03 15:21:16');

-- ----------------------------
-- Table structure for room_players
-- ----------------------------
DROP TABLE IF EXISTS `room_players`;
CREATE TABLE `room_players`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `room_id` bigint UNSIGNED NOT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('player','spectator') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'player',
  `status` enum('ready','not_ready') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'not_ready',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_room_user`(`room_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_room_players_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_room_players_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 745 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room_players
-- ----------------------------
INSERT INTO `room_players` VALUES (738, 104, '2', 'player', 'ready', '2025-06-03 15:20:13', '2025-06-03 15:20:13');
INSERT INTO `room_players` VALUES (743, 104, '3', 'spectator', 'ready', '2025-06-03 15:21:01', '2025-06-03 15:21:01');
INSERT INTO `room_players` VALUES (744, 104, '5', 'player', 'ready', '2025-06-03 15:21:11', '2025-06-03 15:21:11');

-- ----------------------------
-- Table structure for rooms
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creator_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mode` enum('online','local','ai') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ai_difficulty` enum('easy','medium','hard') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_creator`(`creator_id` ASC) USING BTREE,
  INDEX `idx_mode`(`mode` ASC) USING BTREE,
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rooms
-- ----------------------------
INSERT INTO `rooms` VALUES (100, '12', '2', 'online', NULL, '2025-05-31 19:51:15', '2025-05-31 19:51:15', 0);
INSERT INTO `rooms` VALUES (101, '999', '2', 'local', NULL, '2025-06-02 15:06:29', '2025-06-02 15:06:29', 0);
INSERT INTO `rooms` VALUES (104, '999', '2', 'online', NULL, '2025-06-03 13:44:19', '2025-06-03 13:44:19', 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_games` int NULL DEFAULT 0,
  `wins` int NULL DEFAULT 0,
  `draws` int NULL DEFAULT 0,
  `losses` int NULL DEFAULT 0,
  `win_rate` decimal(5, 2) NULL DEFAULT 0.00,
  `online` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('2', '123456', '123456', 'http://localhost:8009/upload/99db6344-1b9d-4125-961e-fb7ad45447c0.jpg', '2025-05-14 02:49:51', '2025-06-03 15:21:33', 1357, 9991, 3, 5, 67.98, 0);
INSERT INTO `users` VALUES ('3', '庄子休', '123456', 'http://localhost:8009/upload/851eadfd-d8db-4fbd-8bf3-98e7eaba57e1.jpg', '2025-05-31 19:42:25', '2025-06-03 15:21:32', 0, 0, 0, 0, 0.00, 0);
INSERT INTO `users` VALUES ('5', 'eisa', '123456', 'http://localhost:8009/upload/afa1f7bf-bd5a-4781-a90b-17358f36d565.jpg', '2025-05-11 21:29:23', '2025-06-03 15:21:32', 952, 998, 1, 1, 54.21, 0);

-- ----------------------------
-- View structure for view_1
-- ----------------------------
DROP VIEW IF EXISTS `view_1`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_1` AS select `room_players`.`room_id` AS `room_id`,count(`room_players`.`user_id`) AS `count(user_id)` from `room_players` group by `room_players`.`room_id`;

SET FOREIGN_KEY_CHECKS = 1;
