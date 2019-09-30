<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.UrlLinkDefinitionControl" %>

<div class="form-group">
    <label class="control-label name column-nowrap">
        <div class="label-form">
            <div class="label-title">
                Url
            </div>
            <div class="label-title-help">
                <i class="fa fa-question-circle help-tooltip" data-original-title="Na url é possível definir parametros na QueryString referênciando um campo, ex: ~/Pages/Default.aspx?handle=@CAMPO(HANDLE)"></i>
            </div>
        </div>
    </label>
    <div class="input-group">
        <asp:TextBox ID="txtUrl" CssClass="form-control autocomplete autocomplete-pages" runat="server"></asp:TextBox>
    </div>
</div>
