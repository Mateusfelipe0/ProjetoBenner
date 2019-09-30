<%@ Control Language="C#" %>
<%@ Import Namespace="Benner.Tecnologia.Common" %>

<link rel="manifest" href="<%=ResolveClientUrl("~/manifest.json")%>">
<meta content="width=device-width, initial-scale=1" name="viewport" />

<link rel="icon" href="<%=ResolveClientUrl(BennerConfiguration.CustomArtifacts.GetLatestArtifactName(CustomArtifactsType.Favicon))%>" type="image/x-icon" />
<link rel="shortcut icon" href="<%=ResolveClientUrl(BennerConfiguration.CustomArtifacts.GetLatestArtifactName(CustomArtifactsType.Favicon))%>"/>

<!-- Add to home screen for Safari on iOS -->
<link rel="apple-touch-icon" href="<%=ResolveClientUrl("~/content/img/touch-icon.png")%>" />
<meta name="apple-mobile-web-app-title" content="Web Enterprise Suite">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="apple-touch-icon" sizes="60x60" href="<%=ResolveClientUrl("~/content/img/touch-icon-60.png")%>">
<link rel="apple-touch-icon" sizes="76x76" href="<%=ResolveClientUrl("~/content/img/touch-icon-76.png")%>">
<link rel="apple-touch-icon" sizes="120x120" href="<%=ResolveClientUrl("~/content/img/touch-icon-120.png")%>">
<link rel="apple-touch-icon" sizes="152x152" href="<%=ResolveClientUrl("~/content/img/touch-icon-152.png")%>">
<link rel="apple-touch-icon" sizes="167x167" href="<%=ResolveClientUrl("~/content/img/touch-icon-167.png")%>">
<link rel="apple-touch-icon" sizes="180x180" href="<%=ResolveClientUrl("~/content/img/touch-icon-180.png")%>">