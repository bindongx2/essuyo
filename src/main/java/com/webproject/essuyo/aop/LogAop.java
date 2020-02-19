package com.webproject.essuyo.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAop {
	private static final Logger logger = LoggerFactory.getLogger(LogAop.class);
	
	@Around("execution(* com.webproject.essuyo..*.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable{
		long StartTime = System.currentTimeMillis();
		logger.info(Arrays.toString(pjp.getArgs()));
		
		Object result = pjp.proceed();
		
		long endTime = System.currentTimeMillis();
		logger.info(pjp.getSignature().getName() + " : " + (endTime - StartTime));
		logger.info("====================================");
		
		return result;
		
	}
}
