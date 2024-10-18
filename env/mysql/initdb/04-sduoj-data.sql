-- ----------------------------
-- Records of oj_user
-- Default: 
--    Username    Password
--    superadmin  123456
--    superta     123456
-- ----------------------------
INSERT INTO `oj_user` VALUES ('1', '2024-01-01 00:00:00', '2024-01-01 00:00:00', '{\"banThirdParty\":0,\"banEmailUpdate\":0,\"banInfoUpdate\":0,\"requirePasswordChange\":0}', '0', '0', 'superadmin', 'superadmin', 'salt_', '9466981e0b3301a1f0598d9adddc8b5a', 'oslab-oj@oslab.net', '1', '12345678910', '1', 'superadmin', '', 'superadmin,admin,user');
INSERT INTO `oj_user` VALUES ('2', '2024-01-01 00:00:00', '2024-01-01 00:00:00', '{\"banThirdParty\":0,\"banEmailUpdate\":0,\"banInfoUpdate\":0,\"requirePasswordChange\":1}', '0', '0', 'superta', 'TA', 'salt_', '9466981e0b3301a1f0598d9adddc8b5a', null, '1', '12345678910', '0', '', null, 'user,admin');
ALTER TABLE `oj_user` AUTO_INCREMENT=1000;

-- ----------------------------
-- Records of oj_file
-- Default: two data file (1.in/1.out)
-- ----------------------------
INSERT INTO `oj_file` VALUES (635282947619950593, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 4, '1', '4439a7a296ee24e78e402d0cd534fa27', '1.in', 'in');
INSERT INTO `oj_file` VALUES (635282947632533506, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 2, '1', '26ab0db90d72e28ad0ba1e22ee510510', '1.out', 'out');

-- ----------------------------
-- Records of oj_checkpoint
-- Default: 1 checkpoint (1.in/1.out) for A+B Problem
-- ----------------------------
INSERT INTO `oj_checkpoint` VALUES (635282948043575297, '2024-01-01 00:00:00', '2024-01-01 00:00:00', NULL, '1 1\n', '2\n', 4, 2, '1.in', '1.out', 635282947619950593, 635282947632533506);

-- ----------------------------
-- Records of oj_judge_template
-- Default: C/C++/Python3/Java
-- ----------------------------
INSERT INTO `oj_judge_template` VALUES (1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 2, NULL, 1, 1, 0, 'C++11', '{\n  \"user\": {\n    \"compile\": {\n      \"srcName\": \"solution.cc\",\n      \"maxCpuTime\": 3000,\n      \"maxRealTime\": 5000,\n      \"maxMemory\":  262144,\n      \"commands\": [\n            \"/usr/bin/g++ -DONLINE_JUDGE -O2 -w -fmax-errors=3 -std=c++11 solution.cc -lm -o solution\"\n          ]\n      },\n      \"run\": {\n      \"command\": \"solution\",\n      \"seccompRule\": \"c_cpp\"\n    }\n  }\n}', 'cc,cpp', '', '', 'C++11 IO 评测模板');
INSERT INTO `oj_judge_template` VALUES (2, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 2, NULL, 1, 1, 0, 'Python 3', '{\n	\"user\": {\n  	\"compile\": {\n    	\"srcName\": \"solution.py\",\n      \"maxCpuTime\": 3000,\n      \"maxRealTime\": 5000,\n      \"maxMemory\": 262144,\n      \"commands\": [\n      	\"/usr/bin/python3 -m py_compile solution.py\"\n      ]\n    },\n    \"run\": {\n    	\"command\": \"/usr/bin/python3 __pycache__/solution.cpython-36.pyc\",\n      \"seccompRule\": \"general\",\n      \"maxRealTimeFactor\": 2,\n      \"maxCpuTimeFactor\": 2\n    }\n  }\n}', 'py', '', '', 'Python3 IO 评测模板');
INSERT INTO `oj_judge_template` VALUES (3, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 2, NULL, 1, 1, 0, 'Python 2', '{\n	\"user\": {\n  	\"compile\": {\n    	\"srcName\": \"solution.py\",\n      \"maxCpuTime\": 3000,\n      \"maxRealTime\": 5000,\n      \"maxMemory\": 262144,\n      \"commands\": [\n      	\"/usr/bin/python -m py_compile solution.py\"\n      ]\n    },\n    \"run\": {\n    	\"command\": \"/usr/bin/python solution.pyc\",\n      \"seccompRule\": \"general\",\n      \"maxRealTimeFactor\": 2,\n      \"maxCpuTimeFactor\": 2\n    }\n  }\n}', 'py', '', '', 'Python2 IO 评测模板');
INSERT INTO `oj_judge_template` VALUES (4, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 1, 2, NULL, 1, 1, 0, 'Java 8', '{\n	\"user\": {\n  	\"compile\": {\n    	\"srcName\": \"Main.java\",\n      \"maxCpuTime\": 3000,\n      \"maxRealTime\": 5000,\n      \"maxMemory\": 0,\n      \"commands\": [\n      	\"/opt/java/openjdk8/bin/javac Main.java -encoding UTF8\"\n      ]\n    },\n    \"run\": {\n    	\"command\": \"/opt/java/openjdk8/bin/java -XX:MaxRAM={problemMemoryLimit}k -Djava.security.manager -Djava.awt.headless=true Main\",\n      \"maxMemoryFactor\": 0,\n      \"maxCpuTimeFactor\": 2,\n      \"maxRealTimeFactor\": 2\n    }\n  }\n}', 'java', '', '', 'Java8 IO 评测模板');
ALTER TABLE `oj_judge_template` AUTO_INCREMENT=1000;

-- ----------------------------
-- Records of oj_problem_description
-- Default: A+B Problem
-- ----------------------------
INSERT INTO `oj_problem_description` VALUES (1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 0, 1, 1, 2, 0, 'Default', '# Background\nSpecial for beginners, ^_^\n\n# Description\nGiven two integers x and y, print the sum.\n\n# Format\n\n## Input\nTwo integers x and y, satisfying 0 <= x, y <= 32767.\n\n## Output\nOne integer, the sum of x and y.\n\n# Sample 1\n\n## Input\n```\n123 500\n```\n\n## Output\n```\n623\n```\n\n# Limitation\n1s, 1024KiB for each test case.\n\n# Hint\n\n## Free Pascal Code\n\n```pascal\nvar a,b:longint;\nbegin\n    readln(a,b);\n    writeln(a+b);\nend.\n```\n\n## C Code\n\n```c\n#include <stdio.h>\nint main(void)\n{\n    int a, b;\n    scanf(\"%d%d\", &a, &b);\n    printf(\"%d\\n\", a + b);\n    return 0;\n}\n```\n\n## C++ Code\n\n```cpp\n#include <iostream>\nusing namespace std;\nint main()\n{\n    int a, b;\n    cin >> a >> b;\n    cout << a + b << endl;\n    return 0;\n}\n```\n\n## Python Code\n\n```python\na, b = [int(i) for i in raw_input().split()]\nprint(a + b)\n```\n\n## Java Code\n\n```java\nimport java.io.*;\nimport java.util.Scanner;\n\npublic class Main {\n\n    /**\n     * @param args\n     * @throws IOException \n     */\n    public static void main(String[] args) throws IOException {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}\n```', NULL, NULL, NULL, NULL, NULL, NULL);
ALTER TABLE `oj_problem_description` AUTO_INCREMENT=1000;

-- ----------------------------
-- Records of oj_problem
-- Default: A+B Problem
-- ----------------------------
INSERT INTO `oj_problem` VALUES (1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', '', 0, 0, 'SDUOJ-1', 1, 2, 'A+B Problem', '', NULL, NULL, 0, 0, 262144, 102400, 1000, 1, 1, '1,2,3,4', 0x08D0FA79B200100100000064, NULL, '', '{\"source\":\"lcmp.cpp\",\"spj\":null}', '[]');
ALTER TABLE `oj_problem` AUTO_INCREMENT=1000;

-- ----------------------------
-- Records of oj_contest
-- Default: None
-- ----------------------------
ALTER TABLE `oj_contest` AUTO_INCREMENT=1000;
