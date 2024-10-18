CREATE TABLE `oj_checkpoint` (
  `c_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键, 检查点id, 由雪花算法生成',
  `c_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `c_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `c_features` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '特性字段',
  `c_input_preview` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '输入文件概况, 64 字节',
  `c_output_preview` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '输出文件概况, 64 字节',
  `c_input_size` int unsigned NOT NULL COMMENT '输入文件大小, 单位: B',
  `c_output_size` int unsigned NOT NULL COMMENT '输出文件大小, 单位: B',
  `c_input_file_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_output_file_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_input_file_id` bigint unsigned NOT NULL COMMENT '输入文件的文件系统id',
  `c_output_file_id` bigint unsigned NOT NULL COMMENT '输出文件的文件系统id',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='检查点表';

CREATE TABLE `oj_contest` (
  `ct_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ct_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ct_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `ct_features` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `ct_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `ct_is_public` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '比赛公开, 0否, 1是',
  `ct_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `ct_title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '比赛标题',
  `u_id` bigint unsigned NOT NULL COMMENT '创建者id',
  `ct_gmt_start` datetime NOT NULL COMMENT '比赛开始时间',
  `ct_gmt_end` datetime NOT NULL COMMENT '比赛结束时间',
  `ct_password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参加密码',
  `ct_source` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '比赛来源',
  `ct_participant_num` mediumint unsigned NOT NULL DEFAULT '0' COMMENT '参加人数',
  `ct_markdown_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '比赛描述',
  `ct_problems` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '比赛题目设置, 包含(p_id,pd_id,title,score)',
  `ct_participants` blob COMMENT '参加者id集合',
  `ct_unofficial_participants` blob COMMENT '挂星参加者id集合，是参加者的子集',
  `g_id` bigint unsigned DEFAULT NULL COMMENT '权限用户组id',
  `ct_clarification_template` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='比赛表';

CREATE TABLE `oj_contest_extension` (
  `ce_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ce_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ce_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `ce_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `ce_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `ct_id` bigint unsigned NOT NULL COMMENT '比赛id',
  `ce_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ce_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ce_id`),
  KEY `idx_ct_id_key` (`ct_id`,`ce_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='比赛拓展表';

CREATE TABLE `oj_file` (
  `f_id` bigint unsigned NOT NULL COMMENT '主键',
  `f_gmt_create` datetime(3) DEFAULT NULL,
  `f_gmt_modified` datetime(3) DEFAULT NULL,
  `f_features` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `f_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `u_id` bigint unsigned NOT NULL COMMENT '用户id',
  `f_size` bigint unsigned NOT NULL COMMENT '文件大小, 单位: B',
  `f_is_public` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '是否公开',
  `f_md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件md5',
  `f_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `f_extension_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件拓展名',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oj_group` (
  `g_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `g_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `g_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `g_features` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `g_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `g_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `u_id` bigint unsigned NOT NULL COMMENT '创建人',
  `g_openness` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '开放性 0.可进入, 1.需申请, 2.不可进入',
  `g_title` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `g_member_num` int unsigned NOT NULL DEFAULT '1' COMMENT '成员数量',
  `g_description` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `g_markdown` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '说明',
  PRIMARY KEY (`g_id`),
  KEY `idx_title` (`g_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户组表';

CREATE TABLE `oj_group_contest` (
  `gc_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gc_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gc_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `gc_features` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `gc_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `g_id` bigint unsigned NOT NULL COMMENT '用户组id',
  `ct_id` bigint unsigned NOT NULL COMMENT '比赛id',
  PRIMARY KEY (`gc_id`),
  KEY `idx_group` (`g_id`) USING BTREE,
  KEY `idx_contest` (`ct_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户组-比赛参赛关联表';

CREATE TABLE `oj_group_user` (
  `gu_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gu_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gu_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `gu_features` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `gu_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `g_id` bigint unsigned NOT NULL COMMENT '用户组id',
  `u_id` bigint unsigned NOT NULL COMMENT '用户id',
  `gu_status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '状态 0.没申请 1.待通过 2.已通过 3.已拒绝',
  PRIMARY KEY (`gu_id`),
  KEY `idx_user` (`u_id`) USING BTREE,
  KEY `idx_group` (`g_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户组-用户关联表';

CREATE TABLE `oj_judge_template` (
  `jt_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `jt_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `jt_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `jt_features` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `jt_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `jt_is_public` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '是否公开, 0.否, 1.是',
  `u_id` bigint unsigned NOT NULL COMMENT '添加者id',
  `f_id` bigint unsigned DEFAULT NULL COMMENT '评测模板支撑素材zip包id',
  `p_id` bigint unsigned DEFAULT NULL COMMENT '题目id, 一般用于进阶评测的jt和题目挂钩',
  `jt_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `jt_type` tinyint unsigned NOT NULL COMMENT '评测模板类型',
  `jt_title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题, 对外呈现',
  `jt_shell_script` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评测模板',
  `jt_accept_file_extensions` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评测模板可接受的文件后缀名',
  `jt_remote_oj` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '远程oj',
  `jt_remote_parameters` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '远程oj提交参数',
  `jt_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模板注释',
  PRIMARY KEY (`jt_id`),
  KEY `idx_title` (`jt_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oj_notice` (
  `n_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `n_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `n_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `n_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `n_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `n_title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `n_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '评论',
  `u_id` bigint unsigned NOT NULL COMMENT '作者',
  `n_top` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶, 0.否, 1.是',
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `oj_problem` (
  `p_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `p_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `p_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `p_features` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `p_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `p_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `p_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '题目编码',
  `p_is_public` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '题目公开在题库, 0否, 1是',
  `u_id` bigint unsigned NOT NULL COMMENT '题目添加者id',
  `p_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目名称',
  `p_source` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '题目来源描述',
  `p_remote_oj` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'vj名, 空串则为本地题目',
  `p_remote_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'vj题目链接',
  `p_submit_num` int unsigned NOT NULL DEFAULT '0' COMMENT '题目提交数',
  `p_accept_num` int unsigned NOT NULL DEFAULT '0' COMMENT '题目通过数',
  `p_memory_limit` int unsigned NOT NULL DEFAULT '256' COMMENT '内存限制, 单位KB',
  `p_output_limit` int NOT NULL DEFAULT '102400' COMMENT '输出大小限制, 单位KB',
  `p_time_limit` int unsigned NOT NULL DEFAULT '1000' COMMENT '时间限制, 单位ms',
  `p_default_pd_id` bigint unsigned DEFAULT NULL COMMENT '默认题目描述id',
  `p_checkpoint_num` int unsigned NOT NULL DEFAULT '0',
  `p_judge_templates` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '评测模板id集',
  `p_checkpoints` blob COMMENT '测试点id集, 二进制, (checkpointId, checkpointScore)',
  `p_checkpoint_cases` blob COMMENT '检查点样例 (checkpointId)',
  `p_manager_groups` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限用户组ids',
  `p_checker_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '检查器配置, 如 {"source":"lcmp.cpp", "spj":null}',
  `p_function_templates` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '函数模板',
  PRIMARY KEY (`p_id`),
  UNIQUE KEY `uk_problem_code` (`p_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目表';

CREATE TABLE `oj_problem_checkpoint_rel` (
  `pcr_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pcr_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pcr_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `p_id` bigint unsigned NOT NULL COMMENT 'id',
  `pcr_type` tinyint unsigned NOT NULL COMMENT ' 0. 1. 2. 02',
  `c_id` bigint unsigned NOT NULL COMMENT 'id',
  `pcr_sort_order` smallint NOT NULL DEFAULT '-1' COMMENT ' -1',
  `pcr_score` smallint unsigned NOT NULL DEFAULT '0',
  `u_id` bigint unsigned DEFAULT NULL COMMENT 'id',
  `pcr_status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT ' 0. 1. 2.',
  `pcr_note` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`pcr_id`),
  UNIQUE KEY `uk_problem_type_checkpoint` (`p_id`,`pcr_type`,`c_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='-';

CREATE TABLE `oj_problem_description` (
  `pd_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pd_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pd_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `pd_features` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `pd_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `pd_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `pd_is_public` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '公开, 0否, 1是',
  `p_id` bigint unsigned NOT NULL COMMENT '题目id',
  `u_id` bigint unsigned NOT NULL COMMENT '创建者id',
  `pd_vote_num` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `pd_title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `pd_markdown_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'markdown描述',
  `pd_html_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'html描述',
  `pd_html_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '输入',
  `pd_html_output` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '输出',
  `pd_html_sample_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '样例输入',
  `pd_html_sample_outout` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '样例输出',
  `pd_html_hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '提示',
  PRIMARY KEY (`pd_id`),
  KEY `idx_p_id` (`p_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目描述表';

CREATE TABLE `oj_problem_extension` (
  `pe_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pe_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pe_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `pe_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `pe_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `p_id` bigint unsigned NOT NULL COMMENT '题目id',
  `pe_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pe_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pe_id`),
  UNIQUE KEY `uk_p_id_key` (`p_id`,`pe_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='比赛拓展表';

CREATE TABLE `oj_submission` (
  `s_id` bigint unsigned NOT NULL COMMENT '主键, 分布式id',
  `s_gmt_create` datetime(3) DEFAULT NULL,
  `s_gmt_modified` datetime(3) DEFAULT NULL,
  `s_features` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段',
  `s_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `s_is_public` tinyint NOT NULL DEFAULT '0' COMMENT '是否公开, 0不公开, 1公开',
  `s_valid` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '有效提交, 0无效, 1有效',
  `biz_type` mediumint unsigned NOT NULL DEFAULT '0' COMMENT ' 0. 1. 2. 3.',
  `biz_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `p_id` bigint unsigned NOT NULL COMMENT '题目id',
  `u_id` bigint unsigned NOT NULL COMMENT '提交者id',
  `jt_id` bigint unsigned NOT NULL COMMENT '评测模板id',
  `f_id` bigint unsigned DEFAULT NULL COMMENT 'zipFile主键',
  `s_ipv4` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '提交端ipv4',
  `s_judger_id` bigint DEFAULT NULL COMMENT '评测机id, 外键于u_id',
  `s_judge_result` tinyint NOT NULL DEFAULT '0' COMMENT '评测结果, 0-Pending',
  `s_judge_score` int unsigned NOT NULL DEFAULT '0' COMMENT '评测分数',
  `s_used_time` int unsigned DEFAULT NULL COMMENT '使用时间, 单位ms',
  `s_used_memory` int unsigned DEFAULT NULL COMMENT '使用内存, 单位KB',
  `s_code_length` int unsigned NOT NULL COMMENT '代码长度/字符数, 单位B',
  `s_judge_log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '评测结果文案, 展示到前台',
  `s_code` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '提交代码',
  `s_checkpoint_num` smallint unsigned DEFAULT '0' COMMENT ', ',
  `s_public_checkpoint_num` smallint unsigned DEFAULT '0' COMMENT ', ',
  `s_checkpoint_results` blob COMMENT ',  , (long checkpointId, int judge_result, int judge_score, int judge_time, int judge_memory)',
  `s_public_checkpoint_results` blob COMMENT ', , (long checkpointId, int judge_result, int judge_score, int judge_time, int judge_memory)',
  PRIMARY KEY (`s_id`),
  KEY `idx_problem` (`p_id`) USING BTREE,
  KEY `idx_user` (`u_id`) USING BTREE,
  KEY `idx_biz_type_biz_id_user_problem` (`biz_type`,`biz_id`,`u_id`,`p_id`) USING BTREE,
  KEY `idx_biz_type_biz_id_problem_user` (`biz_type`,`biz_id`,`p_id`,`u_id`) USING BTREE,
  KEY `idx_judge_result` (`s_judge_result`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题库提交表';

CREATE TABLE `oj_submission_extension` (
  `se_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `se_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `se_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `s_id` bigint unsigned NOT NULL COMMENT '提交id',
  `se_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `se_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`se_id`),
  UNIQUE KEY `uk_s_id_key` (`s_id`,`se_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提交拓展表';

CREATE TABLE `oj_user` (
  `u_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `u_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `u_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `u_features` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '特性字段, 用于用户打标, 拓展属性如过题记录请使用ext表',
  `u_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `u_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `u_username` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号, 英文、数字、下划线组成',
  `u_nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `u_salt` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码加盐',
  `u_password` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `u_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户邮箱',
  `u_is_email_verified` tinyint NOT NULL DEFAULT '1' COMMENT '邮箱已验证字段, 弃用待删除',
  `u_phone` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `u_gender` tinyint NOT NULL DEFAULT '2' COMMENT '用户性别, 0.女, 1.男, 2.问号',
  `u_student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '学生学号',
  `u_sdu_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方认证字段, SDUCAS',
  `u_roles` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户角色，'','' 号分割',
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `uk_username` (`u_username`) USING BTREE,
  UNIQUE KEY `uk_email` (`u_email`) USING BTREE,
  UNIQUE KEY `uk_sdu_id` (`u_sdu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

CREATE TABLE `oj_user_extension` (
  `ue_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ue_gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ue_gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `ue_version` int unsigned NOT NULL DEFAULT '0' COMMENT '乐观锁字段',
  `ue_is_deleted` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除, 0.否, 1.是',
  `u_id` bigint unsigned NOT NULL COMMENT '用户id',
  `ue_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ue_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ue_id`),
  UNIQUE KEY `uk_u_id_key` (`u_id`,`ue_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户拓展表';

CREATE TABLE `oj_user_session` (
  `us_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `us_gmt_create` datetime(3) DEFAULT NULL,
  `us_gmt_modified` datetime(3) DEFAULT NULL,
  `us_features` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '特性字段, 用于用户打标, 拓展属性如过题记录请使用ext表',
  `u_username` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `us_ipv4` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登陆端ipv4',
  `us_user_agent` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `us_is_success` tinyint unsigned NOT NULL COMMENT '是否登陆成功, 0.不成功, 1.成功',
  PRIMARY KEY (`us_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户会话表';
