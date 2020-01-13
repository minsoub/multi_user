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

<div class="page-zone">
	<ul class="pagination">

		<!-- 이전 페이지  -->   
		<c:if test="${ firstPage > pageCnt }">
			<li class="first-page"><a onclick="javascript:goPage('1');"></a></li>
			<li class="prev-page"><a href="javascript:goPage('<c:out value="${ firstPage - 1 }"/>')" class="prev"></a></li>
		</c:if>
		<!-- 이전 페이지 끝 -->
							
				   
		<!-- 페이지 바디  -->   
		<c:forEach var="counter" begin="${firstPage}" end="${firstPage+pageCnt-1}" varStatus="status">    
			<c:if test="${ counter <= totPageCnt }">            
				<c:choose>                                       
					<c:when test="${counter == pageNo}">
						<c:if test="${counter != totPageCnt}">
							<c:if test="${counter == pageCnt}">
								<li class="active"><a href="# return false;"><c:out value="${counter}"/></a></li>
							</c:if>
							<c:if test="${counter != pageCnt}">
								<li class="active"><a href="# return false;"><c:out value="${counter}"/></a></li>
							</c:if>
						</c:if>	
						<c:if test="${counter == totPageCnt}">
							<li class="active"><a href="# return false;"><c:out value="${counter}"/></a></li>
						</c:if>
					</c:when>                          
					<c:when test="${counter != pageNo}"> 
						<c:if test="${counter != totPageCnt}">
							<c:if test="${counter == pageCnt}">
								<li><a href="javascript:goPage('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a></li>
							</c:if>
							<c:if test="${counter != pageCnt}">
								<li><a href="javascript:goPage('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a></li>
							</c:if>
						</c:if>	
						<c:if test="${counter == totPageCnt}">
							<li><a href="javascript:goPage('<c:out value="${counter}"/>')"><c:out value="${counter}"/></a></li>
						</c:if>
					</c:when>
				</c:choose>        
			</c:if>
		</c:forEach>
		<!-- 페이지 바디 끝 -->
				  
				  
		<!-- 다음  페이지  -->   
		<c:if test="${ firstPage+pageCnt-1 < totPageCnt  }">
			<li class="next-page"><a href="javascript:goPage('<c:out value="${ firstPage + pageCnt }"/>')"></a></li>
			<li class="last-page"><a onclick="javascript:goPage('${totPageCnt}');"></a></li>
		</c:if>
		<!-- 다음 페이지 끝 -->
	</ul>
</div>