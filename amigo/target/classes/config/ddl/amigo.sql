-- amigo.chat_room definition

CREATE TABLE `chat_room` (
  `chat_index` int(5) NOT NULL,
  `user_no` int(10) NOT NULL,
  `res_no` int(10) NOT NULL,
  PRIMARY KEY (`chat_index`,`user_no`),
  KEY `chat_index` (`chat_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.notice definition

CREATE TABLE `notice` (
  `not_no` int(10) NOT NULL,
  `not_cont` varchar(10000) NOT NULL,
  `not_subj` varchar(300) NOT NULL,
  `not_date` date NOT NULL,
  PRIMARY KEY (`not_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.res_content definition

CREATE TABLE `res_content` (
  `res_no` int(10) NOT NULL,
  `res_date` date NOT NULL,
  `res_time` varchar(30) NOT NULL,
  `dog_no` int(10) DEFAULT NULL,
  `res_addr` varchar(200) NOT NULL,
  `res_ser_cont` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.sit_price definition

CREATE TABLE `sit_price` (
  `sit_ser_no` int(10) NOT NULL AUTO_INCREMENT,
  `sit_service` varchar(20) NOT NULL,
  `sit_price` int(10) NOT NULL,
  `sit_time` int(10) NOT NULL,
  PRIMARY KEY (`sit_ser_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.user_type definition

CREATE TABLE `user_type` (
  `user_type` varchar(10) NOT NULL,
  `user_desc` varchar(10) NOT NULL,
  PRIMARY KEY (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.`user` definition

CREATE TABLE `user` (
  `user_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(10) NOT NULL,
  `user_email` varchar(60) NOT NULL,
  `user_pw` varchar(40) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_nick` varchar(30) NOT NULL,
  `user_addr` varchar(160) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `user_photo` varchar(100) DEFAULT NULL,
  `user_terms` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_no`),
  UNIQUE KEY `user_user_email_uk` (`user_email`),
  UNIQUE KEY `user_nick_uk` (`user_nick`),
  KEY `user_type` (`user_type`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type`) REFERENCES `user_type` (`user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.user_board definition

CREATE TABLE `user_board` (
  `ubd_no` int(10) NOT NULL AUTO_INCREMENT,
  `ubd_title` varchar(200) NOT NULL,
  `ubd_date` date NOT NULL,
  `ubd_file` varchar(500) DEFAULT NULL,
  `ubd_cont` varchar(10000) NOT NULL,
  `ubd_cnt` int(10) NOT NULL DEFAULT 0,
  `ubd_cate` varchar(40) NOT NULL,
  `user_no` int(10) NOT NULL,
  `dog_kind` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ubd_no`),
  KEY `user_board_ibfk_1` (`user_no`),
  CONSTRAINT `user_board_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.walk_review definition

CREATE TABLE `walk_review` (
  `walk_review_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_no` int(10) NOT NULL COMMENT '유저번호',
  `route_no` int(10) NOT NULL COMMENT '산책로번호',
  `walk_star` int(10) NOT NULL COMMENT '별점',
  `walk_cont` varchar(1000) NOT NULL COMMENT '리뷰내용',
  PRIMARY KEY (`walk_review_no`) USING BTREE,
  KEY `walk_review_ibfk_1` (`user_no`) USING BTREE,
  CONSTRAINT `walk_review_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.admin definition

CREATE TABLE `admin` (
  `ad_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_no` int(10) NOT NULL,
  `ad_auth` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ad_no`),
  KEY `user_no` (`user_no`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.dog definition

CREATE TABLE `dog` (
  `dog_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_no` int(10) NOT NULL,
  `dog_name` varchar(100) NOT NULL COMMENT '이름',
  `dog_gender` varchar(5) NOT NULL COMMENT '성별 (f,m)',
  `dog_breeds` varchar(30) NOT NULL COMMENT '품종',
  `dog_birth` date DEFAULT NULL COMMENT '생년월일',
  `dog_weight` double(4,2) NOT NULL COMMENT '몸무게',
  `dog_neutered` tinyint(1) NOT NULL COMMENT '중성화',
  `dog_rabies_vacc` tinyint(1) NOT NULL COMMENT '백신날짜',
  `dog_image_file` varchar(500) DEFAULT NULL COMMENT '사진경로',
  `dog_notice` varchar(1000) NOT NULL COMMENT '기타사항',
  `dog_terms` tinyint(1) NOT NULL COMMENT '약관동의',
  PRIMARY KEY (`dog_no`),
  KEY `dog_ibfk_1` (`user_no`),
  CONSTRAINT `dog_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.heart definition

CREATE TABLE `heart` (
  `heart_no` int(11) NOT NULL AUTO_INCREMENT,
  `user_no` int(11) NOT NULL,
  `ubd_no` int(11) NOT NULL,
  `heart_check` int(11) DEFAULT 0,
  PRIMARY KEY (`heart_no`) USING BTREE,
  KEY `heart_ibfk_1` (`user_no`),
  KEY `heart_ibfk_2` (`ubd_no`),
  CONSTRAINT `heart_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE,
  CONSTRAINT `heart_ibfk_2` FOREIGN KEY (`ubd_no`) REFERENCES `user_board` (`ubd_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=656 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.help_board definition

CREATE TABLE `help_board` (
  `hbd_no` int(10) NOT NULL AUTO_INCREMENT COMMENT '글번호',
  `hbd_title` varchar(200) NOT NULL COMMENT '제목',
  `hbd_date` date NOT NULL COMMENT '글내용',
  `hbd_cont` varchar(10000) NOT NULL COMMENT '조회수',
  `hbd_cnt` int(10) NOT NULL DEFAULT 0 COMMENT '작성일자',
  `hbd_file` varchar(500) DEFAULT NULL COMMENT '파일경로',
  `user_no` int(10) NOT NULL,
  PRIMARY KEY (`hbd_no`),
  KEY `user_no` (`user_no`),
  CONSTRAINT `help_board_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.petsitter definition

CREATE TABLE `petsitter` (
  `sit_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_no` int(10) NOT NULL,
  `sit_gender` varchar(6) NOT NULL,
  `sit_birth` date NOT NULL,
  `sit_smoking` tinyint(1) NOT NULL COMMENT '흡연여부',
  `sit_job` varchar(20) NOT NULL COMMENT '현재직종',
  `sit_days` varchar(60) NOT NULL,
  `sit_time` varchar(60) NOT NULL COMMENT '활동가능일수',
  `sit_exp` tinyint(1) NOT NULL COMMENT '반려경험',
  `sit_care_exp` varchar(1000) DEFAULT NULL,
  `sit_intro` varchar(1000) NOT NULL,
  `sit_photo` varchar(250) NOT NULL,
  `sit_auth_is` tinyint(1) NOT NULL,
  PRIMARY KEY (`sit_no`),
  KEY `petsitter_ibfk_1` (`user_no`),
  CONSTRAINT `petsitter_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.reservation definition

CREATE TABLE `reservation` (
  `res_no` int(10) NOT NULL AUTO_INCREMENT,
  `user_no` int(10) NOT NULL,
  `sit_no` int(10) NOT NULL,
  `res_regdate` date NOT NULL,
  `res_is` tinyint(1) DEFAULT NULL,
  `res_etc` varchar(300) DEFAULT NULL,
  `res_pay` varchar(30) NOT NULL,
  `res_visit_is` tinyint(1) NOT NULL,
  `res_term_is` tinyint(1) NOT NULL,
  PRIMARY KEY (`res_no`),
  KEY `user_no` (`user_no`),
  KEY `sit_no` (`sit_no`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`sit_no`) REFERENCES `petsitter` (`sit_no`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.sit_board definition

CREATE TABLE `sit_board` (
  `sbd_no` int(10) NOT NULL AUTO_INCREMENT,
  `sbd_title` varchar(200) NOT NULL,
  `sbd_date` date NOT NULL,
  `sbd_cont` varchar(10000) NOT NULL,
  `sbd_cnt` int(10) NOT NULL DEFAULT 0,
  `user_no` int(10) NOT NULL,
  PRIMARY KEY (`sbd_no`),
  KEY `sit_board_ibfk_1` (`user_no`),
  CONSTRAINT `sit_board_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.sit_chat definition

CREATE TABLE `sit_chat` (
  `sitt_chat_index` int(5) NOT NULL,
  `user_no` int(10) NOT NULL,
  `sitt_chat_content` varchar(1000) NOT NULL,
  `sitt_chat_regdate` datetime NOT NULL,
  `sitt_chat_readis` tinyint(1) NOT NULL,
  `sitt_chat_file` varchar(300) DEFAULT NULL,
  `sitt_chat_emo` varchar(300) DEFAULT NULL,
  `sitt_chat_no` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sitt_chat_no`),
  KEY `sit_chat_ibfk_1` (`user_no`),
  CONSTRAINT `sit_chat_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=945 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.sit_review definition

CREATE TABLE `sit_review` (
  `rev_no` int(10) NOT NULL AUTO_INCREMENT,
  `sit_no` int(10) NOT NULL,
  `user_no` int(10) NOT NULL,
  `star_cnt` int(10) NOT NULL DEFAULT 1,
  `rev_content` varchar(400) NOT NULL,
  `rev_date` date DEFAULT current_timestamp(),
  PRIMARY KEY (`rev_no`),
  KEY `sit_no` (`sit_no`),
  KEY `user_no` (`user_no`),
  CONSTRAINT `sit_review_ibfk_1` FOREIGN KEY (`sit_no`) REFERENCES `petsitter` (`sit_no`),
  CONSTRAINT `sit_review_ibfk_2` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.ubd_reply definition

CREATE TABLE `ubd_reply` (
  `ubd_r_no` int(10) NOT NULL AUTO_INCREMENT,
  `ubd_no` int(10) NOT NULL,
  `ubd_r_content` varchar(400) NOT NULL COMMENT '댓글내용',
  `ubd_r_regdate` date NOT NULL DEFAULT current_timestamp() COMMENT '댓글등록일자',
  `ubd_r_ref` int(10) DEFAULT 0 COMMENT '참조댓글',
  `ubd_r_lev` int(10) DEFAULT 0 COMMENT '댓글단계',
  `ubd_r_seq` int(10) DEFAULT 0 COMMENT '댓글순서',
  `user_no` int(10) NOT NULL COMMENT '유저게시판댓글',
  PRIMARY KEY (`ubd_r_no`,`ubd_no`) USING BTREE,
  KEY `ubd_reply_ibfk_1` (`ubd_no`),
  KEY `ubd_reply_ibfk_2` (`user_no`),
  CONSTRAINT `ubd_reply_ibfk_1` FOREIGN KEY (`ubd_no`) REFERENCES `user_board` (`ubd_no`) ON DELETE CASCADE,
  CONSTRAINT `ubd_reply_ibfk_2` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.hbd_reply definition

CREATE TABLE `hbd_reply` (
  `hbd_r_no` int(10) NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
  `hbd_no` int(10) NOT NULL COMMENT '글번호',
  `hbd_r_cont` varchar(400) NOT NULL COMMENT '댓글내용',
  `hbd_r_regdate` date NOT NULL COMMENT '댓글등록일자',
  `hbd_r_ref` int(10) DEFAULT NULL COMMENT '참조댓글',
  `hbd_r_lev` int(10) DEFAULT NULL COMMENT '댓글단계',
  `hbd_r_seq` int(10) DEFAULT NULL COMMENT '댓글순서',
  `user_no` int(10) NOT NULL,
  PRIMARY KEY (`hbd_r_no`),
  KEY `hbd_reply_ibfk_1` (`hbd_no`),
  KEY `hbd_reply_ibfk_2` (`user_no`),
  CONSTRAINT `hbd_reply_ibfk_1` FOREIGN KEY (`hbd_no`) REFERENCES `help_board` (`hbd_no`) ON DELETE CASCADE,
  CONSTRAINT `hbd_reply_ibfk_2` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.payment definition

CREATE TABLE `payment` (
  `imp_uid` varchar(30) NOT NULL,
  `merchant_uid` varchar(30) NOT NULL,
  `pay` int(255) NOT NULL,
  `user_no` int(11) NOT NULL,
  `res_no` int(255) DEFAULT NULL,
  PRIMARY KEY (`imp_uid`),
  KEY `res_no_fk` (`res_no`),
  KEY `user_no_fk` (`user_no`),
  CONSTRAINT `res_no_fk` FOREIGN KEY (`res_no`) REFERENCES `reservation` (`res_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_no_fk` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- amigo.sbd_reply definition

CREATE TABLE `sbd_reply` (
  `sbd_r_no` int(10) NOT NULL AUTO_INCREMENT,
  `sbd_no` int(10) NOT NULL,
  `sbd_r_cont` varchar(400) NOT NULL,
  `sbd_r_regdate` date NOT NULL,
  `sbd_r_ref` int(10) DEFAULT 0,
  `sbd_r_lev` int(10) DEFAULT 0,
  `sbd_r_seq` int(10) DEFAULT 0,
  `user_no` int(10) NOT NULL,
  PRIMARY KEY (`sbd_r_no`),
  KEY `sbd_reply_ibfk_1` (`user_no`),
  KEY `sbd_reply_ibfk_2` (`sbd_no`),
  CONSTRAINT `sbd_reply_ibfk_1` FOREIGN KEY (`user_no`) REFERENCES `user` (`user_no`) ON DELETE CASCADE,
  CONSTRAINT `sbd_reply_ibfk_2` FOREIGN KEY (`sbd_no`) REFERENCES `sit_board` (`sbd_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;