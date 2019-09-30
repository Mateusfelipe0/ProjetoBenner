<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ChatBotControl" %>

<script type="text/javascript" src="<%= ResolveUrl("~/Content/js/audioRecord.js")%>"></script>
<link href="<%= ResolveUrl("~/Content/css/ChatBot2.css")%>" rel="stylesheet" media="all" type="text/css" />
<script src="<%= ResolveUrl("~/Content/js/ChatBot2.js")%>" type="text/javascript"></script>

<div class="row row-chat-window-bia">
    <div class="chat-window col-xs-12 col-sm-12 col-md-5 col-md-offset-7" id="chat-window-bia">
        <div class="panel panel-default panel-bia">
            <div class="panel-heading top-bar top-bar-bia ">
                <div class="col-md-9 col-xs-10 no-padding">
                    <img class="chat-icon-bia" src="<%=ResolveUrl("~/Content/img/Chat/chat-32.png") %>" />
                    <h3 class="panel-title"><%= Title %></h3>
                </div>
                <div class="col-md-3 col-xs-2 command-bar-bia">
                    <a href="#"><span id="max_chat_window" class="icon-rotate icon_minim glyphicon glyphicon-resize-full"></span></a>
                </div>
            </div>
            <div class="panel-body msg_container_base " id="chat-messages">
                <p id="message-writing-notification" style="bottom: 37px; position: fixed; display: none;">Bia está digitando...</p>
            </div>
            <div class="panel-footer panel-footer-bia">
                <div class="input-group">
                    <textarea class="form-control chat_input" id="chat-user-message" rows="1" placeholder="Digite aqui sua mensagem..."></textarea>
                    <span class="input-group-btn">
                        <button class="btn btn-primary" id="chat-send-message"><span id="chat-send-icon" class="fa fa-microphone"></span></button>
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>


