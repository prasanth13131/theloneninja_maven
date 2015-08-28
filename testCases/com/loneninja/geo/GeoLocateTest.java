package com.loneninja.geo;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class GeoLocateTest {
	
	GeoLocate gl=null;
	String url="jdbc:oracle:thin:@113.128.164.178:1521:XE";
	@Before
	public void setUp() throws Exception {
		gl=new GeoLocate();
	}

	@After
	public void tearDown() throws Exception {
		gl=null;
	}

	@Test
	public void testFetchLatLong_null() {
		String result=gl.fetchLatLong(null,url);
		assertEquals(result,"NOTAVAIL,");
	}
	@Test
	public void testFetchLatLong_empty() {
		String result=gl.fetchLatLong("",url);
		assertEquals(result,"NOTAVAIL,");
	}
	@Test
	public void testFetchLatLong_invalid() {
		String result=gl.fetchLatLong("12345",url);
		assertEquals(result,"NOTAVAIL,");
	}
	@Test
	public void testFetchLatLong_valid() {
		String result=gl.fetchLatLong("D1001",url);
		assertEquals(result,"13.006454,80.22021,");
	}

}
