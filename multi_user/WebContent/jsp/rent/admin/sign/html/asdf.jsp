
<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
대여 신청 내역
	<br>
	<br>
	<br> 신청인 : ${view.appss} ${view.appenm } 님
	<br>
	<br> 사용인 : ${view.appuenm } 님
	<br>
	<br> 신청정보
	<br>○ 장비 목록
	<c:forEach var="list" items="${modelList }" varStatus="sts">
		<td>
			<div>${list.gbnm }</div>
		</td>
		<td class="like-td">
			<div>
				<c:choose>
					<c:when test="${view.status eq '1' && view.status eq '3' }">
						<span class="mdnm"
							style="text-decoration: underline; color: #0000ff; cursor: pointer;"
							data-gbcd="${list.gbcd}" data-mdseq="${list.mdseq }"
							data-amount="${list.amount }"> ${list.mdnm } </span>
					</c:when>
					<c:otherwise>
						<span>${list.mdnm }</span>
					</c:otherwise>
				</c:choose>
			</div>
		</td>
		<td class="like-td">
			<div>
				<c:out value="${list.amount} / ${list.assignedAmount}" />
			</div>
		</td>
		<td>
			<div>
				<c:forEach var="asMap" items="${assignedMap }" varStatus="vsts">
					<c:if test="${vsts.index eq sts.index }">
						<c:forEach var="v" items="${asMap.value }" varStatus="vsts">
                                                                         ${v.eqnm }
                                                                         <br>
                                                                         ${v.eqalias}
                                                                     </c:forEach>
					</c:if>
				</c:forEach>
			</div>
		</td>
	</c:forEach>
	<br>
	<br>
	○ 대여기간 :
	<fmt:parseDate value="${view.strdt}" var="parseStrdt"
		pattern="yyyyMMdd" />
	<fmt:parseDate value="${view.enddt}" var="parseEnddt"
		pattern="yyyyMMdd" />
	<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
	~
	<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" />

	<c:if test="${view.status eq '3' && view.approval eq '2'}">
		<dl class="insert_ready">
			<dt class="must-option">
				<label>인수자</label>
			</dt>
			<dd class="btn-zone" style="width: 200px;">
				<input type="text" class="schword" id="insunm" name="insunm"
					style="width: 50%"> <input
					type="button" style="cursor: pointer; height: 27px;"
					class="search_btn schbtn" value="검색">
			</dd>
			<dt class="must-option">
				<label>인수일</label>
			</dt>
			<dd style="width: 250px;">
				<div>
					<input type="text" id="insudt" name="insudt"
						readonly="readonly" />
				</div>
			</dd>
		</dl>
	</c:if>



	<c:if test="${view.status eq '4' && view.approval eq '2'}">
		<dl class="insert_ready">
			<dt class="must-option">
				<label>반납자</label>
			</dt>
			<dd class="btn-zone" style="width: 200px;">
				<input type="text" class="schword" id="banpnm" name="banpnm" style="width: 50%"> 
			</dd>
			<dt class="must-option">
				<label>반납일</label>
			</dt>
			<dd style="width: 250px;">
				<div>
					<input type="text" id="banpdt" name="banpdt" readonly="readonly" />
				</div>
			</dd>
		</dl>
		<dl class="insert_ready">
			<dt class="must-option">
				<label>반납처리</label>
			</dt>
			<dd>
				<input type="text" id="banpst" name="banpst" readonly="readonly" />
			</dd>
		</dl>
	</c:if>

	<dl class="insert_ready" id="etc_comment_div" style="display: none;">
		<dt class="must-option">
			<label for="SM_TEXT" id="SM_TEXT_label">특이사항</label>
		</dt>
		<dd>
			<textarea class="textarea-style" rows="10" cols="88" id="etc_comment" name="etc_comment" style="width: 618px;"></textarea>
		</dd>
	</dl>

	<div><img id="sign_img_data_complete" width="200px;" height="100px;" style="display: none;"></div>

</div>

	<div id="process_btn1">
		<a href="javascript:;" onclick="javascript:funShowSign();" style="font-size:100px;">다음</a><br><br>
		<a href="javascript:;" onclick="javascript:funCancelRent();" style="font-size:100px;">취소</a>
	</div>
	<div id="process_btn2" style="display: none;">
		<a href="javascript:;" onclick="javascript:funPrint();" style="font-size:100px;">인쇄</a><br><br>
		<a href="javascript:;" onclick="javascript:funSuccess();" style="font-size:100px;">완료</a><br><br>
	</div>
</div>
<div id="sign_input_div" style="display: none;">
<div style="float: left;">Sign</div>
<div id="signature" style="border:2px solid #4d6aa6;margin-left: 8%;" onmousedown="$('#sign_comment').hide();"><div id="sign_comment" style="font-size: 50px;">서명 후 하단의 확인 버튼을 터치 하세요.</div></div>
<a href="javascript:;" onclick="javascript:sendSignImgData();" style="text-align: right;font-size: 100px;">확인</a>&nbsp;&nbsp;&nbsp;
<a href="javascript:;" onclick="javascript:funResetSign();" style="text-align: right;font-size: 100px;">다시 입력</a>&nbsp;&nbsp;&nbsp;
<a href="javascript:;" onclick="javascript:funCancelRent();" style="text-align: right;font-size: 100px;">취소</a>
</div>

<div id="success_comment" style="display: none;" style="font-size:100px;">정상 처리 되었습니다. 안녕히 가십시요.</div>




















       
