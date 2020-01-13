package kr.co.neodreams.multi_user.common.xss;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
 
public class CrossScriptingFilter implements Filter {
 
	private String encoding;
    protected FilterConfig filterConfig;
    
    public void init(FilterConfig filterConfig) throws ServletException {
    	this.filterConfig = filterConfig;
        /** xml 에서 설정한 encoding 값이 된다 */
        this.encoding = filterConfig.getInitParameter("encoding");
    }
 
    public void destroy() {
    	this.encoding = null;
        this.filterConfig = null;
    }
 
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
 
    	if (request.getCharacterEncoding() == null){
            if (encoding != null){
                request.setCharacterEncoding(encoding);
            }
        }
    	
    	//sign 완료 html을 이미지로 떨궈야 되는데 xss 문제가 있음. 해당 url 예외처리 추가. 2017.02.17 
    	String url = ((HttpServletRequest)request).getRequestURI();
		
		if(url.indexOf("/admin/saveImgSendMail.do") != -1){
			chain.doFilter(request, response);
		}else{
			chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
		}
    }
    
    public FilterConfig getFilterConfig(){
        return filterConfig;
    }
     
    public void setFilterConfig(FilterConfig cfg){
        filterConfig = cfg;
    }
}
