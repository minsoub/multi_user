package kr.co.neodreams.multi_user.common;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import kr.co.neodreams.multi_user.base.dao.BaseDao;

public class TableDataInit extends BaseDao {

    private Connection conn = null;

    public TableDataInit() {
        try {
            Class.forName(Constants.driver);
            System.out.println("driver load success");

            this.getConnection(Constants.url, Constants.user, Constants.password);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public TableDataInit(String nomu) {
    	try {
    		Class.forName(Constants.driver);
    		System.out.println("driver load success");
    		
    		this.getConnection(Constants.url_nomu, Constants.user_nomu, Constants.password_nomu);
    		
    	} catch (ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    }

    public void getConnection(String url, String user, String password){

        try {
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("connection success");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<String> getDept_Data(String query_id){

        Statement stmt = null;
        String sql = getQuery(query_id);
        ResultSet rs = null;

        ArrayList<String> arrayList = new ArrayList<String>();
        String values = "";

        if(StringUtil.isNotEmpty(sql)){
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                int i = 0;

                while(rs.next()){

                    if(i < 500){

                    String dept_code = rs.getString("dept_code");
                    String dept_name = rs.getString("dept_name");
                    String up_code = rs.getString("up_code");
                    int dept_order = rs.getInt("dept_order");
                    String del_flag = rs.getString("del_flag");
                    String manager = rs.getString("manager");
                    String hostname = rs.getString("hostname");

                    values = values
                            + "("
                            + "'" + dept_code + "',"
                            + "'" + up_code + "',"
                            + "'" + dept_name + "',"
                            + dept_order + ",";

                        if(StringUtil.isEmpty(manager)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + manager + "',";
                        }

                        values = values + "'" + hostname + "',";

                        if(StringUtil.isEmpty(del_flag)){
                            values = values + "''" + "),";
                        }else{
                            values = values + "'" + del_flag + "'),";
                        }
                    }else{

                        String dept_code = rs.getString("dept_code");
                        String dept_name = rs.getString("dept_name");
                        String up_code = rs.getString("up_code");
                        int dept_order = rs.getInt("dept_order");
                        String del_flag = rs.getString("del_flag");
                        String manager = rs.getString("manager");
                        String hostname = rs.getString("hostname");

                        values = values
                                + "("
                                + "'" + dept_code + "',"
                                + "'" + up_code + "',"
                                + "'" + dept_name + "',"
                                + dept_order + ",";

                        if(StringUtil.isEmpty(manager)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + manager + "',";
                        }

                        values = values + "'" + hostname + "',";

                        if(StringUtil.isEmpty(del_flag)){
                            values = values + "''" + "),";
                        }else{
                            values = values + "'" + del_flag + "'),";
                        }

                        //끝 ',' 제거
                        values = values.substring(0, values.length() - 1);

                        arrayList.add(values);
                        values = "";
                        i = -1;
                    }

                    i = i + 1;
                }

                if(StringUtil.isNotEmpty(values)){
                    values = values.substring(0, values.length() - 1);

                    arrayList.add(values);
                }
            } catch (SQLException e) {
                e.printStackTrace();

                arrayList = null;

                if(conn != null){
                    try {
                        conn.close();
                    } catch (SQLException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                }

            } finally {
                try{
                    if(rs != null){
                        rs.close();
                    }
                    if(stmt != null){
                        stmt.close();
                    }
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }
        }

        return arrayList;
    }

    public ArrayList<String> getUser_Data(String query_id){

        Statement stmt = null;
        String sql = getQuery(query_id);
        ResultSet rs = null;

        ArrayList<String> arrayList = new ArrayList<String>();
        String values = "";

        if(StringUtil.isNotEmpty(sql)){
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                int i = 0;

                while(rs.next()){

                    if(i < 500){

                        String empno        = rs.getString("empno");
                        String name         = rs.getString("name");
                        String mailno       = rs.getString("mailno");
                        String sosok        = rs.getString("sosok");
                        String deptno       = rs.getString("deptno");
                        String hp           = rs.getString("hp");
                        String telno        = rs.getString("telno");
                        String levelno      = rs.getString("levelno");
                        String classno      = rs.getString("classno");
                        String passwd       = rs.getString("passwd");
                        String leveldate        = rs.getString("leveldate");
                        String title        = rs.getString("title");
                        String exist        = rs.getString("exist");
                        String levelnm      = rs.getString("levelnm");
                        String classnm      = rs.getString("classnm");
                        String jikyee       = rs.getString("jikyee");


                        values = values
                                + "("
                                + "'" + empno + "',"
                                + "'" + name + "',"
                                + "'" + mailno + "',"
                                + "'" + sosok + "',"
                                + "'" + deptno + "',"
                                + "'" + hp + "',"
                                + "'" + telno + "',";

                        if(StringUtil.isEmpty(levelno)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + levelno + "',";
                        }

                        if(StringUtil.isEmpty(classno)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + classno + "',";
                        }

                        values = values + "'" + passwd + "',"
                                + "'" + leveldate + "',"
                                + "'" + title + "',"
                                + "'" + exist + "',"
                                + "'" + levelnm + "',"
                                + "'" + classnm + "',";

                        if(StringUtil.isEmpty(jikyee)){
                            values = values + "''" + "),";
                        }else{
                            values = values + "'" + jikyee + "'),";
                        }
                    } else{
                        String empno        = rs.getString("empno");
                        String name         = rs.getString("name");
                        String mailno       = rs.getString("mailno");
                        String sosok        = rs.getString("sosok");
                        String deptno       = rs.getString("deptno");
                        String hp           = rs.getString("hp");
                        String telno        = rs.getString("telno");
                        String levelno      = rs.getString("levelno");
                        String classno      = rs.getString("classno");
                        String passwd       = rs.getString("passwd");
                        String leveldate        = rs.getString("leveldate");
                        String title        = rs.getString("title");
                        String exist        = rs.getString("exist");
                        String levelnm      = rs.getString("levelnm");
                        String classnm      = rs.getString("classnm");
                        String jikyee       = rs.getString("jikyee");


                        values = values
                                + "("
                                + "'" + empno + "',"
                                + "'" + name + "',"
                                + "'" + mailno + "',"
                                + "'" + sosok + "',"
                                + "'" + deptno + "',"
                                + "'" + hp + "',"
                                + "'" + telno + "',";

                        if(StringUtil.isEmpty(levelno)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + levelno + "',";
                        }

                        if(StringUtil.isEmpty(classno)){
                            values = values + "null" + ",";
                        }else{
                            values = values + "'" + classno + "',";
                        }

                        values = values + "'" + passwd + "',"
                                + "'" + leveldate + "',"
                                + "'" + title + "',"
                                + "'" + exist + "',"
                                + "'" + levelnm + "',"
                                + "'" + classnm + "',";

                        if(StringUtil.isEmpty(jikyee)){
                            values = values + "''" + "),";
                        }else{
                            values = values + "'" + jikyee + "'),";
                        }

                        //끝 ',' 제거
                        values = values.substring(0, values.length() - 1);

                        arrayList.add(values);
                        values = "";
                        i = -1;
                    }
                    i = i + 1;
                }
                if(StringUtil.isNotEmpty(values)){
                    values = values.substring(0, values.length() - 1);

                    arrayList.add(values);
                }
            } catch (SQLException e) {
                e.printStackTrace();

                arrayList = null;

                if(conn != null){
                    try {
                        conn.close();
                    } catch (SQLException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                }
            } finally {
                try{
                    if(rs != null){
                        rs.close();
                    }
                    if(stmt != null){
                        stmt.close();
                    }
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }
        }

        return arrayList;
    }

    public ArrayList<String> getDetail_Data(String query_id){

        Statement stmt = null;
        String sql = getQuery(query_id);
        ResultSet rs = null;

        ArrayList<String> arrayList = new ArrayList<String>();
        String values = "";

        if(StringUtil.isNotEmpty(sql)){
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                int i = 0;

                while(rs.next()){

                    if(i < 500){

                        String empno        = rs.getString("empno");
                        String infaxno      = rs.getString("infaxno");
                        String cellno       = rs.getString("cellno");
                        String haname   = rs.getString("haname");
                        String com_date         = rs.getString("com_date");
                        String bodate       = rs.getString("bodate");
                        String ename        = rs.getString("ename");
                        String out_telno        = rs.getString("out_telno");
                        String out_faxno        = rs.getString("out_faxno");


                        values = values
                                + "("
                                + "'" + empno + "',"
                                + "'" + infaxno + "',"
                                + "'" + cellno + "',"
                                + "'" + haname + "',"
                                + "'" + com_date + "',"
                                + "'" + bodate + "',"
                                + "'" + ename + "',"
                                + "'" + out_telno + "',"
                                + "'" + out_faxno + "'),";

                    } else{
                        String empno        = rs.getString("empno");
                        String infaxno      = rs.getString("infaxno");
                        String cellno       = rs.getString("cellno");
                        String haname   = rs.getString("haname");
                        String com_date         = rs.getString("com_date");
                        String bodate       = rs.getString("bodate");
                        String ename        = rs.getString("ename");
                        String out_telno        = rs.getString("out_telno");
                        String out_faxno        = rs.getString("out_faxno");

                        values = values
                                + "("
                                + "'" + empno + "',"
                                + "'" + infaxno + "',"
                                + "'" + cellno + "',"
                                + "'" + haname + "',"
                                + "'" + com_date + "',"
                                + "'" + bodate + "',"
                                + "'" + ename + "',"
                                + "'" + out_telno + "',"
                                + "'" + out_faxno + "'),";

                        //끝 ',' 제거
                        values = values.substring(0, values.length() - 1);

                        arrayList.add(values);
                        values = "";
                        i = -1;
                    }
                    i = i + 1;
                }
                if(StringUtil.isNotEmpty(values)){
                    values = values.substring(0, values.length() - 1);

                    arrayList.add(values);
                }
            } catch (SQLException e) {
                e.printStackTrace();

                arrayList = null;

                if(conn != null){
                    try {
                        conn.close();
                    } catch (SQLException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                }
            } finally {
                try{
                    if(rs != null){
                        rs.close();
                    }
                    if(stmt != null){
                        stmt.close();
                    }
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }
        }

        return arrayList;
    }

    public ArrayList<String> getUser_Data_nomu(String query_id){

        Statement stmt = null;
        String sql = getQuery(query_id);
        ResultSet rs = null;

        ArrayList<String> arrayList = new ArrayList<String>();
        String values = "";

        if(StringUtil.isNotEmpty(sql)){
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                int i = 0;

                while(rs.next()){

                    if(i < 500){

                        String empno        	= rs.getString("empno");
                        String name         	= rs.getString("name");
                        String levelno      	= rs.getString("levelno");
                        String levelnm      	= rs.getString("levelnm");
                        String dept_code    	= rs.getString("dept_code");
                        String dept_name      	= rs.getString("dept_name");
                        String fu_dept_code		= rs.getString("fu_dept_code");
                        String telno      		= rs.getString("telno");
                        String classno      	= rs.getString("classno");
                        String classnm      	= rs.getString("classnm");
                        String birth      		= rs.getString("birth");
                        String com_date      	= rs.getString("com_date");
                        String leveldate      	= rs.getString("leveldate");
                        String bodate      		= rs.getString("bodate");
                        String photo      		= rs.getString("photo");

                        values = values
                                + "("
                                + nvlChk(empno) + ","
                                + nvlChk(name) + ","
                                + nvlChk(levelno) + ","
                                + nvlChk(levelnm) + ","
                                + nvlChk(dept_code) + ","
                                + nvlChk(dept_name) + ","
                                + nvlChk(fu_dept_code) + ","
                                + nvlChk(telno) + ","
                                + nvlChk(classno) + ","
                                + nvlChk(classnm) + ","
                                + nvlChk(birth) + ","
                                + nvlChk(com_date) + ","
                                + nvlChk(leveldate) + ","
                                + nvlChk(bodate) + ","
                                + nvlChk(photo) + "),";
                    } else{
                    	String empno        	= rs.getString("empno");
                        String name         	= rs.getString("name");
                        String levelno      	= rs.getString("levelno");
                        String levelnm      	= rs.getString("levelnm");
                        String dept_code    	= rs.getString("dept_code");
                        String dept_name      	= rs.getString("dept_name");
                        String fu_dept_code		= rs.getString("fu_dept_code");
                        String telno      		= rs.getString("telno");
                        String classno      	= rs.getString("classno");
                        String classnm      	= rs.getString("classnm");
                        String birth      		= rs.getString("birth");
                        String com_date      	= rs.getString("com_date");
                        String leveldate      	= rs.getString("leveldate");
                        String bodate      		= rs.getString("bodate");
                        String photo      		= rs.getString("photo");

                        values = values
                                + "("
                                + nvlChk(empno) + ","
                                + nvlChk(name) + ","
                                + nvlChk(levelno) + ","
                                + nvlChk(levelnm) + ","
                                + nvlChk(dept_code) + ","
                                + nvlChk(dept_name) + ","
                                + nvlChk(fu_dept_code) + ","
                                + nvlChk(telno) + ","
                                + nvlChk(classno) + ","
                                + nvlChk(classnm) + ","
                                + nvlChk(birth) + ","
                                + nvlChk(com_date) + ","
                                + nvlChk(leveldate) + ","
                                + nvlChk(bodate) + ","
                                + nvlChk(photo) + "),";

                        //끝 ',' 제거
                        values = values.substring(0, values.length() - 1);

                        arrayList.add(values);
                        values = "";
                        i = -1;
                    }
                    i = i + 1;
                }
                if(StringUtil.isNotEmpty(values)){
                    values = values.substring(0, values.length() - 1);

                    arrayList.add(values);
                }
            } catch (SQLException e) {
                e.printStackTrace();

                arrayList = null;

                if(conn != null){
                    try {
                        conn.close();
                    } catch (SQLException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                }
            } finally {
                try{
                    if(rs != null){
                        rs.close();
                    }
                    if(stmt != null){
                        stmt.close();
                    }
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }
        }

        return arrayList;
    }
    
    private String nvlChk(String str){
    	String retVal = null;    	
    	
    	if(StringUtil.isNotEmpty(str)){
    		retVal = "'" + str + "'";
    	}
    	
    	return retVal;
    }
    
    public String getQuery(String query_id){

        String query = null;

        try{

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            Document doc = builder.parse(new File(Constants.getQueryXml));

            NodeList list = doc.getElementsByTagName(query_id);

            query = list.item(0).getTextContent();

        } catch (Exception e){
            e.printStackTrace();
        } finally {
        }

        return query;
    }

    public static void main(String[] args) throws Exception {
        TableDataInit dataInit = new TableDataInit();
        dataInit.getDept_Data("dept_select");
    }
}
