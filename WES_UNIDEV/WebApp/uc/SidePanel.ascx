<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.SidePanelUserControl" %>

<wes:NewItemControl ID="newItem" runat="server" MenuID="LISTA_DE_INSERCAO" />

<wes:ShortcutWidget runat="server" Title="Recentes" ID="recentItems"  Provider="RecentItem" />
<wes:MenuWidget runat="server" ID="ShortCuts" Title="Atalhos" MenuID="BARRA_DE_ATALHOS" />
<wes:ShortcutWidget runat="server" Title="Favoritos" ID="bookmarks" Provider="Bookmark" />
