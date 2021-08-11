package com.hakyung.bnamgr.controller;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.io.BufferedReader;
import java.io.IOException;
import java.net.MalformedURLException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

 
import org.json.JSONObject;
import org.json.XML;


@Controller
public class AuctionPrice {

	public static int INDENT_FACTOR = 4;
	
	@ResponseBody
	@RequestMapping(value = "/getPrice" , method = RequestMethod.GET , produces = "application/text; charset=UTF-8")
	public String getAuctionProductPrice(Locale locale) throws MalformedURLException, IOException {
		
		getProductCodenNm(locale);
		
		String todaysDate = getTodaysDate(locale);
		int numOfRows = 1000;
		String p_kind = "0614"; // 0614 : 귤 (mandarin) --> 카테고리 클릭시; 해당 데이터 매개변수 p_kind로 받아오기 
		String jsonParse = ""; // converted data from XML to JSON 
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552895/openapi/service/OrgPriceAuctionService/getExactProdPriceList"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=Mrr56QqXgS5NU1e%2FGiaVPtt5Fj%2FKHfvQwtgZynK4VMYp7m1fuYb0M%2FnOenRdFspT3DTM3U0T1o7iSXXbUzT22A%3D%3D"); /*Service Key*/
		urlBuilder.append("&pageNo=1&numOfRows=" + numOfRows + "&delngDe=" + todaysDate + "&prdlstCd=" + p_kind);
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		//System.out.println("xml : \n" + sb.toString());

		// code for converting XML to JSON
		JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
		jsonParse = xmlJSONObj.toString(INDENT_FACTOR);
		//System.out.println("json : \n" + jsonParse + "\n");
		
		return jsonParse; // return JSON
	}
	
	// Put product category code & name data in HashMap<Category_Code, Category_Name>
	protected HashMap<Integer, String> distributeCategCode(String dataCode, HashMap<Integer, String> map) {
		
		// if data exists
		if (dataCode.contains("<item>")) { 
			
			// 1. 품목 코드 (category code)
			int targetNum = dataCode.indexOf("<stdPrdlstNewCode>") + "<stdPrdlstNewCode>".length();
			String stdPrdlstNewCode_str = dataCode.substring(targetNum, 
					dataCode.substring(targetNum).indexOf("</stdPrdlstNewCode>") + targetNum);
			int stdPrdlstNewCode = Integer.parseInt(stdPrdlstNewCode_str);
			
			// 2. 품목명 (category name)
			targetNum = dataCode.indexOf("<stdPrdlstNewNm>") + "<stdPrdlstNewNm>".length();
			String stdPrdlstNewNm = dataCode.substring(targetNum, 
					dataCode.substring(targetNum).indexOf("</stdPrdlstNewNm>") + targetNum);
			
			map.put(stdPrdlstNewCode, stdPrdlstNewNm);
		}
		
		return map;
	}
	
	// Get product category code & name
	public HashMap<Integer, String> getProductCodenNm(Locale locale) throws MalformedURLException, IOException {
		int numOfRows = 2; // 데이터 개수 (size of data)
		int prdlstCd = 601; // 상품 코드 (product code)
		String todaysDate = getTodaysDate(locale); 
		int max = 50;
		HashMap<Integer, String> map = new HashMap<Integer, String>();
		HashMap<Integer, String> resultMap = null;
		for(int i = prdlstCd; i < prdlstCd + max; i++) {

			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552895/openapi/service/OrgPriceAuctionService/getExactProdPriceList"); /*URL*/
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=Mrr56QqXgS5NU1e%2FGiaVPtt5Fj%2FKHfvQwtgZynK4VMYp7m1fuYb0M%2FnOenRdFspT3DTM3U0T1o7iSXXbUzT22A%3D%3D"); /*Service Key*/
			urlBuilder.append("&pageNo=1&numOfRows=2&delngDe=" + todaysDate + "&prdlstCd=0" + i);
			
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			//System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			//System.out.println("xml : \n" + sb.toString());

			if (i == prdlstCd + max - 1) {
				resultMap = distributeCategCode(sb.toString(), map);
				System.out.println(resultMap);
				System.out.println("size : " + distributeCategCode(sb.toString(), map).size());
			} else
				distributeCategCode(sb.toString(), map);
        
        }
        
		return resultMap; 
	}
	
	// Get today's date (ex) 20210811)
	public String getTodaysDate(Locale locale) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		String resultYear = formattedDate.substring(0, formattedDate.indexOf("년"));
		String resultMonth = formattedDate.substring(formattedDate.indexOf("년") + 2, formattedDate.indexOf("월"));
		String resultDate = formattedDate.substring(formattedDate.indexOf("월") + 2, formattedDate.indexOf("일"));
		
		if (Integer.parseInt(resultMonth) < 10) resultMonth = "0" + resultMonth;
		
		return resultYear + resultMonth + resultDate;
	}
}
