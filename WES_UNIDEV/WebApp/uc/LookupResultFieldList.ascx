<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.LookupResultFieldListControl" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wesUI" %>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"></button>
    <h4 class="modal-title"><asp:Label ID="lblTitle" runat='server' /></h4>
</div>
<div class="modal-body">
    <asp:UpdatePanel ID="messageUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <wes:MessagePanel ID="messagePanel" runat="server"></wes:MessagePanel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="list-fields">
        <asp:CheckBoxList ID="chkFields" CssClass="editor-check-list" ClientIDMode="Static" RepeatLayout="UnorderedList" runat="server" />
    </div>
    <asp:HiddenField id="txtChkFieldsOrder" ClientIDMode="Static" runat="server"></asp:HiddenField>
</div>
<div class="modal-footer">
    <asp:LinkButton ID="btnAdd" CssClass="btn blue" OnClientClick="$('#lookupResultFields').modal('hide');" OnClick="OnAddResultFieldsClick" runat="server">OK</asp:LinkButton>
    <button type="button" class="btn default" data-dismiss="modal">Cancelar</button>
</div>
  <style>
    #chkFields { list-style-type: none; margin: 0; padding: 0; width: 100%; }
    .ui-sortable-helper  {
        box-shadow: 0px 0px 11px 2px rgba(204,204,204,1);
        background-color: white;
    }
    .ui-sortable-handle {
        cursor: pointer;
		border-bottom: 1px solid rgba(234,234,234,1);
    }
    .ui-sortable-handle:last-child {
		border-width: 0px;
    }
    .ui-sortable-handle i {
        color: rgba(204,204,204,1);
    }
  </style>
  <script>
      function applyDragNDrop() {
          $(function () {
              $("#chkFields").sortable({
                stop: function (event, ui) {
                    populateOrder();
                }
              });
              $("#chkFields").disableSelection();
          });

          if ($(".ui-sortable-handle").find(".fa-navicon").length == 0)
              $(".ui-sortable-handle").each(function () { $(this).prepend("<i class='fa fa-navicon' style='float: right; margin-top: 11px;' />") });

          populateOrder();
      }

      function populateOrder() {
          var phrases = [];
          $('.ui-sortable-handle > .mt-checkbox.mt-checkbox-outline').each(function () {
              phrases.push($(this).text());
          });
          $("#txtChkFieldsOrder").val(phrases);
      }
  </script>