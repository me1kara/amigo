package com.lec.amigo.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
public class TimeTraceAdvice {

    public Object measureExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {        
        StopWatch sw = new StopWatch();
        
        sw.start();
        try {
            return joinPoint.proceed();
        } finally {
            sw.stop();
            String methodName = joinPoint.getSignature().toShortString();
            log.info("{} executed in {}ms", methodName, sw.getLastTaskTimeMillis());
        }
    }
}
