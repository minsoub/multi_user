package  kr.co.neodreams.multi_user.common;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

/**
 * @author 38940112
 *
 */
public class DataMap extends HashMap implements Serializable	
{
    static final long serialVersionUID = 5644790636621937528L;
	public DataMap()
    {
        super(500);
    }
	
    public DataMap(int initialCapacity)
    {
        super(initialCapacity);
    }
     
    /**
     * request.getParameterMap 정보를 인자값으로 받아 HashMap 값을 초기화 한다.
     * @param map
     */
    public DataMap(Map map)
    {
    	super(map);
		Iterator names = map.keySet().iterator();
		while (names.hasNext()) {

			String name = (String) names.next();

			Object parameterValue = null;
			parameterValue = map.get(name);
			//parameter 값이 배열일 경우.
			if (parameterValue instanceof String[]) {				
				String[] paramValue = null;
				String paramStrValue = null;
				if ((paramValue = (String[]) parameterValue) != null 
						&& paramValue.length >= 1) {
					if(paramValue.length == 1 
							&& (paramStrValue = paramValue[0]) != null){
						super.put(name, paramStrValue);
					}else{
						super.put(name, paramValue);
					}
				}
			}
			//parameter 값이 문자형일 경우.
			else if (parameterValue instanceof String) {				
				String paramStrValue = (String) parameterValue;
				if (paramStrValue != null && paramStrValue.trim().length() > 0) {
					super.put(name, paramStrValue);
				}
			}
		}
    }
    /**
     * request 정보를 인자값으로 받아 HashMap 값을 초기화 한다.
     * @param map
     */
    public DataMap(HttpServletRequest request)
    {
        super(request.getParameterMap());
        java.util.Enumeration _enum = request.getParameterNames();
        
        String tmp_value = "";	//값 확인용 
        
        while( _enum.hasMoreElements() ) {
        	String name = (String)_enum.nextElement();
			Object parameterValue = null;
			parameterValue = request.getParameterValues(name);
			//parameter 값이 배열일 경우.
			if (parameterValue instanceof String[]) {				
				String[] paramValue = null;
				String paramStrValue = null;
				
				if ((paramValue = (String[]) parameterValue) != null 
						&& paramValue.length >= 1) {
					if(paramValue.length == 1 
							&& (paramStrValue = paramValue[0]) != null){
						super.put(name, NeoUtil.toKorean(paramStrValue));
						//super.put(name, paramStrValue);
						
						tmp_value = NeoUtil.toKorean(paramStrValue);
					}else{  
						super.put(name, NeoUtil.toKorean(paramValue.toString()));
						//super.put(name, paramValue.toString());
						
						tmp_value = NeoUtil.toKorean(paramValue.toString());
					}
				}
			}
			//parameter 값이 문자형일 경우.
			else if (parameterValue instanceof String) {				
				String paramStrValue = (String) parameterValue;
				if (paramStrValue != null && paramStrValue.trim().length() > 0) {
					super.put(name, NeoUtil.toKorean(paramStrValue));
					//super.put(name, paramStrValue);
					
					tmp_value = NeoUtil.toKorean(paramStrValue);
				}
			}
			
			//System.out.println(name + "::::::::" + tmp_value);
		}
    }   
    
    /**
     * request 정보를 인자값으로 받아 HashMap 값을 초기화 한다.
     * @param map
     */
    public DataMap(HttpServletRequest request, String ajax)
    {
        super(request.getParameterMap());
        java.util.Enumeration _enum = request.getParameterNames();
        
        String tmp_value = "";	//값 확인용 
        
        while( _enum.hasMoreElements() ) {
        	String name = (String)_enum.nextElement();
			Object parameterValue = null;
			parameterValue = request.getParameterValues(name);
			//parameter 값이 배열일 경우.
			
			if (parameterValue instanceof String[]) {				
				String[] paramValue = null;
				String paramStrValue = null;
				
				if ((paramValue = (String[]) parameterValue) != null 
						&& paramValue.length >= 1) {
					
					if(paramValue.length == 1 
							&& (paramStrValue = paramValue[0]) != null){
						super.put(name, paramStrValue);
						
						tmp_value = paramStrValue;
					}else{  
						super.put(name, paramValue);
						
						tmp_value = paramValue.toString();
					}
				}
			}
			//parameter 값이 문자형일 경우.
			else if (parameterValue instanceof String) {				
				String paramStrValue = (String) parameterValue;
				if (paramStrValue != null && paramStrValue.trim().length() > 0) {
					super.put(name, paramStrValue);
					
					tmp_value = paramStrValue;
				}
			}
			
			//System.out.println(name + "::::::::" + tmp_value);
		}
    }   
    
    /**
     * MultipartRequest 정보를 인자값으로 받아 HashMap 값을 초기화 한다.
     * @param MultipartRequest
     */
    public DataMap(MultipartRequest request)
    {
        super(500);
        System.out.println("aaaaaaa");
        java.util.Enumeration _enum = request.getParameterNames();
        while( _enum.hasMoreElements() ) {
        	String name = (String)_enum.nextElement();
			Object parameterValue = null;
			parameterValue = request.getParameterValues(name);
			//parameter 값이 배열일 경우.
			if (parameterValue instanceof String[]) {				
				String[] paramValue = null;
				String paramStrValue = null;
				if ((paramValue = (String[]) parameterValue) != null 
						&& paramValue.length >= 1) {
					if(paramValue.length == 1 
							&& (paramStrValue = paramValue[0]) != null){
						super.put(name, paramStrValue);
					}else{
						super.put(name, paramValue);
					}
				}      
			}
			//parameter 값이 문자형일 경우.
			else if (parameterValue instanceof String) {				
				String paramValue = (String) parameterValue;
				if (paramValue != null && paramValue.trim().length() > 0) {
					super.put(name, parameterValue);
				}
			}
		}
    }  
    /**
     * request.getParameterMap 으로 HashMap 생성후, VO Class 의 메서드 input 처리
     * @param map
     * @param obj
     */
    public DataMap(Map map, Object obj){
    	this(map);
    	setClassInit(obj);
    }

    /**
     * MultipartRequest 으로 HashMap 생성후, VO Class 의 메서드 input 처리
     * @param request
     * @param obj
     */
    public DataMap(MultipartRequest request, Object obj){
    	this(request);
    	setClassInit(obj);
    }
    
    /**
     * request 으로 HashMap 생성후, VO Class 의 메서드 input 처리
     * @param request
     * @param obj
     */
    public DataMap(HttpServletRequest request, Object obj){
    	this(request);
    	setClassInit(obj);
    }
    
    /**
     * 파라메타 VO Class 의 메서드값을 자동으로 input 처리
     * @param obj
     */
	public void setClassInit(Object obj){
		Class classObj = null;
		try{
			classObj = obj.getClass();
			Method[] methods = classObj.getDeclaredMethods();
			Class[] paramtypes = null;
			Method method = null;
			String sName = null;
			for(int i=0; i<methods.length; i++){
				//setter 메서드 인 경우.
				if(methods[i].getName().toLowerCase().indexOf("set") == 0
						&& !(sName = methods[i].getName().toLowerCase().substring(3)).equals("")
						&& super.containsKey(sName)){
					if((paramtypes = methods[i].getParameterTypes()) != null
							&& (method = classObj.getDeclaredMethod(methods[i].getName(), paramtypes)) != null){
						try{
							if(paramtypes[0].getName().equals("int") && !getNVLString(sName).equals("")){			//int type parameter
								method.invoke(obj, new Object[]{new Integer(getNVLString(sName))});
							}else if(paramtypes[0].getName().equals("float") && !getNVLString(sName).equals("")){			//float type parameter
								method.invoke(obj, new Object[]{new Float(getNVLString(sName))});
							}else if(paramtypes[0].getName().equals("double") && !getNVLString(sName).equals("")){			//double type parameter
								method.invoke(obj, new Object[]{new Double(getNVLString(sName))});
							}else if(paramtypes[0].getName().equals("long") && !getNVLString(sName).equals("")){			//long type parameter
								method.invoke(obj, new Object[]{new Long(getNVLString(sName))});
							}else if(paramtypes[0].getName().equals("boolean") && !getNVLString(sName).equals("")){			//boolean type parameter
								method.invoke(obj, new Object[]{new Boolean(getNVLString(sName))});
							}else if(paramtypes[0].getName().equals("java.lang.String") && !getNVLString(sName).equals("")){			//java.lang.String type parameter
								method.invoke(obj, new Object[]{getNVLString(sName)});
							}else{												//String type parameter
								try{
								method.invoke(obj, new Object[]{super.get(sName)});	
								}catch(Exception e){}
							}
						}catch(NumberFormatException ne){}
					}
				}
			}
		}catch(NoSuchMethodException nse){
			System.out.println("METHOD 를 찾을수 없습니다.");
			nse.printStackTrace();
		}catch(IllegalArgumentException arge){
			System.out.println("METHOD PARAMETER 값이 다릅니다.");
			arge.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
    public Object get(String name)
    {
        Object obj = super.get(name);
        return obj;
    }

    public void put(String name, int value)
    {
        super.put(name, new Integer(value));
    }

    public void put(String name, long value)
    {
        super.put(name, new Long(value));
    }

    public void put(String name, float value)
    {
        super.put(name, new Float(value));
    }

    public void put(String name, double value)
    {
        super.put(name, new Double(value));
    }

    public void put(String name, boolean value)
    {
        super.put(name, new Boolean(value));
    }
    
    public String getNVLString(String paramName)
    {
        String value = getString(paramName);
        if(value == null || value.trim().length() == 0)
            return "";
        else
            return value;
    }

    public int getNVLInteger(String paramName)
    {
    	String value = getString(paramName);
    	if(value == null || value.trim().length() == 0)
    		return 0;
    	else
    		return Integer.parseInt(value);
    }
    
    public String getParameter(String paramName){
	    String str = getString(paramName);
	    if(str == null || str.length() == 0)
	        return "";
	    else
	        return str;
	}
	
	public String getParameter(String paramName, String defaultValue)
	{
	    String str = getString(paramName);
	    if(str == null || str.length() == 0)
	        return defaultValue;
	    else
	        return str;
	}

    public String getNVLString(String paramName, String defaultValue)
    {
        String value = getString(paramName);
        if(value == null || value.trim().length() == 0)
            return defaultValue;
        else
            return value;
    }

    public String getString(String paramName)
    {
        Object obj = super.get(paramName);
        if(obj == null)
            return null;
        if((obj instanceof Collection) || (obj instanceof Object[])){
        	String[] str = (String[])obj;
        	return str[0];
        }else{
            return obj.toString();
        }
    }
    
    public String[] getParameterValues(String paramName)
    {
        String strArr[] = getStringArray(paramName);
        return strArr;
    }
    
    public String[] getStringArray(String paramName)
    {
        Object obj = super.get(paramName);
        String param = null;
        String params[] = (String[])null;
        if(obj instanceof String[])
            return (String[])obj;
        if(obj instanceof Collection)
            return null;
        if(obj instanceof Object[])
        {
            Object objArray[] = (Object[])obj;
            String array[] = new String[objArray.length];
            for(int i = 0; i < objArray.length; i++)
                try
                {
                    array[i] = objArray[i].toString();
                }
                catch(NullPointerException e)
                {
                    array[i] = "";
                }

            return array;
        }
        if(obj != null)
        {
            String array[] = new String[1];
            array[0] = obj.toString();
            return array;
        }
        param = getParameter(paramName, null);
        if(param == null)
        {            
            return null;
        } else {
            params = new String[1];
            params[0] = param;
            return params;
        }
    }
    
    /**
     * DataMap 에 담긴 map 정보를 input hidden 으로 돌려준다.
     * @return String
     */
    public String getParameterHiddenForm(){
    	StringBuffer sHidden = new StringBuffer();
    	try{
    		Iterator names = super.keySet().iterator();
    		String name;
    		Object parameterValue;
    		String[] paramValue;
    		String paramStrValue;
    		while (names.hasNext()) {
    			name = (String) names.next();
    			parameterValue = super.get(name);
    			//parameter 값이 배열일 경우.
    			if (parameterValue instanceof String[]) {
    				if ((paramValue = (String[]) parameterValue) != null 
    						&& paramValue.length >= 1) {
    					if(paramValue.length == 1 
    							&& (paramStrValue = paramValue[0]) != null){
    						sHidden.append("<input type='hidden' name='"+name+"' value='"+paramStrValue+"'/>\n");
    					}else{
    						//for(int i=0; i<paramValue.length; i++){
    						if(paramValue.length > 1) sHidden.append("<input type='hidden' name='"+name+"' value='"+paramValue[0]+"'/>\n");
    						//}
    					}
    				}
    			}
    			//parameter 값이 문자형일 경우.
    			else if (parameterValue instanceof String) {				
    				paramStrValue = (String) parameterValue;
    				if (paramStrValue != null && paramStrValue.trim().length() > 0) {
						sHidden.append("<input type='hidden' name='"+name+"' value='"+paramStrValue+"'/>\n");
    				}
    			}
    		}
    	}catch(Exception e){}
    	return sHidden.toString();    	
    }
    
    /**
     * DataMap 에서 호출 시, 형 변환
     * @param ob
     * @return String
     */
	public String objToString(Object ob){
		return String.valueOf(ob);
	}

	/**
	 * DataMap 에서 호출 시, 형 변환
	 * @param ob
	 * @return int
	 */
	public int objToInt(Object ob){
		return Integer.parseInt(String.valueOf(ob));
	}
}