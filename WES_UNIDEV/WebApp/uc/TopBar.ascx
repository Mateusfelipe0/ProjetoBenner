<%@ Control Language="C#" ViewStateMode="Disabled" EnableViewState="false" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.TopBarUserControl" %>
<%@ Import Namespace="Benner.Tecnologia.Common" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Src="~/uc/RoleSelector.ascx" TagName="RoleSelector" TagPrefix="wes" %>
<%@ Register Src="~/uc/CompanyBranchDropDown.ascx" TagName="CompanyBranchDropDown" TagPrefix="wes" %>
<%@ Register TagPrefix="wes" Namespace="Benner.Tecnologia.Wes.Components.WebControls" Assembly="Benner.Tecnologia.Wes.Components, Version=2008.0.0.0, Culture=neutral, PublicKeyToken=f2db26731026fd37" %>

<div class="hor-menu pull-right hidden-sm hidden-xs">
    <ul class="nav navbar-nav pull-right">
        <wes:DeveloperPageMenu ID="developerMenu" runat="server" />
    </ul>
</div>

<div class="top-menu" id="menuAtalhos">
    <ul class="nav navbar-nav pull-right">
        <li id="chat-bot" class="dropdown">
            <a href="#" class="bia-toggler">
                <i class="icon-bubbles"></i>
            </a>
        </li>
        <li class="searcher-icon" id="searcher" data-original-title="Pesquisa (ctrl + espaço)">
            <a href="#">
                <i class="icon-magnifier"></i>
            </a>
        </li>
        <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" <%= OpenSubMenuOnMouseHover ? "data-hover=\"dropdown\"" : ""  %> data-delay="100" data-close-others="true">
                <i class="icon-bar-chart"></i>
                <span class="badge badge-default"><%= UnReadAsyncProcessCount > 0 ? UnReadAsyncProcessCount.ToString() : "" %></span>
            </a>
            <ul class="dropdown-menu extended tasks" style="width: 300px;">
                <li class="external">
                    <h3>
                        <span class="bold">
                            <%= AsyncProcessDetails.Any() ? String.Format("{0} processo(s)", AsyncProcessDetails.Count()) : "Nenhum processo" %>
                        </span>
                    </h3>
                    <a href="javascript:Benner.AsyncProcesses.clearReadyProcesses();">Limpar</a>
                </li>
                <li>
                    <ul class="dropdown-menu-list scroller" style="height: 276px;">
                        <li>
                            <span class="<%= AsyncProcessDetails.Count > 0 ? "active" : "" %>"></span>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
            <wes:CompanyBranchDropDown ID="companyBranchDropDown" runat="server" />
        </li>
        <li id="helpDocumentation" class="dropdown dropdown-extended dropdown-user dropdown-user-wes">
            <a onclick="Benner.Page.helpDocumentation()" id="help-documentation-link" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">
                <i class="icon-question"></i>
                <i class="fa fa-angle-down" id="help-documentation-icon" style="display: none;"></i>
            </a>
            <ul class="dropdown-menu hidden" id="help-documentation-dropdown">
                <li><a onclick="Benner.Page.helpDocumentation();"><i class="icon-question"></i>Documentação</a></li>
                <li><a onclick="Benner.Page.initWebTour(true);"><i class="fa fa-map-signs"></i>Tour da página</a></li>
            </ul>
        </li>
        <li class="dropdown dropdown-extended dropdown-user dropdown-user-wes">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" <%= OpenSubMenuOnMouseHover ? "data-hover=\"dropdown\"" : ""  %> data-delay="100" data-close-others="true" style="padding-top: 12px;">
                <button class="btn btn-icon-only btn-circle btn-sm usuario"><%= GetUserName() %></button>
                <% if (ShowSelectedRoleName)
                    { %>
                <span class="username username-hide-on-mobile"><%= GetCurrentRole() %></span>
                <% } %>
                <i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu">
                <li class="external">
                    <h3><span class="bold"><%= Benner.Tecnologia.Wes.Components.LanguageTranslator.Translate("Usuário") %>: <a href="<%=GetUserUrl()%>"><%=GetUserNick()%></a></span></h3>
                </li>
                <li>
                    <wes:HyperLinkPasswordChange ID="passChangeLink" runat="server" />
                </li>
                <li>
                    <wes:HyperLinkSettings ID="settingsLink" runat="server" />
                </li>
                <li>
                    <wes:HyperLinkDevelopmentEnvironment ID="developmentEnvironment" runat="server" />
                </li>
                <li class="external">
                    <h3><span class="bold"><%= Benner.Tecnologia.Wes.Components.LanguageTranslator.Translate("Papéis") %></span></h3>
                </li>
                <li>
                    <ul class="dropdown-menu-list user-roles">
                        <wes:RoleSelector ID="RoleSelector" runat="server" />
                    </ul>
                </li>
                <li class="external">
                    <h3>
                        <span class="bold">
                            <wes:HyperLinkLogoff ID="Linkbuttonlogoff1" runat="server" />
                        </span>
                    </h3>
                </li>
            </ul>
        </li>
    </ul>
</div>
