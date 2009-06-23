<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="application" value="${not empty application ? application : fn:substring(ctx, 1, -1)}"/>
<c:set var="swf" value="${not empty swf ? swf : 'Main'}"/>
<c:set var="width" value="${not empty width ? width : '100%'}"/>
<c:set var="height" value="${not empty height ? height : '100%'}"/>
<c:set var="version_major" value="9.0.28"/>
<c:url var="endpoint" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${ctx}/messagebroker/amf"/>
<%-- see: http://olegflex.blogspot.com/2008/06/swfobject-2-flex-template.html --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>${application}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <style type="text/css" media="screen">
        <!--
            html, body, #${application}_div { height: 100%; }
            html { overflow: hidden; }
            body { margin: 0; padding: 0; }
        -->
        </style>
        <link rel="stylesheet" type="text/css" href="${ctx}/history/history.css"/>
        <script type="text/javascript" src="${ctx}/swfobject.js"></script>
        <script type="text/javascript" src="${ctx}/history/history.js"></script>
        <script type="text/javascript">
            var flashvars = {
                endpoint: "${fn:escapeXml(endpoint)}",
                // these next flashvars are used only by functionalTests
                targetSwf: "${targetSwf}.swf",
                testSwf: "${testSwf}.swf",
                autoStart: "${autoStartTests}"
            };
            var params = {
                menu: "false",
                scale: "noScale",
                allowScriptAccess:"sameDomain",
                allowFullScreen: "true"
            };
            var attributes = {
                id: "${application}",
                name: "${application}"
            };
            

            swfobject.embedSWF("${ctx}/bin/${swf}.swf", "${application}_div", "${width}", "${height}", "${version_major}", "expressInstall.swf", flashvars, params, attributes);
            swfobject.addLoadEvent(loadEventHandler);
            function loadEventHandler() {
                BrowserHistory.flexApplication = swfobject.getObjectById("${application}");
            }
        </script>
    </head>
    <!-- TODO somehow this stuff is not working now we have the swf in swfobject-->
    <body>
        <div id="${application}_div">
            <p>Alternative content</p>
        </div>
    </body>
</html>