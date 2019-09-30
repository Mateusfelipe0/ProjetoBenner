<%@ Page Title="Editor de layout" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EditReportHtmlPage" %>
<%@ Register Assembly="Stimulsoft.Report.MobileDesign" Namespace="Stimulsoft.Report.MobileDesign" TagPrefix="Stimulsoft" %>

<asp:content id="Content1" contentplaceholderid="Main" runat="Server">
    <Stimulsoft:StiMobileDesigner ID="stiMobileDesigner" runat="server" OnSaveReport="OnSaveReport" OnGetReport="OnGetReport" 
        CssClass="report-edit-stimulsoft ignore-context-menu" Theme="Office2013WhiteBlue" GlobalizationFile=".\SiteSettings\Localization\pt-BR.xml"
        ShowSaveButton="True"
        ShowFileMenuNew="false" 
        ShowFileMenuOpen="false" 
        ShowFileMenuClose="false"   />
</asp:content>
