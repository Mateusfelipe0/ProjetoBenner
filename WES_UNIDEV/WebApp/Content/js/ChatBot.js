import Page from './Page';

function getFormatedDate() {
    return (new Date()).toLocaleString('pt-BR').substr(0, 16);
}

function parseDate(text) {
    var orderedDate = '';
    orderedDate += text.substr(6, 4) + '-';
    orderedDate += text.substr(3, 2) + '-';
    orderedDate += text.substr(0, 2) + ' ';
    orderedDate += text.substr(11) + ':00';
    return Date.parse(orderedDate);
}

function isMobile() {
	var check = false;
	(function (a) {
		if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true;
	})(navigator.userAgent || navigator.vendor || window.opera);
	return check;
}

function Message(content, type, time, source, nickname) {
    this.type = type;
    this.content = typeof content === "string" ? (content + '').replace(/([^>\r\n] ?)(\r\n |\n\r |\r |\n)/g, '$1<br />$2') : content;
    this.time = time;
    this.nickname = nickname;
    this.source = source;
}

var ChatBot = function () {

    var chatbotNickname;
    var usernameInitials;
    var initialized = false;
    var historyIndex = 0;
    var typedMessage = "";

    var getAssistantDefinition = function () {
        return new Promise(function (resolve) {
            var serviceUrl = Page.getApplicationPath() + 'api/chatbot/definition';
            $.when(
                $.getJSON(serviceUrl)
            ).then(function (data) {
                resolve(data);
            });
        });
    };

    var getUsernameInfo = function () {
        var username = sessionStorage.getItem('username');
        var currentUser = $('#username').val();

        if (currentUser !== username) {
            sessionStorage.removeItem('username-initials');
            sessionStorage.removeItem('chat-history');
            sessionStorage.removeItem('context');
            sessionStorage.setItem('username', currentUser);
            usernameInitials = $('.dropdown-user-wes .usuario').text();
            sessionStorage.setItem('username-initials', usernameInitials);
        } else {
            usernameInitials = sessionStorage.getItem('username-initials');
        }

        return usernameInitials;
    };

    var create = function (chatTitle) {
        var chat =
            '<div class="row">\
    <a class="page-quick-sidebar-toggler">\
        <i class="icon-login"></i>\
    </a>\
</div>\
<div class="page-quick-sidebar-wrapper" id="chat">\
    <div class="page-quick-sidebar">\
        <ul class="nav nav-tabs">\
            <li>\
                <a>' + chatTitle + '</a>\
            </li>\
        </ul>\
        <div class="tab-content">\
            <div class="tab-pane active page-quick-sidebar-chat">\
                <div class="page-quick-sidebar-list" style="position: relative; overflow: hidden;">\
                    <div class="page-quick-sidebar-chat-users" data-rail-color="#ddd" data-wrapper-class="page-quick-sidebar-list" data-initialized="1" style="overflow: hidden;">\
                        <div class="page-quick-sidebar-chat-user">\
                            <div class="page-quick-sidebar-chat-user-messages" style="overflow: hidden;"></div>\
                            <div class="page-quick-sidebar-chat-user-form">\
                                <span id="message-writing-notification" class="typing" style="display:none;">\
                                    <i class="fa fa-spinner fa-pulse fa-fw"></i>Digitando...\
                                </span>\
                                <div class="input-group">\
                                    <input id="chatInput" type="text" class="form-control" placeholder="Digite uma mensagem..." />\
                                    <div class="input-group-btn">\
                                        <button type="button" class="btn green">\
                                            <i class="fa fa-paper-plane"></i>\
                                        </button>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>\
                    </div>\
                </div>\
            </div>\
        </div>\
    </div>\
</div>';
        $('#chatbot').html(chat);
    };

    var getChatHistory = function () {
        var history = sessionStorage.getItem('chat-history');
        if (!history) {
            return [];
        }
        history = JSON.parse(history);
        return history;
    };

    var getLastMessage = function () {
        var history = getChatHistory();
        var lastItem = null;
        if (history.length > 0) {
            lastItem = history[history.length - 1];
        }
        return lastItem;
    };

    var recoverChatHistory = function () {
        var chatHistory = getChatHistory();

        if (chatHistory.length > 0) {
            for (var i = 0; i < chatHistory.length; i++) {
                appendMessage(chatHistory[i]);
            }
        }
    };

    var preparePost = function (messageObj, avatar) {
        var tpl = '';

        switch (messageObj.type) {
            case 'break':
                tpl += '<div class="break"></div>';
                break;
            case 'text':
                tpl += prepareTextPost(messageObj, avatar);
                break;
            case 'card':
                tpl += prepareCardPost(messageObj);
                break;
            case 'link':
                tpl += prepareLinkPost(messageObj);
                break;
            case 'suggestions':
                tpl += prepareSuggestionsPost(messageObj);
                break;
        }

        return tpl;
    };

    var prepareTextPost = function (messageObj, avatar) {
        var tpl = '';
        var dir = messageObj.source === 'bot' ? 'in' : 'out';
        tpl += '<div class="post ' + dir + '">';
        if (avatar) {
            tpl += '<img class="avatar usuario" alt="" src="' + Page.getApplicationPath() + 'content/img/chat/' + avatar + '"/>';
        } else {
            tpl += '<div class="btn btn-icon-only btn-circle btn-sm avatar usuario">' + messageObj.nickname + '</div>';
        }
        tpl += '<div class="message">';
        tpl += '<span class="arrow"></span>';
        tpl += '<a class="name">' + messageObj.nickname + '</a>&nbsp;';
        tpl += '<span class="datetime">' + messageObj.time + '</span>';
        tpl += '<span class="body">';
        tpl += messageObj.content;
        tpl += '</span>';
        tpl += '</div>';
        tpl += '</div>';
        return tpl;
    };

    var prepareCardPost = function (messageObj) {
        var tpl = '';
        tpl += '<div class="post in">\
    <div class="message card">\
        <span class="body">';

        if (messageObj.content.image) {
            tpl += '\t\t\t<div class="image">\
                <img src="' + messageObj.content.image.imageUri + '" />\
            </div>';
        }

        if (messageObj.content.title) {
            tpl += '\t\t\t<span class="title">' + messageObj.content.title + '</span>';
        }

        if (messageObj.content.subtitle) {
            tpl += '\t\t\t<span class="subtitle">' + messageObj.content.subtitle + '</span>';
        }

        if (messageObj.content.formattedText) {
            tpl += '\t\t\t<p>' + messageObj.content.formattedText + '</p>';
        }

        tpl += '\t\t</span>\
    </div>\
</div>';
        return tpl;
    }

    var prepareLinkPost = function (messageObj) {
        var tpl = '';
        tpl += '<div class="post in">\
    <div class="message link">\
        <span class="body">\
            <a class="btn btn-primary" target="_blank" href="' + messageObj.content.uri + '">' + messageObj.content.destinationName + '</a>\
        </span>\
    </div>\
</div>';
        return tpl;
    }

    var prepareSuggestionsPost = function (messageObj) {
        var tpl = '';
        tpl += '<div class="post in">\
    <div class="message suggestions">\
        <span class="body">';
        for (var i = 0; i < messageObj.content.suggestions.length; i++) {
            var title = messageObj.content.suggestions[i].title;
            tpl += '\t\t\t<a class="btn btn-primary btn-sm" href="javascript:Benner.ChatBot.sendMessage(\'' + title + '\')">' + title + '</a>';
        }
        tpl+= '\t\t</span>\
    </div>\
</div>';
        return tpl;
    }

    var saveBreak = function () {
        var lastItem = getLastMessage();
        if (lastItem && lastItem.source !== 'break') {
            var breakMessage = new Message('', 'break', getFormatedDate(), 'break', null);
            appendMessage(breakMessage);
            saveChatHistory(breakMessage);
        }
    }

    var saveChatHistory = function (messageRecord) {
        var chatHistory = getChatHistory();
        if (!chatHistory)
            chatHistory = [];

        chatHistory.push(messageRecord);
        sessionStorage.setItem('chat-history', JSON.stringify(chatHistory));
    }

    var handleBennerChatBotToggler = function () {
        $('#menuAtalhos #chat-bot').css({ display: 'inline-block' });
		$('.page-quick-sidebar-toggler,.bia-toggler').click(function (e) {
            var body = $('body');
            body.toggleClass('page-quick-sidebar-open');
            if (body.hasClass('page-quick-sidebar-open')) {
                saveBreak();
                setTimeout(focusOnInput, 100);
                setTimeout(scrollToBottom, 150);
            }
		});
    };

    var focusOnInput = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
        var wrapperChat = wrapper.find('.page-quick-sidebar-chat');
        var input = wrapperChat.find('.page-quick-sidebar-chat-user-form .form-control');
        input.focus();
        setTimeout(function () { moveCaretToEnd(input[0]); }, 10);
    };

    var moveCaretToEnd = function (input) {
        var strLength = input.value.length;

        if (input.setSelectionRange !== undefined) {
            input.setSelectionRange(strLength, strLength);
        }
    };

    var scrollToBottom = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
        var wrapperChat = wrapper.find('.page-quick-sidebar-chat');
        var chatContainer = wrapperChat.find('.page-quick-sidebar-chat-user-messages');
        chatContainer.slimScroll({
            scrollTo: (chatContainer[0].scrollHeight + 100) + 'px'
        });
    }

	var handleBennerChatBotChat = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
		var wrapperChat = wrapper.find('.page-quick-sidebar-chat');

		var initChatSlimScroll = function () {
			var chatUsersHeight = wrapper.height() - 50;

			var chatMessages = wrapperChat.find('.page-quick-sidebar-chat-user-messages');
			var chatMessagesHeight = chatUsersHeight - wrapperChat.find('.page-quick-sidebar-chat-user-form').outerHeight(true);
			chatMessagesHeight = chatMessagesHeight - wrapperChat.find('.page-quick-sidebar-nav').outerHeight(true);

			App.destroySlimScroll(chatMessages);
			chatMessages.attr("data-height", chatMessagesHeight);
			App.initSlimScroll(chatMessages);
		};

		initChatSlimScroll();
		App.addResizeHandler(initChatSlimScroll); // reinitialize on window resize

		wrapper.find('.page-quick-sidebar-chat-users .media-list > .media').click(function () {
			wrapperChat.addClass("page-quick-sidebar-content-item-shown");
		});

		wrapper.find('.page-quick-sidebar-chat-user .page-quick-sidebar-back-to-list').click(function () {
			wrapperChat.removeClass("page-quick-sidebar-content-item-shown");
		});

        var handleChatMessagePost = function (e) {
            e.preventDefault();
            
            var input = wrapperChat.find('.page-quick-sidebar-chat-user-form .form-control');

            var text = input.val();
            if (text.length === 0)
                return;

            sendMessage(text);

            input.val("");
        };

		wrapperChat.find('.page-quick-sidebar-chat-user-form .btn').click(handleChatMessagePost);
		wrapperChat.find('.page-quick-sidebar-chat-user-form .form-control').keydown(function (e) {
			if (e.which === 13) {
				handleChatMessagePost(e);
				return false;
			}
		});
    };

    var sendMessage = function (text) {

        var lastItem = getLastMessage();
        if (lastItem) {
            var now = new Date();
            var lastTime = parseDate(lastItem.time);
            var seconds = (now.getTime() - lastTime) / 1000;

            if (seconds > 15 * 60) {
                saveBreak();
            }
        }
        
        var time = new Date();
        var message = new Message(text, 'text', getFormatedDate(), 'user', usernameInitials);
        saveChatHistory(message);
        appendMessage(message);

        var serviceUrl = Page.getApplicationPath() + 'api/chatbot/message';
        historyIndex = 0;

        $('#message-writing-notification').show();
        $.ajax({
            type: "GET",
            dataType: "json",
            data: {
                message: text
            },
            url: serviceUrl,
            success: function (data) {
                if (!data)
                    return;
                var message = new Message(data.text, 'text', getFormatedDate(), 'bot', chatbotNickname);
                saveChatHistory(message);
                appendMessage(message);

                if (Object.keys(data.attachments).length > 0) {
                    Object.keys(data.attachments).forEach(function (key) {
                        var attMessage = null;
                        switch (key) {
                            case 'card':
                            case 'link':
                            case 'suggestions':
                                attMessage = new Message(data.attachments[key], key, getFormatedDate(), 'bot', chatbotNickname);
                                break;
                        }

                        if (attMessage != null) {
                            saveChatHistory(attMessage);
                            appendMessage(attMessage);
                        }
                    });
                }
            },
            error: function (error) {
				var message = new Message('Olá. Infelizmente estou com um problema técnico aqui. Preciso de uns minutinhos. Se for urgente, por favor, entre em contato com o nosso suporte.', 'text', getFormatedDate(), 'bot', chatbotNickname);
                appendMessage(message);
            },
            complete: function () {
                $('#message-writing-notification').hide();
            }
        });
    };

    var appendMessage = function (message) {
        var post = preparePost(message, message.source === 'bot' ? 'bia.png' : null);
        post = $(post);

        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
        var wrapperChat = wrapper.find('.page-quick-sidebar-chat');
        var chatContainer = wrapperChat.find('.page-quick-sidebar-chat-user-messages');
        chatContainer.append(post);
        scrollToBottom();
    }

	// Handles quick sidebar tasks
	var handleBennerChatBotAlerts = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');

		var initAlertsSlimScroll = function () {
			var alertList = wrapper.find('.page-quick-sidebar-alerts-list');
			var alertListHeight;

			alertListHeight = wrapper.height() - 80 - wrapper.find('.nav-justified > .nav-tabs').outerHeight();

			// alerts list 
			App.destroySlimScroll(alertList);
			alertList.attr("data-height", alertListHeight);
			App.initSlimScroll(alertList);
		};

		initAlertsSlimScroll();
		App.addResizeHandler(initAlertsSlimScroll);
	};

	// Handles quick sidebar settings
	var handleBennerChatBotSettings = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');

		var initSettingsSlimScroll = function () {
			var settingsList = wrapper.find('.page-quick-sidebar-settings-list');
			var settingsListHeight;

			settingsListHeight = wrapper.height() - 80 - wrapper.find('.nav-justified > .nav-tabs').outerHeight();

			// alerts list
			App.destroySlimScroll(settingsList);
			settingsList.attr("data-height", settingsListHeight);
			App.initSlimScroll(settingsList);
		};

		initSettingsSlimScroll();
		App.addResizeHandler(initSettingsSlimScroll);
    };

    var handleBennerChatBotKeyShortcuts = function () {
        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
        var wrapperChat = wrapper.find('.page-quick-sidebar-chat');
        var input = wrapperChat.find('.page-quick-sidebar-chat-user-form .form-control');

        input.keydown(function (e) {
            if (e.keyCode === 38) { // Up
                setInputFromHistory('up');
            } else if (e.keyCode === 40) { // Down
                setInputFromHistory('down');
            }
        });
    }

    var setInputFromHistory = function (direction) {
        var lastIndex = historyIndex;
        if (direction === 'up') {
            historyIndex++;
        } else if (direction === 'down') {
            if (historyIndex > 0)
                historyIndex--;
        } else {
            return;
        }

        if (historyIndex === lastIndex)
            return;

        var wrapper = $('#chatbot .page-quick-sidebar-wrapper');
        var wrapperChat = wrapper.find('.page-quick-sidebar-chat');
        var input = wrapperChat.find('.page-quick-sidebar-chat-user-form .form-control');
        
        if (historyIndex === 0) {
            input.val(typedMessage);
        } else {
            if (lastIndex === 0)
                typedMessage = input.val();
            
            var history = getUserHistory();
            var reverseHistory = history.reverse();

            if (historyIndex > reverseHistory.length) {
                historyIndex = reverseHistory.length;
            }

            input.val(reverseHistory[historyIndex - 1]);
        }
        setTimeout(function () { moveCaretToEnd(input[0]); }, 10);
    }

    var getUserHistory = function () {
        var history = getChatHistory();
        var result = [];
        for (var i = 0; i < history.length; i++) {
            if (history[i].source === 'user') {
                result.push(history[i].content);
            }
        }
        return result;
    }

    var openWithInitialMessage = function (message) {
        sendMessage(message);
		$('.page-quick-sidebar-toggler,.bia-toggler').click();
	}

	return {
        init: function (message) {
            var botDom = $('#chatbot');

            if (botDom.size() > 0) {
                getAssistantDefinition().then(function (data) {
                    var virtualAssistantDefinition = data;
                    if (virtualAssistantDefinition != null) {
                        chatbotNickname = virtualAssistantDefinition.virtualAssistantUserName;
                        getUsernameInfo();
                        create(virtualAssistantDefinition.virtualAssistantName);
                        handleBennerChatBotToggler();
                        handleBennerChatBotChat();
                        handleBennerChatBotAlerts();
                        handleBennerChatBotSettings();
                        handleBennerChatBotKeyShortcuts();
                        recoverChatHistory();
                        if (message !== undefined) {
                            openWithInitialMessage(message);
                        }
                        initialized = true;
                    }
                });
            }
        },
        sendMessage: function (message) {
            if (initialized) {
                sendMessage(message);
            }
        }
	};

}();

export default ChatBot;