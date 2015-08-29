package com.loneninja.geo;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class GeoLocate {
	
	public String fetchLatLong(String ipid, String url)
	{
		String result="NOTAVAIL,";
		Connection conn=null;
		String query="select latitude,longitude from id_location where id='"+ipid+"'";
		try {
			Driver d=(Driver) Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			Properties prop= new Properties();
			prop.put("user","prasanth");
			prop.put("password","prasanth");
			
			conn=d.connect(url,prop);
			Statement state=conn.createStatement();
			ResultSet rs=state.executeQuery(query);
			if(rs!=null&&rs.next())
			{			
			String lat=rs.getString(1);
			String longi=rs.getString(2);
			result=lat+","+longi+",";
			}
			
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
		
		
	}

}
