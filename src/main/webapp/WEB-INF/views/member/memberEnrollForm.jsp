<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	#Enroll-Rule-Area{
		padding-top:5%;
		height:100%;
		width:100%;
	}
	#Enroll-Rule-Area>div{
		margin:auto;
		width:40%;
	}
	.enrollTitle{
		margin:auto;
		width:15%;
		border-bottom:1px solid lightgray;
		padding-bottom:15px;
	}
	.rule{
		height:25%;
	}
	.agreeAll>*{
		margin-top:30px;
		margin-left:10px;
		padding-bottom:15px;
	}
	div>textArea, .checkArea{
		margin-left:10%;
		width:80%;
	}
	.checkArea>input[type=radio]{
		margin-left:10px;
	}
	.rule label{
		margin-left:5px;
		margin-right:15px;
		margin-bottom:30px;
	}
	.rule>input{
		margin-left:10px;
	}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div id="Enroll-Rule-Area">
		<div class="enrollTitle">
			<h3 align="center">이용 약관</h3>
		</div>
		<div class="agreeAll">
		<input type="checkbox" id="allAgree"><label for="allAgree">전부 동의합니다.</label>
		</div>
		<div class="rule">
			<textArea readOnly cols="30" rows="6" style="resize:none;">
제 1 조 (목적) 
이 약관은 MUNGHUB(이하 "협회")가 제공하는 제반 서비스의 이용에 대한 회원의 권리와 의무, 기타 필요한 사항을 정함에 있습니다.

제 2 조 (정의) 
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
  ①"서비스"라 함은 구현되는 모든 통신매체에 대해 "회원"이 이용할 수 있는 협회의 제반서비스를 의미합니다.
  ②"회원"이라 함은 협회의 "서비스"에 대해 아이디와 비밀번호를 부여 받은 고객을 말합니다.
  ③"아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 구분을 위하여 "협회"가 승인하는 문자와 숫자의 조합을 의미합니다. 
  ④"비밀번호"라 함은 "회원"이 부여 받은 "아이디"에 자신이 정한 문자 또는 숫자의 조합을 의미합니다. 
  ⑤"유료서비스"라 함은 "협회"가 유료로 제공하는 각종 디지털 컨텐츠와 제반 서비스를 의미합니다. 
  ⑥"포인트(알)"라 함은 회원에게 부여되는 재산적 가치가 없는 가상의 마일리지를 의미합니다.
  ⑦"게시물"이라 함은 "회원"이 "협회"가 제공하는 "서비스"를 이용함에 있어 등록하는 부호, 문자, 음성, 음향, 동영상등을 의미합니다. 

제 3 조 (약관의 효력과 개정) 
  ①"협회"는 이 약관의 내용을 "회원"이 쉽게 알 수 있도록 서비스에 대한 사항을 공지를 합니다. 
  ②"협회"는 "약관의규제에관한법률", "정보통신망이용촉진및정보보호등에관한법률(이하 "정보통신망법")", 소비자보호법률 등 관련법을 위배하지 않는 범위내에서 이 약관을 개정할 수 있습니다. 
  ③"협회"가 약관을 개정할 경우에는 적용일자 및 변경 사유를 명시하여 현행약관과 함께 적용일자 30일 전부터 적용일자 전일까지를 공지하고 회원이 거부의사를 표시하지 않는 경우는 개정에 동의한 것으로 간주합니다. 
  ④회원은 약관의 변경에 대한 의무를 다하여야 하며 변경된 약관의 회원의 부지사항에 대해서는 협회는 책임을 지지 않으며 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 협회는 이용계약을 해지할 수 있습니다. 

제 4 조 (약관의 해석) 
    "협회"는 이 약관에 명시되지 않는 사항은 정보통신망 이용촉짐 및 ""유료서비스" 및 "협회"가 정한 서비스의 세부지침규정에 따릅니다. 

제 5 조 (이용계약 체결) 
  ①이용계약은 "회원"이 되고자 하는 자(이하 "가입신청자")가 약관의 내용에 대하여 동의를 한 다음 회원가입신청을 한 후 "협회"가 정한 신청양식에 작성한 후 "협회"가 이러한 신청에 대하여 승낙함으로써 체결됩니다. 
  ②"협회"는 "가입신청자"의 신청에 대하여 "서비스" 이용을 동의함을 원칙으로 합니다. 다만, "협회"는 타인의 명의를 도용하거나 허위 정보 기재, "협회"가 정한 필수 신청양식에 기재를 하지 않을 경우 이용계약을 해지할 수 있습니다.
  ③제1항에 따른 신청에 있어 "협회"는 "회원"의 종류에 따라 전문기관을 통한 실명확인 또는 본인인증을 요청할 수 있습니다.
  ④"협회"는 서비스관련설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다. 
  ⑤ "협회"는 "회원"에 대하여 "청소년보호법"등에 따른 등급 및 연령 준수를 위해 이용제한이나 등급별 제한을 할 수 있습니다. 
 
제 6 조 (회원정보의 변경) 
  회원은 언제든지 "서비스"를 이용하면서 신청양식에 기재한 정보가 변경될 경우 회원정보를 수정하여야 하며 회원정보를 수정하지 않아서 발생하는 모든 책임은 회원에게 있습니다. 
 
제 7 조 (개인정보보호 의무) 
  "협회"는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 "회원"의 개인정보를 보호하기 위해 노력합니다. "협회"의 공식 사이트 이외의 링크된 사이트에서는 "협회"의 개인정보취급방침이 적용되지 않습니다.
 
제 8 조 ("회원"의 "아이디" 및 "비밀번호"의 관리에 대한 의무) 
  ①"회원"의 "아이디"와 "비밀번호"에 관한 관리책임은 "회원"에게 있으며, 이를 제3자에게 노출하여서는 안됩니다.
  ②"협회"는 "회원"의 "아이디"가 개인정보 유출 우려가 있거나, 불법, 반사회적 또는 미풍양속에 어긋날 경우 해당 "아이디"의 이용을 제한할 수 있습니다. 
  ③ "회원"은 "아이디" 및 "비밀번호"가 도용되거나 제3자에게 노출되었을 경우에 이를 즉시 "협회"에 통지하고 "협회"의 안내에 따라야 합니다. 
  ④제3항의 경우에 해당 "회원"이 "협회"에 그 사실을 통지하지 않거나, 통지한 경우에도 "협회"의 안내에 따르지 않아 발생한 불이익에 대하여 "협회"는 책임지지 않습니다. 
 
제 9 조 ("회원"에 대한 공지) 
  "협회"가 "회원"에 대한 통지를 하는 경우 이 약관에 별도 규정이 없는 한 서비스 내 전자우편주소, 온라인쪽지, SMS 등으로 할 수 있습니다.  

제 10 조 ("협회"의 의무) 
  ①"협회"는 회원정보를 "회원"의 동의없이 제 3자에게 제공하지 않으며 협회의 서비스와 관련한 불만 사항이 접수되었을 경우에는 이를 신속하게 처리합니다.   
  ②"협회"는 회원정보를 보하하기 위해 노력하며 "개인정보취급방침"을 공지하고 준수합니다.

제 11 조 ("회원"의 의무) 
  ①"회원"은 약관, 서비스, 공지와 준수사항, "협회"가 공지하는 사항을 준수하며 "협회"의 업무를 방해하는 행위를 하여서는 안됩니다. 
  ②"회원"은 개인 아이디와 비밀번호를 철저히 관리하며 부정사용이나 불법적인 용도로 사용하여서는 안되며 이에 대한 모든 책임은 "회원"이 지게 됩니다. 

제 12 조 ("서비스"의 제공 등) 
  ①협회는 회원에게 아래와 같은 서비스를 제공합니다. 
   1."서비스"내 검색 서비스 
   2. 뉴스, 온라인쪽지, 지식온 서비스
   3. "협회"에서 제공하는 기타 컨텐츠 
   4. 기타 "협회"가 추가 개발하거나 다른 협회와의 제휴계약 등을 통해 "회원"에게 제공하는 일체의 서비스 
 
제 13 조 ("서비스"의 변경) 
  ①"협회"는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 서비스의 전부 또는 일부 "서비스"를 변경할 수 있습니다.
  ②"서비스"의 변경에 대해서는 변경 전 7일 이상 서비스 변경사항을 사이트내에서 공지합니다.
  ③"협회"는 무료로 제공되는 서비스의 일부 또는 전부를 협회의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 "회원"에게 별도의 보상을 하지 않습니다. 
 
제 14 조 (정보의 제공 및 광고의 게재) 
  ①"협회"는 "회원"이 "서비스" 이용 중 필요하다고 인정되는 정보를 "회원"에게 공지로 제공할 수 있으며 "회원"은 관련정보 와 공지에 관련 답변을 제외하고는 수신거부를 할 수 있습니다.
  ②제1항의 정보를 전화 및 모사전송기기에 의하여 전송하려고 하는 경우에는 "회원" 가입시 사전 동의를 받아서 발송합니다. 다만, "회원"의 거래관련 정보 및 고객문의 등에 대한 회신에 있어서는 제외됩니다. 
  ③"협회"는 "서비스"의 운영에 있어 서비스 화면과 홈페이지, 전자우편 등에 광고를 게시할 수 있으며 이를 수신한 "회원"은 수신거절을 "협회"에게 할 수 있습니다. 
 
제 15 조 ("게시물"의 저작권) 
  ①"회원"이 "서비스" 내에 게시한 "게시물"의 저작권은 해당 게시물의 저작자에게 귀속됩니다. 다만, "협회"에서 제공하는 포인트(알), 이벤트 등에 관해 그에 상응하는 포인트(알), 기타 대가를 지급한 게시물에 대해서는 저작권은 "협회"에 귀속됩니다. 단, 이러한 사항에 대해서는 "회원"에게 사전에 공지하여야 합니다.
  ②"회원"이 "서비스" 내에 게시하는 "게시물"은 검색결과 혹은 "서비스"의 제공을 위해 노출할 수 있으며 "회원"은 언제든지 고객센터 또는 "서비스" 내 관리기능을 통해 해당 게시물에 대해 삭제, 검색결과 제외, 비공개 등의 조치를 취할 수 있습니다. 
 
제 16 조 ("게시물"의 관리) 
  ①"회원"의 "게시물"이 "정보통신망법" 및 "저작권법"등 관련법에 위반되는 내용을 포함하는 경우, "협회"는 관련절차에 따라  "게시물"의 게시중단 및 삭제 요청을 할 수 있으며 "개인"은 이에 적극 협조를 하여야 합니다.
  ②"협회"는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해 또는 협회의 정책, 관련법에 위배될 경우 해당 "게시물"에 대해 임시조치 등을 취할 수 있습니다. 

제 17 조 (권리의 귀속) 
  ①"서비스"에 대한 저작권 및 지적재산권은 "협회"에 귀속되며  "회원"의 "게시물" 은 저작권법에 의해 보호를 받습니다.
  ②"협회"는 서비스와 관련하여 "회원"에게 "협회"가 정한 이용조건에 따라 콘텐츠, "포인트" 등을 이용하는 이용권만을 부여하며, "회원"은 이를 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다. 

제 18 조 (포인트(알)) 
"협회"는 서비스의 효율적 이용 및 운영을 위해 사전 공지 후 "포인트"의 일부 또는 전부를 조정할 수 있으며, "포인트"는 협회가 정한 기간에 따라 주기적으로 소멸할 수 있습니다. 
 
제 19 조 (계약해제, 해지 등) 
  ①"회원"은 언제든지 고객센터 및 "서비스"이용에 대한 계약 해지신청을 할 수 있으며, "협회"는 관련법 등이 정하는 바에 따라 이를 즉시 처리하여야 합니다. 
  ②"회원"이 계약을 해지할 경우, 관련법 및 개인정보취급방침에 따라 "협회"가 회원정보를 보유하는 경우를 제외하고는 해지 즉시 "회원"의 모든 데이터는 소멸됩니다. 
  ③"회원"이 계약을 해지하는 경우, "회원"이 작성한 "게시물" 은 삭제될 수 있습니다. 단지 타 "회원"의 스크랩, 공용게시물에 등록되었을 경우 등록된 "게시물" 등은 삭제되지 않으니 사전에 삭제 후 탈퇴하시기 바랍니다. 

제 20 조 (이용제한 등) 
  ①"협회"는 "회원"이 이 약관의 의무 위반 또는 "서비스"의 정상적인 운영을 방해한 경우 에는 일시정지, 영구이용정지 등으로 "서비스" 이용을 제한할 수 있습니다. 
  ②"협회"는 전항에도 불구하고, "주민등록법"을 위반한 명의도용 및 결제도용, "저작권법" 및 "컴퓨터프로그램보호법"을 위반한 불법프로그램의 제공 및 운영방해, "정보통신망법"을 위반한 불법통신 및 해킹, 악성프로그램의 배포, 접속권한 초과행위 등과 같이 관련법을 위반한 경우에는 즉시 영구이용정지를 할 수 있습니다. 본 항에 따른 영구이용정지 시 "서비스" 이용을 통해 획득한 "포인트" 및 기타 혜택 등도 모두 소멸되며, "협회"는 이에 대해 별도로 보상하지 않습니다. 
  ③"협회"는 "회원"이 계속해서 3개월 이상 "서비스를 이용하지 않는 경우 "서비스" 이용을 제한할 수 있습니다. 
  ④"회원"은 본 조에 따른 이용제한 등에 대해 "협회"가 정한 절차에 따라 이의신청을 할 수 있습니다. 이 때 이의가 정당하다고 "협회"가 인정하는 경우 "협회"는 즉시 "서비스"의 이용을 재개합니다. 

제 21 조 (책임제한) 
  ①"협회"는 천재지변 또는 이에 준하는 불가항력으로 인하여 "서비스"를 제공할 수 없을 경우에는 책임이 면제됩니다.  
  ②"협회"는 "회원"의 귀책사유로 인한 "서비스" 이용의 장애에 대하여는 책임을 지지 않습니다. 
  ③"협회"는 "회원"이 "서비스"와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다. 
  ④"협회"는 "회원" 간 또는 "회원"과 제3자 상호간에 "서비스"를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다. 
  ⑤"협회"는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다. 
 
제 22 조 (준거법 및 재판관할) 
①"협회"와 "회원" 간 제기된 소송은 대한민국법을 준거법으로 합니다. 
②"협회"와 "회원"간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다. 
 
부칙 
①이 약관은 2009년 4월 1일부터 적용됩니다. 
②개정된 이용약관의 적용일자 이전 가입자 또한 개정된 이용약관의 적용으로 대체합니다. 	
			</textArea><br>
			<div class="checkArea">
				<input type="radio" name="yakgwan1" id="Y" value="y"><label for="Y">동의합니다.</label>
				<input type="radio" name="yakgwan1" id="N" value="n"><label for="N">동의하지 않습니다.</label>
			</div>
		</div>
		<div class="rule">
			<textArea readOnly cols="30" rows="6" style="resize:none;">
MUNGHUB는 (이하 '협회'는) 고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다.

협회는 개인정보취급방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.

협회는 개인정보취급방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.
 

■ 수집하는 개인정보 항목
협회는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
ο 수집항목 :  이름 , 생년월일 , 로그인ID , 비밀번호 , 자택 전화번호 , 자택 주소 , 휴대전화번호 , 이메일 , 직업 , 취미 , 결혼여부 , 접속 로그 , 쿠키 , 접속 IP 정보
ο 개인정보 수집방법 : 홈페이지(회원가입, 게시판)  

■ 개인정보의 수집 및 이용목적
협회는 수집한 개인정보를 다음의 목적을 위해 활용합니다.
 ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산콘텐츠 제공
 ο 회원 관리
    회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 연령확인 , 불만처리 등 민원처리
 ο 마케팅 및 광고에 활용
    이벤트 등 광고성 정보 전달

■ 개인정보의 보유 및 이용기간
협회는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.

■ 개인정보의 파기절차 및 방법
협회는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
ο 파기절차
   회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.
   별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.
 ο 파기방법 
    -  DB에서 완전 삭제하는 방법으로 파기합니다. 

■ 개인정보 제공
협회는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
- 이용자들이 사전에 동의한 경우
- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우 

■ 수집한 개인정보의 위탁
협회는 고객님의 동의없이 고객님의 정보를 외부 업체에 위탁하지 않습니다. 향후 그러한 필요가 생길 경우, 위탁 대상자와 위탁 업무 내용에 대해 고객님에게 통지하고 필요한 경우 사전 동의를 받도록 하겠습니다.
- 기관명 : (주)이젠컴즈  
- 주소 : 경기도 성남시 분당구 삼평동 694 스타트업 캠퍼스 3동 409호
- 전화 : 070-4741-2090,2092
- 위탁내용: 홈페이지 유지/보수 및 관리 
 
■ 이용자 및 법정대리인의 권리와 그 행사방법
이용자 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다.
이용자 혹은 만 14세 미만 아동의 개인정보 조회?수정을 위해서는 ‘개인정보변경’(또는 ‘회원정보수정’ 등)을 가입해지(동의철회)를 위해서는 “회원탈퇴”를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다.
혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다.
귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이
이루어지도록 하겠습니다. oo는 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 “oo가 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.

■ 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
협회는 귀하의 정보를 수시로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 oo의 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다. 협회은(는) 다음과 같은 목적을 위해 쿠키를 사용합니다.

▶ 쿠키 등 사용 목적
 - 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공
   귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다. 

▶ 쿠키 설정 거부 방법
예: 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다. 

설정방법 예(인터넷 익스플로어의 경우)
: 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보

단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.


귀하께서는 협회의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. 협회는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.
정보주체는 개인정보의 수집·이용목적에 대한 동의를 거부할 수 있으며, 동의 거부시 애견협회 홈페이지에 회원가입이 되지 않으며, 애견협회 홈페이지에서 제공하는 서비스를 이용할 수 없습니다.
기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.

1.개인분쟁조정위원회 (www.1336.or.kr/1336)
2.정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4)
3.대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr/02-3480-3600)
4.경찰청 사이버테러대응센터 (www.ctrc.go.kr/02-392-0330)
			</textArea>
			<div class="checkArea">
				<input type="radio" name="yakgwan2" id="y" value="y"><label for="y">동의합니다.</label>
				<input type="radio" name="yakgwan2" id="n" value="n"><label for="n">동의하지 않습니다.</label>
			</div>
		</div>
		<div class="joinModalBtn">
			<button type="button" data-bs-toggle="modal" data-bs-target="#joinModal" disabled>반려견주(일반 회원)로 가입</button>	
			<button type="button" onclick="teacherCheck();" data-bs-toggle="modal" data-bs-target="#joinModal" disabled>반려견돌보미(반려견유치원 선생님)로 가입</button>
		</div>
	</div>
		<div class="snsJoin" hidden="true">
			<input type="checkbox" id="snsJoin" checked="${not empty snsJoin ? 'true':'false' }">
		</div>
	<script>
	/*  전부동의 누를 시 자동 동의 체크 
		다시 누르면 체크해제(반대로)
	
		동의 따로따로 체크할 시 자동으로 전부동의 체크<
		
		전부동의 체크 시 가입 버튼 활성화
	*/
	
		$(function(){
			$("#allAgree").on("click",function(){
			var agree = $("#allAgree").prop("checked");
				if(agree){
					$(".checkArea>input[value='y']").prop("checked",true);
				}else{
					$(".checkArea>input[value='n']").prop("checked",true);
				}
			})
		})
		$(function(){
			var btn=$(".joinModalBtn>button");
			$(".checkArea>input[type=radio]").on("click",function(){				
				var check=0;
				$(".checkArea>input[value='y']").each(function(){
					var tf=$(this).prop("checked");
					if(tf){
						check+=1;
					}else{
						check=0;
					}
				})
				if(check==2){
					$("#allAgree").prop("checked",true);
					btn.each(function(){
						$(this).attr("disabled",false)
					})
				}else{
					$("#allAgree").prop("checked",false);
					btn.each(function(){
						$(this).attr("disabled",true)
					})
				}
			})
		})
		$(function(){
			$("#allAgree").on("change",function(){
				var agree=$(this).prop("checked");	
				var btn=$(".joinModalBtn>button");
				if(agree){
					btn.each(function(){
						$(this).attr("disabled",false)
					})
				}else{
					btn.each(function(){
						$(this).attr("disabled",true)
					})
				}
			})
		})
		$(function(){
			if($("#snsJoin").prop("checked")){
				$(".member-data>#name").val("${snsJoin.name}");
				$(".member-data>#phone").val("${snsJoin.phone}");
				$(".member-data>#email").val("${snsJoin.email}");
			}
		})
		function teacherCheck(){
		$(".teacher-only").attr("hidden",false);
	}
	</script>
	
		<!-- 회원 가입 클릭시 사용될 모달영역 -->
	<div class="modal fade" id="joinModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원 가입</h4>
					<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
				</div>

				<!-- 회원 가입 요청 처리할 form태그 -->
				<form action="join.me" method="post">
					<!-- Modal body -->
					<div class="modal-body">
						<div class="member-data">
							<label for="userId">아이디 :</label>
							<input type="text" class="form-control mb-2 mr-sm-2" 
									placeholder="아이디를 입력하세요" id="userId" name="userId" required>
							<div class="idCheck"></div>		
							<label for="password">비밀번호 :</label>
							<input type="password" class="form-control mb-2 mr-sm-2" 
									placeholder="등록할 비밀번호를 입력하세요" id="password" name="password" required>
							<span>비밀번호는 6글자 이상 20자 미만으로, 영어, 숫자 및 특수문자를 반드시 포함하여 구성하셔야 합니다.</span>
							<div class="passwordRule"></div>
							<label for="checkPwd">비밀번호 확인 :</label>
							<input type="password" class="form-control mb-2 mr-sm-2" 
									placeholder="동일한 비밀번호를 입력하세요" id="checkPwd" name="checkPwd" required>
							<div class="passwordCheck">
							</div>
							<label for="name">이름 :</label>
							<input type="text" class="form-control mb-2 mr-sm-2" 
									placeholder="이름을 입력하세요" id="name" name="name" required>
							<label for="phone">전화번호 :</label>
							<input type="text" class="form-control mb-2 mr-sm-2" 
									placeholder="하이픈(-) 포함 공백없이 입력해 주시기 바랍니다." id="phone" name="phone" required>
							<label for="phone">이메일 :</label>
							<input type="email" class="form-control mb-2 mr-sm-2" 
									placeholder="" id="email" name="email" >
							<div class="teacher-only" hidden="true">
			                    <label for="kindName">소속 유치원 이름 : </label>
			                    <input type="text" id="kind" name="kind" placeholder="유치원 이름 검색"><button onclick="searchKind(); return false;">검색</button>
			                    <span class="kindList"></span>
							</div>
							<label for="address">주소 :</label>
							<input type="text" class="form-control mb-2 mr-sm-2" 
									placeholder="" id="address" name="address" >
							<label for="">반려견 유무 :</label>
							<div class="petStatus">
								<input type="radio" id="yesPet" value="Y" name="petYN">
								<label for="yesPet">있습니다.</label> &nbsp;&nbsp;
								<input type="radio" id="noPet" value="N" name="petYN">
								<label for="noPet">없습니다.</label> &nbsp;&nbsp;
							</div>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger" disabled>회원가입</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		var count=0;
		$(function(){
			var checkId = $("#userId");
			checkId.keyup(function(){
				$.ajax({
					url:"checkId.me",
					data:{
						userId: checkId.val()
					},
					success:function(result){
						console.log(result);

						if(result=="NNNNN"){//중복
							$(".idCheck").show();
							$(".idCheck").css("color","red").text("사용불가능한 아이디입니다.");
							
							//중복시 회원가입 버튼 비활성화
							$("button[type=submit]").attr("disabled",true);
						}else{ //사용가능
							$(".idCheck").show();
							$(".idCheck").css("color","green").text("사용가능한 아이디입니다.");

						}
						
					},
					error : function(){
						console.log("통신 오류");
					}
				})
			})
		})
		$(function(){
			var pwRule=$('.passwordRule');
			$('#password').keyup(function(){
				var regExp= new RegExp();
				var password=$(this).val();
				regExp=/^[a-zA-Z0-9!@#$%^&*]{6,20}$/;
                if(!regExp.test(password)){
                    pwRule.text("유효하지 않은 비밀번호입니다.").css('color','red')
                }else{
                    pwRule.text("유효한 비밀번호입니다.").css('color','green') 	
                }
			})
		})
	
		$(function(){
			$('#checkPwd').keyup(function(){
			    if($('#password').val() != $('#checkPwd').val()){
			        $('.passwordCheck').text('비밀번호 불일치').css('color', 'red')
			    }else{
			        $('.passwordCheck').text('비밀번호 일치').css('color', 'green')
                    if($(".idCheck").text()=="사용가능한 아이디입니다."){
						//사용가능시 회원가입 버튼 활성화
						$("button[type=submit]").attr("disabled",false);
                    }
			    }
			})
		})
		
		function searchKind(){
	        var kind="%";
	        	kind+=$("#kind").val();
	        	kind+="%";
	        console.log(kind);
	        var tr="<select name='kindName'>";       
	        $.ajax({
	            url : "selectKind.me",
	            data : {
	                kindName : kind
	            },
	            success : function(kList){
	                if(kList.length==0){
	                    $("#kind").val("");
	                }else{
	                    for(var i in kList){
	                        tr+="<option value='"
	                            +kList[i].kindNo+"'>"
	                            +kList[i].kindName
	                            +"</option>"
	                    }
	                    tr+="</select>";
	                
	                $(".kindList").html(tr);
	                }
	            },
	            error : function(){
	                console.log("오류난듯");     
	            }
	        })
	        return false;
	    }

	</script>
</body>
</html>