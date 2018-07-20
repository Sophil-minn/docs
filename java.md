JAVA SE : java standard edtion (JAVA 标准版，以前称为 J2SE) - 主要做一般的java应用, 比如, 应用软件/ QQ之类的通信软件等等.
JAVA EE ：java Enterprise edtion（java 企业版，以前称为 J2EE）- 主要做企业应用, 比如公司网站, 企业解决方案等;
JAVA ME ：java Micro edtion (java 微型版) - 主要面向嵌入式等设备应用的开发, 比如手机游戏等
JVM : java 虚拟机
JDK：Java Development Kit （java的开发和运行环境，java的开发工具和jre）
JRE：Java Runtime Environment （java程序的运行环境）
Spring Boot = Spring + (Spring java 基础框架)

Spring Boot的主要特点：
    创建独立的Spring应用程序
    直接嵌入Tomcat，Jetty或Undertow（无需部署WAR文件）
    提供“初始”的POM文件内容，以简化Maven配置
    尽可能时自动配置Spring
    提供生产就绪的功能，如指标，健康检查和外部化配置
    绝对无代码生成，也不需要XML配置

1、IntelliJ IDEA  自带 Spring

Sprint 中 注解
1、 @RestContoller 、@RequestMapping
2、
2.1 @Controller 注入服务，相当于 action 层
2.2 @service 注入dao, 处理业务逻辑
2.3 @repository 实现dao访问
2.4 @component 实例化到 spring 容器中，相当于 bean class

Swagger
1、/v2/api-docs  生成的 json 文件
2、/swagger-ui.html 查看 api 文档