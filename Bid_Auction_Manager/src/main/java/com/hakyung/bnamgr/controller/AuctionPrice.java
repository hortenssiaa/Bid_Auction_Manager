package com.hakyung.bnamgr.controller;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.io.BufferedReader;
import java.io.IOException;
import java.net.MalformedURLException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;


@Controller
public class AuctionPrice {

	public static int INDENT_FACTOR = 4;
	private HashMap<String, String> pkindMap = new HashMap<String, String>();
	{
		// 블록 초기화 (or 생성자) 
		getPKindHashMap();
	} 
	
	@ResponseBody
	@RequestMapping(value = "/getPrice" , method = RequestMethod.POST , produces = "application/text; charset=UTF-8")
	public String getAuctionProductPrice(String p_kind, Locale locale) throws MalformedURLException, IOException {
		//String todaysDate = "20210814";
		String todaysDate = getTodaysDate(locale);
		int numOfRows = 2;
		JSONArray jsonArr = makeJSONArray(p_kind, numOfRows, todaysDate);
		
		return jsonArr.toString(INDENT_FACTOR); // return JSON
	}

	@ResponseBody
	@RequestMapping(value = "/getYTDayPrice" , method = RequestMethod.POST , produces = "application/text; charset=UTF-8")
	public String getYTDAuctionProductPrice(String p_kind, Locale locale) throws MalformedURLException, IOException {
		// 어제의 시세 
		//String todaysDate = "20210813";
		String todaysDate = getYestdaysDate(locale);
		int numOfRows = 2;
		JSONArray jsonArr = makeJSONArray(p_kind, numOfRows, todaysDate);
		
		return jsonArr.toString(INDENT_FACTOR); // return JSON
	}
	
	@ResponseBody
	@RequestMapping(value = "/getLastYTodayPrice" , method = RequestMethod.POST , produces = "application/text; charset=UTF-8")
	public String getLastYTodayPrice(String p_kind, Locale locale) throws MalformedURLException, IOException {
		// 작년의 오늘시세 
		//String todaysDate = "20200814";
		String todaysDate = getLastYTodayDate(locale);
		int numOfRows = 2;
		JSONArray jsonArr = makeJSONArray(p_kind, numOfRows, todaysDate);
		
		return jsonArr.toString(INDENT_FACTOR); // return JSON
	}
	
	private JSONArray makeJSONArray(String p_kind, int numOfRows, String todaysDate) throws MalformedURLException, IOException {
				JSONArray jsonArr = new JSONArray();
				String jsonParse = ""; // converted data from JSON to JSON.toString() 

				if (p_kind.equals("전체보기")) {
					for (String key : pkindMap.keySet()) {
						p_kind = pkindMap.get(key);
						
						StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552895/openapi/service/OrgPriceAuctionService/getExactProdPriceList"); /*URL*/
						urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=Mrr56QqXgS5NU1e%2FGiaVPtt5Fj%2FKHfvQwtgZynK4VMYp7m1fuYb0M%2FnOenRdFspT3DTM3U0T1o7iSXXbUzT22A%3D%3D"); /*Service Key*/
						urlBuilder.append("&pageNo=1&numOfRows=" + numOfRows + "&delngDe=" + todaysDate + "&prdlstCd=0" + p_kind);
						
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
						
						// code for converting XML to JSON
						JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
						jsonArr.put(xmlJSONObj);
					}
					
				} else {
					StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552895/openapi/service/OrgPriceAuctionService/getExactProdPriceList"); /*URL*/
					urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=Mrr56QqXgS5NU1e%2FGiaVPtt5Fj%2FKHfvQwtgZynK4VMYp7m1fuYb0M%2FnOenRdFspT3DTM3U0T1o7iSXXbUzT22A%3D%3D"); /*Service Key*/
					urlBuilder.append("&pageNo=1&numOfRows=" + numOfRows + "&delngDe=" + todaysDate + "&prdlstCd=0" + p_kind);
					
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
					
					// code for converting XML to JSON
					JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
					jsonArr.put(xmlJSONObj);
				}
				
				 // jsonParse = jsonArr.toString(INDENT_FACTOR);
  				//jsonParse = xmlJSONObj.toString(INDENT_FACTOR);
				return jsonArr;
	}
	
	private void getPKindHashMap() {
		//pkindMap.put("전체보기", "000");
		pkindMap.put("자두", "608");
		pkindMap.put("참다래(키위)", "611");
		pkindMap.put("바나나", "612");
		pkindMap.put("듀리안", "644");
		pkindMap.put("파인애플", "613");
		pkindMap.put("감귤", "614");
		pkindMap.put("레몬", "617");
		pkindMap.put("오렌지", "618");
		pkindMap.put("자몽", "619");
		pkindMap.put("무화과", "627");
		pkindMap.put("사과", "601");
		pkindMap.put("배", "602");
		pkindMap.put("아보카도", "634");
		pkindMap.put("포도", "603");
		pkindMap.put("복숭아", "604");
		pkindMap.put("망고", "636");
		pkindMap.put("망고스턴", "637");
		pkindMap.put("코코넛", "638");
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

	// Get yesterday's date (ex) 20210810)
	// 30, 31, 윤년 계산안함 
	public String getYestdaysDate(Locale locale) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		String resultYear = formattedDate.substring(0, formattedDate.indexOf("년"));
		String resultMonth = formattedDate.substring(formattedDate.indexOf("년") + 2, formattedDate.indexOf("월"));
		int resultDate = Integer.parseInt(formattedDate.substring(formattedDate.indexOf("월") + 2, formattedDate.indexOf("일"))) - 1;
		
		if (Integer.parseInt(resultMonth) < 10) resultMonth = "0" + resultMonth;
		
		return resultYear + resultMonth + resultDate;
	}

	// Get last year today (ex) 20200811)
	public String getLastYTodayDate(Locale locale) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		int resultYear = Integer.parseInt(formattedDate.substring(0, formattedDate.indexOf("년"))) - 1;
		String resultMonth = formattedDate.substring(formattedDate.indexOf("년") + 2, formattedDate.indexOf("월"));
		String resultDate = formattedDate.substring(formattedDate.indexOf("월") + 2, formattedDate.indexOf("일"));
		
		if (Integer.parseInt(resultMonth) < 10) resultMonth = "0" + resultMonth;
		
		return resultYear + resultMonth + resultDate;
	}
}
