package com.webproject.essuyo.utility;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping(path = "/open")
public class OpenApi {
	
    public static void main(String[] args) throws Exception, UnsupportedEncodingException, IOException {
        BufferedReader br = null;
        try{            
//            String urlstr = "http://openapi.airkorea.or.kr/"
//                    + "openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
//                    + "?stationName=수내동&dataTerm=month&pageNo=1&numOfRows=10&ServiceKey=서비스키&ver=1.3";
        	
        	// 마사회 배당률 Open API : http://apis.data.go.kr/B551015/API160
            String urlstr = "http://apis.data.go.kr/B551015/API160";
            URL url = new URL(urlstr);
            HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
            urlconnection.setRequestMethod("GET");
            br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8"));
            String result = "";
            String line;
            
            while((line = br.readLine()) != null) {
                result = result + line + "\n";
            }
            
            System.out.println(result);
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }

}
