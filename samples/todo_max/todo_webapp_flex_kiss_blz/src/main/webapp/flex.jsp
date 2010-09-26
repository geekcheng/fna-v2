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
        <title>Todo ${buildNumber}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <style type="text/css" media="screen">
        <!--
        /**
            html, body, #${application}_div { height: 100%; }
            html { overflow: hidden; }
        */
        html, body { width: 100%; height: 100%; text-align: center; background-color: #0c1624; }
        #${application}_div { overflow: auto; }
        body { margin: 0; padding: 0; }
        -->
        </style>
        <link rel="stylesheet" type="text/css" href="${ctx}/history/history.css"/>
        <script type="text/javascript" src="${ctx}/swfobject.js"></script>
        <script type="text/javascript" src="${ctx}/history/history.js"></script>
        <script type="text/javascript" src="${ctx}/popuputil.js"></script>
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
                allowFullScreen: "true",
                wmode: "opaque" // wmode=opaque cf. http://code.google.com/p/flex-iframe/wiki/FAQ
            };

            var attributes = {
                id: "${application}",
                name: "${application}"
            };

            var timer;

            /**
            * Returns the prefered size of the SWF object depending on the browser window dimensions
            */
            function getPreferedSize() {
                var viewWidth;
                var viewHeight;
                var scrollMargin = 18;
                var minWidth = 1200;
                var minHeight = 600;

                // get inner size
                if ( window['innerWidth'] != null ) {
                    viewWidth = parseInt( window.innerWidth ) - scrollMargin;
                    viewHeight = parseInt( window.innerHeight );
                }
                else if ( document['documentElement'] != null && document['documentElement']['clientWidth'] != null ) {
                    viewWidth = parseInt( document.documentElement.clientWidth ) - scrollMargin;
                    viewHeight = parseInt( document.documentElement.clientHeight );
                }
                else {
                    viewWidth = parseInt( document.getElementsByTagName('body')[0].clientWidth ) - scrollMargin;
                    viewHeight = parseInt( document.getElementsByTagName('body')[0].clientHeight );
                }

                // compare sizes
                if ( viewWidth < minWidth ) {
                    viewWidth = minWidth;
                }
                if ( viewHeight < minHeight ) {
                    viewHeight = minHeight;
                }

                returned = new Object();
                returned['width'] = viewWidth;
                returned['height'] = viewHeight;

                return returned;
            }

            /**
            * Handler for the resize window event,
            * it will calculate the prefered size for the SWF object and set them accordingly
            */
            function resizeSwfObject() {
                var obj = swfobject.getObjectById("${application}");
                if ( obj ) {
                    obj.width = getPreferedSize().width;
                    obj.height = getPreferedSize().height;
                }
            }

            /**
            * Handler for the load body event,
            * it will try to set the window's focus on the SWF object
            */
            function grabFocus() {
                var obj = swfobject.getObjectById("${application}");
                if ( obj ) {
                    obj.focus();
                } else {
                    timer = setInterval("delayedGrabFocus()", 1000);
                }
            }

            /**
            * Helper function to set the focus on the SWF object if the previous handler failed.
            * On some browsers (MS IE) the insertion of the object in the document's DOM
            * is done after the document is completely loaded
            */
            function delayedGrabFocus() {
                var obj = swfobject.getObjectById("${application}");
                if ( obj ) {
                    obj.focus();
                    clearInterval(timer);
                }
            }
<%
            String buildNumber = "ide-build: " + new java.util.Date().toString();
            if (null!=application.getResourceAsStream("/META-INF/MANIFEST.MF"))
            {
                java.util.jar.Manifest manifest = new java.util.jar.Manifest(application.
                    getResourceAsStream("/META-INF/MANIFEST.MF"));
                buildNumber = manifest.getMainAttributes().getValue("Build-Scm-Tag");
                if (buildNumber == null || "null".equals(buildNumber))
                {
                    buildNumber = manifest.getMainAttributes().getValue("Hudson-Build-Number");
                }
            }
           
%>
            <%-- The dc parameter is a discriminator required to force the main application swf file download
                 (avoiding the browser's cache). During development on local machines the buildNumber will be
                 null and this will result in no swf caching at all. During production, the buildNumber will
                 not be null and this will result in swf caching only per application release. --%>
            var dc = <%=(buildNumber != null && !"null".equals(buildNumber)) ? ("'" + buildNumber + "'") : "Math.random()"%>;

            swfobject.embedSWF("${ctx}/bin/${swf}.swf?dc=" + dc, "${application}_div", getPreferedSize().width, getPreferedSize().height, "${version_major}", "expressInstall.swf", flashvars, params, attributes);
            swfobject.addLoadEvent(loadEventHandler);
            function loadEventHandler() {
                var obj = swfobject.getObjectById("${application}");
                if ( obj ) {
                    BrowserHistory.flexApplication = obj;
                }
            }

            /* Returns a XmlHttpRequest object if the browser supports it or null if not. */
            function getXmlHttpRequest() {
                try {
                    if (window.XMLHttpRequest) {
                        // Firefox
                        return new window.XMLHttpRequest;
                    } else {
                        // IE
                        return new ActiveXObject("Microsoft.XMLHTTP");
                    }
                } catch (e) {
                    return null;
                }
            }

            /* Initialize the request outside the onBeforeUnload handler
               in order to minimize the handler's execution time. */
            var onBeforeUnloadReqest = getXmlHttpRequest();

            /* The onBeforeUnload event handler.
               If the browser supports XmlHttpRequest objects then the logout.jsp is called asynchronously
               else the browser displays a message to the user if the user hasn't logged out of the Flex application. */
            function onBeforeUnloadHandler() {
                if (onBeforeUnloadReqest != null) {
                    /* The dc parameter is a random discriminator required
                       to avoid IE's asynchroneous request caching mechanisms. */
                    var url = "./logout.jsp?dc=" + Math.random();

                    onBeforeUnloadReqest.open("GET", url, false);
                    onBeforeUnloadReqest.send();
                } else {
                    // TODO: Wrap the below return with an "if( swfObject.isUserLoggedIn() )"
                    return "Please make sure that you have logged out of the application before navigating away.";
                }
            }

            // Bind the event handler
            // TODO rework that : window.onbeforeunload = onBeforeUnloadHandler;
        </script>
    </head>
    <body onresize="resizeSwfObject()" onload="grabFocus()">
        <div id="${application}_div">
            <p>Alternative content</p>
        </div>
    </body>
</html>
