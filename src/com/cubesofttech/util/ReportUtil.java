package com.cubesofttech.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;

@Component
public class ReportUtil {

	static Logger log = Logger.getLogger(ReportUtil.class);
	
	public static Connection conn;
	
	 private static DataSource dataSource;
	  @Autowired
	  public static void setDataSource(DataSource dataSource)  {
	    ReportUtil.dataSource=dataSource; 
	     }

	public static Connection getConnection() throws Exception {
		return conn =  dataSource.getConnection();
	}
	

	public static void printReportToBrowsePdf(String path, String nameFile, String pdfname,
			Map<String, Object> reportParameters, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String jasperFile = path + nameFile + ".jasper";
		try {
			JasperPrint jp = JasperFillManager.fillReport(jasperFile, reportParameters, ReportUtil.getConnection());
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"" + pdfname + "\"");
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, jp);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
			exporter.exportReport();
			response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException ex) {
				log.info(ex.getMessage());
			}
		}
	}
}
