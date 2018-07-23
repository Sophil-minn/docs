package com.example.demo;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author Lix@jchvip.com
 * @date 2018/7/14 上午12:51
 */
@Component
public class SchedulerTask {

    private int count = 0;

    @Scheduled(cron = "*/6 * * * * ?")
    private void process() {

        System.out.println("this is scheduler task running " + (count++));

    }
}
