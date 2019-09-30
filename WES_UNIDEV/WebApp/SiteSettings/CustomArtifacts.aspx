<%@ Page Title="Customização de Artefatos" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.CustomArtifactsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:HiddenField runat="server" ID="hdnTemplateLogin" ClientIDMode="Static" />
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span>Customização de Artefatos</span>
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-actions nobg no-border commands-bar fluid">
                <asp:LinkButton ID="lnkBtnSave" CssClass="btn blue" runat="server" OnClick="Save_Click" OnClientClick="return ShowModal();">Salvar e Reiniciar</asp:LinkButton></li>
            </div>
            <div class="alert alert-info">
                <strong>Informação!</strong> Aqui é possível selecionar artefatos para customização de acordo com seu nível (núcleo, vertical, específico, cliente).
                Marcando algum artefato, o arquivo será criado na pasta raiz de sua aplicação, inicialmente como uma cópia do artefato já disponível na pasta (artefato padrão liberado pela Tecnologia, por exemplo), e de acordo com a nomenclatura da camada atual, como mostra a listagem abaixo.
                Caso o arquivo já exista e você estiver desmarcando, o arquivo ficará disponível na pasta, porém, desabilitado, por ex: Login50.aspx.disabled.
            </div>
            <div class="alert alert-warning">
                <strong>Atenção!</strong> Ao clicar em "Salvar e Reiniciar" a aplicação será reiniciada, fazendo com que os usuários logados no sistema sejam desconectados. Também acontecerá a criação dos arquivos conforme as marcações abaixo. 
                Após a criação dos arquivos, a ferramenta passará a utilizar estes novos artefatos como padrão para a sua camada.
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="false" AllowSorting="true">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Artefato" HeaderStyle-Width="250px" />

                            <asp:TemplateField HeaderText="Núcleo">
                                <ItemTemplate>
                                    <div class="artifact-checkbox-cell">
                                        <span>
                                            <asp:Label ID="lblBenner" Width="3px" runat="server" Text="&nbsp;" />
                                        </span>
                                        <asp:CheckBox ID="chkBenner" runat="server" Checked='<%# Eval("BennerLevel") %>'  Enabled="true" AutoPostBack="true" OnCheckedChanged="CheckedChanged" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Vertical">
                                <ItemTemplate>
                                    <div class="artifact-checkbox-cell">
                                        <span>
                                            <asp:Label ID="lblVertical" Width="3px" runat="server" Text="&nbsp;" />
                                        </span>
                                        <asp:CheckBox ID="chkVertical" runat="server" Checked='<%# Eval("VerticalLevel") %>' Enabled="true" AutoPostBack="true" OnCheckedChanged="CheckedChanged" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Específico">
                                <ItemTemplate>
                                    <div class="artifact-checkbox-cell">
                                        <span>
                                            <asp:Label ID="lblEspecifico" Width="3px" runat="server" Text="&nbsp;" />
                                        </span>
                                        <asp:CheckBox ID="chkEspecifico" runat="server" Checked='<%# Eval("SpecificLevel") %>' Enabled="true" AutoPostBack="true" OnCheckedChanged="CheckedChanged" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cliente" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                    <div class="artifact-checkbox-cell">
                                        <span>
                                            <asp:Label ID="lblCliente" Width="3px" runat="server" Text="&nbsp;" />
                                        </span>
                                        <asp:CheckBox ID="chkCliente" runat="server" Checked='<%# Eval("ClientLevel") %>' Enabled="true" AutoPostBack="true" OnCheckedChanged="CheckedChanged" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    
    <script type="text/javascript">
        function ShowModal() {
            Benner.ModalMessage.show("<h3>Reiniciando o aplicativo</h3><br/><h4>Você será redirecionado para a página de login do aplicativo.</h4>");
        }

        function selectCustomLogin(checkbox) {
            if ($(checkbox).is(":checked")) {
                Benner.ModalPage.show({ size: 'large', height: 375, url: '../SiteSettings/LoginTemplate.aspx', displayFooter: false, displayTitle: false, displayFooter: false })
            } else {
                $("#hdnTemplateLogin").val("");
            }
        }
    </script>
</asp:Content>



