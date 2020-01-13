<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageNo" value="${paging.pageNo}"/>
<c:set var="perPageCnt" value="${paging.perPageCnt}"/>
<c:set var="pageCnt" value="${paging.pageRange}"/>
<c:set var="totCount" value="${totalCnt/perPageCnt}"/>
<c:set var="totPageCnt"><fmt:formatNumber value="${totCount+(1-(totCount%1))%1}" pattern="##########"></fmt:formatNumber></c:set>
<c:set var="firstCount"><fmt:formatNumber value="${(pageNo-1 )/pageCnt - ((pageNo-1 )/pageCnt%1)}" pattern="##########"></fmt:formatNumber></c:set>
<c:set var="firstPage">${(firstCount * pageCnt)+1}</c:set>

<div class="pageNate">
	<!-- 이전 페이지  -->   
	<c:if test="${ firstPage > pageCnt }">
		<a class="start" onclick="javascript:goPage2('<c:out value="1"/>');"></a>
		<a href="javascript:goPage2('<c:out value="${ firstPage - 1 }"/>')" class="prev"></a>
	</c:if>
	<!-- 이전 페이지 끝 -->
						
			   
	<!-- 페이지 바디  -->   
	<c:forEach var="counter" begin="${firstPage}" end="${firstPage+pageCnt-1}" varStatus="status">    
		<c:if test="${ counter <= totPageCnt }">            
			<c:choose>                                       
				<c:when test="${counter == pageNo}">
					<c:if test="${counter != totPageCnt}">
						<c:if test="${counter == pageCnt}">
							<a class="selected" href="# return false;"><c:out value="${counter}"/></a>
						</c:if>
						<c:if test="${counter != pageCnt}">
							<a class="selected" href="# return false;"><c:out value="${counter}"/></a>
						</c:if>
					</c:if>	
					<c:if test="${counter == totPageCnt}">
						<a class="selected" href="# return false;"><c:out value="${counter}"/></a>
					</c:if>
				</c:when>                          
				<c:when test="${counter != pageNo}"> 
					<c:if test="${counter != totPageCnt}">
						<c:if test="${counter == pageCnt}">
							<a href="javascript:goPage2('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a>
						</c:if>
						<c:if test="${counter != pageCnt}">
							<a href="javascript:goPage2('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a>
						</c:if>
					</c:if>	
					<c:if test="${counter == totPageCnt}">
							<a href="javascript:goPage2('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a>
					</c:if>
				</c:when>
			</c:choose>        
		</c:if>
	</c:forEach>
	<!-- 페이지 바디 끝 -->
			  
			  
	<!-- 다음  페이지  -->   
	<c:if test="${ firstPage+pageCnt-1 < totPageCnt  }">
		<a class="next" href="javascript:goPage2('<c:out value="${ firstPage + pageCnt }"/>')"></a>
		<a class="end" onclick="javascript:goPage2('<c:out value="${totPageCnt}"/>')"></a>
	</c:if>
	<!-- 다음 페이지 끝 -->
</div>