package com.hackthon.teamwg.projects.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class CommonUtils {

	private static Properties prop = new Properties();
	public static int PAGE_SIZE = 15 ;
	static InputStream inputStr = null;

	static {
		try {

			inputStr = CommonUtils.class.getClassLoader().getResourceAsStream("db.properties");
			prop.load(inputStr);

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (inputStr != null) {
				try {
					inputStr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

	public static String getPropertyValue(String key) {
		System.out.println(prop.getProperty(key));
		return prop.getProperty(key);
	}
}
