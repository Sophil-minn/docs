package com.example.demo;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

/**
 * @author Lix@jchvip.com
 * @date 2018/7/13 下午7:20
 */
@RestController
@RequestMapping(value="/api")
public class HelloController {


    static final Logger logger = LogManager.getLogger(HelloController.class.getName());

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping("/email")
    public String email(){

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("773155801@qq.com");
        message.setTo("773155801@qq.com");
        message.setSubject("主题：简单邮件");
        message.setText("测试邮件内容");

        mailSender.send(message);

        return "send email...:http://blog.didispace.com/springbootmailsender/";
    }



    @RequestMapping("/logger")
    public boolean log() throws Exception {
        logger.entry();
        logger.info("Did it again!");
        logger.debug("Did it again!");
        logger.error("Did it again!");

        return logger.exit(false);
    }

    /**
     *
     *
     *
     */
    @RequestMapping("/hello")
    public String hello(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");


        return "hello, spring moot!...1";
    }







    @GetMapping(value="/{name}")
    public String getName(@PathVariable String name){
        return "ooh you are " + name + "<br> nice to meet you";
    }

    
    @GetMapping(value="/t/{name}")
    public String getTName(@PathVariable String name){
        return "ooh you are " + name + "<br> nice to meet you";
    }


    @ApiOperation(value="获取用户详细信息", notes="根据url的id来获取用户详细信息")
    @ApiImplicitParam(name = "id", value = "用户ID", required = true, dataType = "Long")
    @RequestMapping(value="/setName", method = RequestMethod.POST)
    public String setName(@RequestParam(value = "name", required = true) String name,
                          @RequestParam(value = "pwd", required = true) String pwd){
        System.out.println("Fff");
        return name + ":" + pwd;
    }

    public String addUser(HttpServletRequest request) {
        /**
         *
         * @author huiminyang $date
         * @time 2018/7/15
         * @method addUser
         * @param [request]
         * @return java.lang.String
         * @version v1.0.0
         * @description 
         *
         */
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        return "demo/index";
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public String handleFileUploadOnlyFileField(@RequestParam("File")MultipartFile file) {

        if (!file.isEmpty()) {
            try {
                /*
                 * 这段代码执行完毕之后，图片上传到了工程的跟路径； 大家自己扩散下思维，如果我们想把图片上传到
                 * d:/files大家是否能实现呢？ 等等;
                 * 这里只是简单一个例子,请自行参考，融入到实际中可能需要大家自己做一些思考，比如： 1、文件路径； 2、文件名；
                 * 3、文件格式; 4、文件大小的限制;
                 */
                BufferedOutputStream out = new BufferedOutputStream(
                        new FileOutputStream(new File(file.getOriginalFilename())));
                System.out.println(file.getName());
                out.write(file.getBytes());
                out.flush();
                out.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                return "上传失败," + e.getMessage();
            } catch (IOException e) {
                e.printStackTrace();
                return "上传失败," + e.getMessage();
            }

            return "上传成功";

        } else {
            return "上传失败，因为文件是空的.";
        }

    }

    @RequestMapping(value = "/batch/upload", method = RequestMethod.POST)
    @ResponseBody
    public String handleFileUploadBatchFiled(HttpServletRequest request) {

        MultipartHttpServletRequest params=((MultipartHttpServletRequest) request);
        List<MultipartFile> files = ((MultipartHttpServletRequest) request)
                .getFiles("file");
        String name=params.getParameter("name");
        System.out.println("name:"+name);
        String id=params.getParameter("id");
        System.out.println("id:"+id);
        MultipartFile file = null;
        BufferedOutputStream stream = null;
        for (int i = 0; i < files.size(); ++i) {
            file = files.get(i);
            if (!file.isEmpty()) {
                try {
                    byte[] bytes = file.getBytes();
                    stream = new BufferedOutputStream(new FileOutputStream(
                            new File(file.getOriginalFilename())));
                    stream.write(bytes);
                    stream.close();
                } catch (Exception e) {
                    stream = null;
                    return "You failed to upload " + i + " => "
                            + e.getMessage();
                }
            } else {
                return "You failed to upload " + i
                        + " because the file was empty.";
            }
        }
        return "upload successful";
    }

}
