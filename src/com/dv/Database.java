package com.dv;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class Database {
	private static Connection conn = null;
	private  static String url = null;
	private  static String dbName = null;
	private static String driver = null;
	private static String userName = null;
	private static String password = null;

	Database(){	}


	public static void getQuestions() throws SQLException {
		// TODO Auto-generated method stub
		System.out.println(" Database get qestions method");
		PreparedStatement ps = null;
		try {
			if(conn==null || conn.isClosed())GetConnection();
			StringBuffer sb = new StringBuffer();
			sb.append("select content from questions;");
			ps = conn.prepareStatement(sb.toString());
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				System.out.println("content : \n"+rs.getString(1));
			}
		}finally{
			ps.close();
		}
	}
	public static CriteriaBean GetQAnswers(CriteriaBean bean) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println(" Database GetQAnswers method");
		PreparedStatement ps = null;
		int minRep = 0,maxRep =0,minVote=0,maxVote=0;
		ArrayList<String> titles = new ArrayList<String>();
		ArrayList<String> links = new ArrayList<String>();
		ArrayList<QandAbean> qalist = new ArrayList<QandAbean>();
		QandAbean qabean;
		try {
			if(conn==null || conn.isClosed())GetConnection();
			StringBuffer sb = new StringBuffer();
			sb.append("select content from questions where month = ? and questionid = ?");
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, bean.getSelMonth());
			ps.setInt(2, bean.getqSelected());
			System.out.println("questions query : "+ ps.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				bean.setQuestion(rs.getString(1));
			}
			sb = new StringBuffer();
			sb.append("select votes,acceptedanswer,reputation,content from answers where month = ? and questionid = ?");
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, bean.getSelMonth());
			ps.setInt(2, bean.getqSelected());
			System.out.println("answers query : "+ ps.toString());
			rs = ps.executeQuery();
			

			while(rs.next()){
				qabean = new QandAbean();
				qabean.setVotes(rs.getInt(1));
				qabean.setAnswerStatus(rs.getString(2));
				qabean.setReputation(rs.getInt(3));
				String ans = rs.getString(4).replace("\n", " ");
				qabean.setAnswer(ans.replaceAll("\"", ""));
				 if(maxRep < qabean.getReputation() ){
					maxRep = qabean.getReputation();
				} else if(minRep > qabean.getReputation()){
					minRep = qabean.getReputation();
				}
				 if(maxVote < qabean.getVotes() ){
					 maxVote = qabean.getVotes();
					} else if(minVote > qabean.getVotes() ){
						minVote = qabean.getVotes();
					}
				
				qalist.add(qabean);
			}
		}finally{
			ps.close();
			
			bean.setQabean(qalist);
			bean.setAmaxRep(maxRep);
			bean.setAminRep(minRep);
			bean.setAmaxVote(maxVote);
			bean.setAminRep(minVote);
		}
		return bean;
	}

	public static CriteriaBean GetTites(CriteriaBean bean) throws Exception  {
		// TODO Auto-generated method stub
		System.out.println(" Database GetTites_Questions method");
		PreparedStatement ps = null;
		ArrayList<String> titles = new ArrayList<String>();
		ArrayList<String> links = new ArrayList<String>();
		ArrayList<Integer> views = new ArrayList<Integer>();
		ArrayList<Integer> votes = new ArrayList<Integer>();
		int count =1;
		if(conn==null || conn.isClosed())GetConnection();
		StringBuffer sb = new StringBuffer();
		sb.append("select title,link,views,votes from questions where month = ? ");
		if(bean.getQtype().equalsIgnoreCase("both")){

		}else{
			sb.append("and codeData = ? ");
		}
		if(Integer.parseInt(bean.getVoteInput())!= 0){
			sb.append(" and views > ? and views < ?");
		}
		ps = conn.prepareStatement(sb.toString());
		System.out.println("ps staement 1 : "+ps.toString());
		ps.setString(count, bean.getSelMonth());
		count++;
		if(bean.getQtype().equalsIgnoreCase("pragmatic")){
			ps.setString(count, "Yes"); count++;
		}else if (bean.getQtype().equalsIgnoreCase("syntactic")){
			ps.setString(count, "No"); count++;
		}
		
		if(bean.getVoteInput().equalsIgnoreCase("1")){
			ps.setString(count, "0"); count++;
			ps.setString(count, "100");
		}else if(bean.getVoteInput().equalsIgnoreCase("2")){
			ps.setString(count, "100"); count++;
			ps.setString(count, "500");
		}else if(bean.getVoteInput().equalsIgnoreCase("3")){
			ps.setString(count, "500");count++;
			ps.setString(count, "1000");
		}else if(bean.getVoteInput().equalsIgnoreCase("4")){
			ps.setString(count, "1000"); count++;
			ps.setString(count, "10000000");
		}
		System.out.println("query : "+ ps.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			titles.add(rs.getString(1));
			links.add(rs.getString(2));
			views.add(rs.getInt(3));
			votes.add(rs.getInt(4));
		}
		ps.close();
		bean.setTitles(titles);
		bean.setLinks(links);
		bean.setViews(views);
		bean.setVotes(votes);
		return bean;
	}
	private static void GetDBdetails() {
		// TODO Auto-generated method stub
		Properties prop = new Properties();
		InputStream input = null;

		try {
			String Path = "C:/Users/tejj/Desktop/PeerTool/Data_Visualization/WebContent/WEB-INF/constants.properties";
			input = new FileInputStream(Path);
			if(input==null) System.out.println("nullllllllll values");
			// load a properties file
			prop.load(input);

			// get the property value and print it out
			url = getValues("url");
			dbName = getValues("dbName");
			driver = getValues("driver");;
			userName= getValues("userName");
			password =getValues("password");

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	public static void GetConnection(){
		System.out.println("-------- MySQL JDBC Connection Testing ------------");
		try {
			GetDBdetails();
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(url+dbName,userName,password);
			System.out.println("Connected to the database");

		} catch (Exception e) {
			System.out.println("NO CONNECTION =(");
		}

	}
	public static String getValues(String inp) throws IOException{
		Properties prop = new Properties();
		String Path = "C:/Users/tejj/Desktop/PeerTool/Data_Visualization/WebContent/WEB-INF/constants.properties";
		InputStream input = new FileInputStream(Path);
		if(input==null) System.out.println("nullllllllll values in getValues method");
		// load a properties file
		prop.load(input);
		if(prop.get(inp)!=null){
			String value = ""+ prop.get(inp);
			return value ;
		}
		return null;
	}

}
