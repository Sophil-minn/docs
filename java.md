
# JAVA 知识

### JAVA 基本术语
```
JAVA SE : java standard edtion (JAVA 标准版，以前称为 J2SE) - 主要做一般的java应用, 比如, 应用软件/ QQ之类的通信软件等等.
JAVA EE ：java Enterprise edtion（java 企业版，以前称为 J2EE）- 主要做企业应用, 比如公司网站, 企业解决方案等;
JAVA ME ：java Micro edtion (java 微型版) - 主要面向嵌入式等设备应用的开发, 比如手机游戏等
JVM : java 虚拟机
JDK：Java Development Kit （java的开发和运行环境，java的开发工具和jre）
JRE：Java Runtime Environment （java程序的运行环境）
```

### Spring Boot（JAVA 开发框架）
```
Spring Boot = Spring + (Spring java 基础框架)

Spring Boot的主要特点：
    创建独立的Spring应用程序
    直接嵌入Tomcat，Jetty或Undertow（无需部署WAR文件）
    提供“初始”的POM文件内容，以简化Maven配置
    尽可能时自动配置Spring
    提供生产就绪的功能，如指标，健康检查和外部化配置
    绝对无代码生成，也不需要XML配置

```

### IntelliJ IDEA（JAVA 开发工具）
```
1、IntelliJ IDEA  自带 Spring
```

#### 1、开发
```
Sprint 中 注解
1、 @RestContoller 、@RequestMapping
2、
2.1 @Controller 注入服务，相当于 action 层
2.2 @service 注入dao, 处理业务逻辑
2.3 @repository 实现dao访问
2.4 @component 实例化到 spring 容器中，相当于 bean class
```

#### 2、[API Doc文档](http://blog.didispace.com/springbootswagger2/)
```
1、pom.xml
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.2.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.2.2</version>
</dependency>

2、config
@Configuration
@EnableSwagger2
public class Swagger2 {

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.didispace.web"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("Spring Boot中使用Swagger2构建RESTful APIs")
                .description("更多Spring Boot相关文章请关注：http://blog.didispace.com/")
                .termsOfServiceUrl("http://blog.didispace.com/")
                .contact("程序猿DD")
                .version("1.0")
                .build();
    }

}

3、api Swagger
3.1、/v2/api-docs  生成的 json 文件
3.2、/swagger-ui.html 查看 api 文档
```

#### 3、（注释||代码） 模版
```

```

#### 4、Email
```
<!-- Email -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>


spring.mail.host=xxxxx.xxxx
spring.mail.username=用户名
spring.mail.password=密码
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.starttls.required=true
```

#### 5、Log
```
根据不同的日志系统，你可以按如下规则组织配置文件名，就能被正确加载：
Logback(Default)：logback-spring.xml, logback-spring.groovy, logback.xml, logback.groovy
Log4j：log4j-spring.properties, log4j-spring.xml, log4j.properties, log4j.xml
Log4j2：log4j2-spring.xml, log4j2.xml
JDK (Java Util Logging)：logging.properties

eg. log4j
1、引入依赖
<dependency>  
    <groupId>org.springframework.boot</groupId>  
    <artifactId>spring-boot-starter-web</artifactId>  
    <exclusions><!-- 去掉默认配置 -->  
        <exclusion>  
            <groupId>org.springframework.boot</groupId>  
            <artifactId>spring-boot-starter-logging</artifactId>  
        </exclusion>  
    </exclusions>  
</dependency>  
<dependency> <!-- 引入log4j2依赖 -->  
    <groupId>org.springframework.boot</groupId>  
    <artifactId>spring-boot-starter-log4j2</artifactId>  
</dependency>
   

2、LOG4J配置
log4j.rootLogger=info,ServerDailyRollingFile,stdout
log4j.appender.ServerDailyRollingFile=org.apache.log4j.DailyRollingFileAppender
log4j.appender.ServerDailyRollingFile.DatePattern='.'yyyy-MM-dd
log4j.appender.ServerDailyRollingFile.File=logs/test.log
log4j.appender.ServerDailyRollingFile.layout=org.apache.log4j.PatternLayout
log4j.appender.ServerDailyRollingFile.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} [%t] %-5p [%c] - %m%n
log4j.appender.ServerDailyRollingFile.Append=true
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d yyyy-MM-dd HH:mm:ss %p [%c] %m%n

3、使用
static final Logger logger = LogManager.getLogger(HelloController.class.getName());


```

#### 6、热部署
```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>

其它部分设置
```

#### 7、多环境切换
```
在 src/main/resources 目录下创建三个配置文件:
    application-dev.properties：用于开发环境
    application-test.properties：用于测试环境
    application-prod.properties：用于生产环境

在 application.properties 中配置：
    spring.profiles.active=dev
```

#### 8、定时任务
```
1、Spring Boot 的主类中加入 @EnableScheduling 注解，启用定时任务的配置
2、@Component 放在 任务类中 注解
3、@Scheduled(cron = "*/6 * * * * ?") 任务类中的方法中
```

#### 9、映射
```
@RequestParam
@ResponseBody

@RequestMapping
@GetMapping
@PostMapping
@PutMapping
@DeleteMapping
@PatchMapping

@RestController==@ResponseBody ＋ @Controller合在一起的作用

HttpServletRequest request
HttpServletResponse response
```

#### 10、JSP
```
1、properties
# 要想让spring-boot支持JSP，需要将项目打成war包。
# 我们做最后一点修改，修改pom.xml文件，将 jar 中的 jar 修改为 war
# 页面默认前缀目录
    spring.mvc.view.prefix=/WEB-INF/jsp/
    # 响应页面默认后缀
    spring.mvc.view.suffix=.jsp
    #关闭默认模板引擎
    spring.thymeleaf.cache=false
    spring.thymeleaf.enabled=false
    # 自定义属性，可以在Controller中读取
    application.hello=Hello Shanhy

2、pom.xml 添加依赖
<exclusion>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
</exclusion>

<!--加入对jsp支持-->
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
</dependency>
<!--加入对servlet支持-->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
</dependency>
<!--加入对jstl支持-->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
</dependency>
<!-- tomcat 的支持. -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <scope>provided</scope>
</dependency>

3、添加页面
项目名/src/main/webapp/WEB-INF/jsp

4、添加页面路由


```

#### 11、websocket
```

```

#### 12、过滤器 & 拦截器
```

```



[文档链接](https://blog.csdn.net/haiyang4988/article/details/79082783/)