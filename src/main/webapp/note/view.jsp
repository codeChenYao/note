<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-md-9">
    <div class="data_list">
        <div class="data_list_title">
            <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;
            <c:if test="${empty noteInfo}">
                发布云记
            </c:if>
            <c:if test="${!empty noteInfo}">
                修改云记
            </c:if>
        </div>
        <div class="container-fluid">
            <div class="container-fluid">
                <div class="row" style="padding-top: 20px;">
                    <div class="col-md-12">
                        <c:if test="${empty typeList}">
                            <h3>暂未查询到云记类型！</h3>
                            <a href="type?actionName=list">添加</a>
                        </c:if>
                        <c:if test="${!empty typeList}">
                        <form class="form-horizontal" method="post" action="note">
                                <%-- 设置隐藏域：用来存放用户行为actionName --%>
                            <input type="hidden" name="actionName" value="addOrUpdate">
                            <input type="hidden" name="noteId" value="${noteInfo.noteId}">

                             <%--设置隐藏域：用来存放用户发布云记时所在地区的经纬度--%>
                                <%--经度--%>
                                 <input type="hidden" id="lon" name="lon">
                                <%--纬度--%>
                                 <input type="hidden" id="lat" name="lat">
                            <div class="form-group">
                                <label for="typeId" class="col-sm-2 control-label">类别:</label>
                                <div class="col-sm-8">
                                    <select id="typeId" class="form-control" name="typeId">
                                        <option value="">请选择云记类别...</option>
                                        <c:forEach var="item" items="${typeList}">
                                            <c:choose>
                                                <c:when test="${!empty resultInfo}">
                                                    <option  <c:if test="${resultInfo.result.typeId == item.typeId}">selected</c:if> value="${item.typeId}">${item.typeName}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option  <c:if test="${noteInfo.typeId == item.typeId}">selected</c:if> value="${item.typeId}">${item.typeName}</option>
                                                </c:otherwise>
                                            </c:choose>

                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="title" class="col-sm-2 control-label">标题:</label>
                                <div class="col-sm-8">
                                    <c:choose>
                                        <c:when test="${!empty resultInfo}">
                                            <input class="form-control" name="title" id="title" placeholder="云记标题" value="${resultInfo.result.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <input class="form-control" name="title" id="title" placeholder="云记标题" value="${noteInfo.title}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="title" class="col-sm-2 control-label">内容:</label>
                                <div class="col-sm-8">
                                    <c:choose>
                                        <c:when test="${!empty resultInfo}">
                                            <%-- 准备容器，加载富文本编辑器 --%>
                                            <textarea id="content" name="content">${resultInfo.result.content}</textarea>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- 准备容器，加载富文本编辑器 --%>
                                            <textarea id="content" name="content">${noteInfo.content}</textarea>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">

                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-5 col-sm-4">
                                    <input type="submit" class="btn btn-primary" onclick="return checkForm();" value="保存">
                                    <span id="msg" style="font-size: 12px;color: red">${resultInfo.msg}</span>
                                </div>
                            </div>
                        </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
       /* $(function(){
                //UE.getEditor('noteEditor');
                var editor = new UE.ui.Editor({initialFrameHeight:'100%',initialFrameWidth:'100%'});
                editor.render("noteEditor");
            }
        );
        //验证
        function saveNote(){
            //验证非空

            return true;
        }*/
       var ue
    $(function (){
        ue = UE.getEditor("content");
    })

   function checkForm() {
       // 1.获取表达元素的值
       //获取下拉框的值
       var typeId = $("#typeId").val();
       //获取文本框的值
       var title = $("#title").val();
       //获取富文本编辑器的内容
       var content = ue.getContent();

       //2.参数的非空判断
       if (isEmpty(typeId)) {
           $("#msg").html("请选择云记类型！");
            return false;
       }
       if (isEmpty(title)) {
           $("#msg").html("云记标题不能为空！");
           return false;
       }
       if (isEmpty(content)) {
           $("#msg").html("云记内容不能为空！");
           return false;
       }
       return true;
   }
    </script>
    <%-- 引用百度地图API文件，需要申请百度地图对应ak密钥--%>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yrxymYTyuefnxNtXbZcMU8phABXtu6TG"></script>
    <script type="text/javascript">
        /* 百度地图回去当前地址位置的经纬度 */
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function (r){
            // 判断是否获取到
            if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                console.log("您的位置：" + r.point.lng + "，" + r.point.lat);
                // 将获取到的坐标设置给隐藏域
                $("#lon").val(r.point.lng);
                $("#lat").val(r.point.lat);
            } else {
                console.log("failed:" + thi.getStatus());
            }
        });
    </script>
</div>
</div>