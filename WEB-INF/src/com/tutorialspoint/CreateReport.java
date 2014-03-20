package com.tutorialspoint;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class CreateReport {

   public static void main(String[] args) {
      String masterReportFileName = "jasper_report_template.jrxml";
      String subReportFileName = "AddressReport.jrxml";
      String destFileName = "jasper_report_template.JRprint";
      DataBeanList DataBeanList = new DataBeanList();
      ArrayList<DataBean> dataList = DataBeanList.getDataBeanList();
      JRBeanCollectionDataSource beanColDataSource =
            new JRBeanCollectionDataSource(dataList);

      try {
         /* Compile the master and sub report */
         JasperReport jasperMasterReport = JasperCompileManager
            .compileReport(masterReportFileName);
         JasperReport jasperSubReport = JasperCompileManager
            .compileReport(subReportFileName);

         Map<String, Object> parameters = new HashMap<String, Object>();
         parameters.put("subreportParameter", jasperSubReport);
         JasperFillManager.fillReportToFile(jasperMasterReport,
            destFileName, parameters, beanColDataSource);

      } catch (JRException e) {

         e.printStackTrace();
      }
      System.out.println("Done filling!!! ...");
   }
}