<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../includes/header.jsp"/>
<style>

</style>

<div class="col-lg-9">

    <div class="row">
        <div class="col-lg-12">
            <br>
            <h1 class="page-header">자유게시판</h1>
            <br>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <%--                            table table-striped table-bordered table-hover--%>
                    <%--                            dataTables-example--%>
                    <table width="100%" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>수정일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%--                                --%>
                        <c:forEach items="${list}" var="board">
                            <tr>
                                <td><c:out value="${board.b_no}"/></td>
                                    <%--                                            /board/get?bno=<c:out value="${board.bno}"/> --%>
                                <td><a id="detailPage" class="move" href="${board.b_no}">
                                    <c:out value="${board.b_title}"/>
                                    <c:if test="${board.replyCnt !=0}">[ ${board.replyCnt} ]</c:if>
                                </a>
                                </td>

                                <td><c:out value="${board.id}"/></td>
                                <td><fmt:formatDate value="${board.b_regTime}" pattern="yyyy-MM-dd"/></td>
                                <td><fmt:formatDate value="${board.b_updateTime}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${!empty vo.id}">
                        <button type="button" class="btn btn-dark" onclick="regloc()">글작성</button>
                    </c:if>

                    <div class="row">
                        <div class="col-lg-12">
                            <form id="searchForm" action="/board/freeboard/list" method="get" style="float: right">
                                <select name="type">
                                    <option value="" <c:out value="${pageMaker.cri.type == null ?'selected' : ''}"/> >
                                        --
                                    </option>
                                    <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ?'selected' : ''}"/>>
                                        제목
                                    </option>
                                    <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ?'selected' : ''}"/>>
                                        내용
                                    </option>
                                    <option value="C" <c:out value="${pageMaker.cri.type eq 'W' ?'selected' : ''}"/>>
                                        작성자
                                    </option>
                                    <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ?'selected' : ''}"/>>
                                        제목 내용
                                    </option>
                                    <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ?'selected' : ''}"/>>
                                        제목 작성자
                                    </option>
                                    <option value="TWC" <c:out
                                            value="${pageMaker.cri.type eq 'TWC' ?'selected' : ''}"/>>제목 내용 작성자
                                    </option>
                                </select>
                                <input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
                                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                <button class="btn btn-dark">검색</button>
                            </form>
                        </div>

                        <form id="actionForm" action="/board/freeboard/list" method="get">
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                            <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                        </form>
                    </div>

                    <div class="pull-right">
                        <ul class="lpagination" id="page_btn">
                            <c:if test="${pageMaker.prev}">
                                <li class="paginate_button previous"><a href="${pageMaker.realStart}"
                                                                        style="padding: 6px 12px">◀◀</a></li>
                            </c:if>
                            <c:if test="${pageMaker.prev}">
                                <li class="paginate_button previous"><a href="${pageMaker.startPage -10}"
                                                                        style="padding: 6px 12px">◀</a></li>
                            </c:if>
                            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                <%--                                            ${pageMaker.cri.pageNum = num ? "active":""}--%>
                                <%--                                        ${pageMaker.cri.pageNum == num ? "active" : ""}--%>
                                <%--                                            /board/list?pageNum=${num}--%>
                                <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
                                    <a href="${num}" style="padding: 6px 12px">${num}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <li class="paginate_button next">
                                    <a href="${pageMaker.endPage +1}" style="padding: 6px 12px">▶</a>
                                </li>
                            </c:if>
                            <c:if test="${pageMaker.next}">
                                <li class="paginate_button next">
                                    <a href="${pageMaker.realEnd}" style="padding: 6px 12px">▶▶</a>
                                </li>
                            </c:if>
                        </ul>
                        <%----%>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">글작성 </h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> x
                                    </button>
                                </div>
                                <div class="modal-body">
                                    처리가 완료되었습니다
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->

</div>
<script type="text/javascript">
    function regloc() {
        location.href = "/board/freeboard/register";
    }

    $(document).ready(function () {
        var result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {
            // 히스토리 로그출력
            console.log(history.state);
            if (result === '' || history.state) {
                return;
            }
            if (parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다");
            }

            $("#myModal").modal("show");
        }

        var actionForm = $("#actionForm");
        var searchForm = $("#searchForm");

        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();

            console.log("click");

            searchForm.find("input[name='pageNum']").val($(this).attr("href"));
            searchForm.submit();
        });

        $("a#detailPage").on("click", function (e) {
            e.preventDefault();
            console.log("글클릭");
            actionForm.attr("action", "/board/freeboard/get");

            actionForm.append("<input type='hidden' name='b_no' value='" + $(this).attr("href") + "'>");
            actionForm.submit();
        });

        $("#searchForm button").on("click", function (e) {

            if (!searchForm.find("option:selected").val()) {
                alert("검색종류를 선택하세요");
                return false;
            }
            if (!searchForm.find("input[name='keyword']").val()) {
                alert("키워드를 입력하세요");
                return false;
            }
            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();
            searchForm.submit();
        })

        // $(".move").on("click",function (e) {
        //     e.preventDefault();
        //     actionForm.append("<input type='hidden' name='b_no' value="+$(this).attr("href")+">");
        //     actionForm.attr("action","/board/freeboard/get");
        //     actionForm.submit();
        // })
    });
</script>

</div>
<!-- /.col-lg-9 -->

</div>
<!-- /.row -->

</div>
<!-- /.container -->
<%--<jsp:include page="../includes/footer.jsp"/>--%>
<script src="${pageContext.request.contextPath}/resourcesKIM/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resourcesKIM/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>