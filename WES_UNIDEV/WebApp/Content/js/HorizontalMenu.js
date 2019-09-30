var HorizontalMenu = function () {

    var horizontalMenu;
    var shortcutMenu;
    var subMenuIsHidden;
    var lastWindowWidth;

    var subMenu;
    var subMenus = [];

    var initializeObjects = function() {
        horizontalMenu = $('#menuHorizontal');
        shortcutMenu = $('#menuAtalhos');
        subMenu = $('#topmenu-submenu');

        subMenuIsHidden = false;

        lastWindowWidth = $(window).width();

        $('.dropdown-menu a.dropdown-toggle').click(function (e) {
            e.stopPropagation();
        });
    };

    var measureDistanceBetweenMenus = function() {
        if (shortcutMenu.position().top > 0)
            return -1;

        if (horizontalMenu.length === 0)
            return -1;

        return shortcutMenu.position().left - (horizontalMenu.position().left + horizontalMenu.width());
    };

    var loadSubMenus = function () {
        if (subMenu.length) {
            var menus = subMenu.find('> ul > li');
            for (var i = 0; i < menus.length; i++) {
                var currentMenu = $(menus[i]);
                var subMenuId = currentMenu.attr('id');
                var menuId = subMenuId.replace('topsubmenu', 'topmenu');
                var menuWidth = $('#' + menuId).width();

                subMenus.push({
                    visible: true,
                    subMenuId: subMenuId,
                    menuId: menuId,
                    menuWidth: menuWidth
                });
            }

        }
    };

    var showMenus = function() {

        var menu = _.find(subMenus, { visible: true });

        if (menu) {

            var distance = measureDistanceBetweenMenus();

            if (distance < 0)
                return;

            if (menu.menuWidth > (distance - 70))
                return;

            $('#' + menu.subMenuId).hide();
            $('#' + menu.menuId).show();

            menu.visible = false;

            if (!_.some(subMenus, function(e) { return e.visible; })) {
                $(subMenu).hide();
                subMenuIsHidden = true;
            }

            showMenus();
        }
    };

    var hideMenus = function() {
        var menus = subMenus.slice();
        menus.reverse();

        var menu = _.find(menus, { visible: false });

        if (menu) {

            if (measureDistanceBetweenMenus() > 50)
                return;

            $('#' + menu.subMenuId).show();
            $('#' + menu.menuId).hide();

            menu.visible = true;

            if (subMenuIsHidden) {
                $(subMenu).show();
                subMenuIsHidden = false;
            }

            hideMenus();
        }
    };

    var fixSubMenuPosition = function (selector) {
        $(selector).hover(
            //mouse over
            function () {
                HorizontalMenu.positionSubMenu($(this));
            }
        );
    };

    var addScrollBars = function () {
        $("li.dropdown-user-wes").hover(function () {
            var roles = $(".user-roles > li");
            var rolesSize = 34 * roles.size();
            $("li.roles").attr("style", "");
            $(".slimScrollBar,.slimScrollRail").remove();
            $(".slimScrollDiv").contents().unwrap();

            if (rolesSize + 300 > $(window).height()) {
                $('.user-roles').slimScroll({
                    allowPageScroll: true, // allow page scroll when the element scroll is ended
                    size: '7px',
                    color: ($(this).attr("data-handle-color") ? $(this).attr("data-handle-color") : '#bbb'),
                    wrapperClass: ($(this).attr("data-wrapper-class") ? $(this).attr("data-wrapper-class") : 'slimScrollDiv'),
                    railColor: ($(this).attr("data-rail-color") ? $(this).attr("data-rail-color") : '#eaeaea'),
                    height: ($(window).height() - 300),
                    alwaysVisible: ($(this).attr("data-always-visible") == "1" ? true : false),
                    railVisible: ($(this).attr("data-rail-visible") == "1" ? true : false),
                    disableFadeOut: true
                });
            }
        });
    };

    var suppressOverflownMenus = function () {
        $("div#menuHorizontal ul.navbar-nav li.classic-menu-dropdown > a").mouseover(function () {
            var moreId = $(this).first().parent().attr('id');
            if ($("#" + moreId + "_moreLabel").length) {
                $("#" + moreId + "_moreMenu").contents().unwrap();
                $("#" + moreId + "_groupmenu").contents().unwrap();
                $("#" + moreId + "_moreLabel").remove();
            }
            var menuItens = $(this).siblings().contents(":visible");
            if (menuItens.size() * menuItens.height() > $(window).height()) {
                var maxItens = Math.floor($(window).height() / menuItens.height()) - 3;
                var supressedItens = menuItens.size() - maxItens - 1;
                var moreMenuStyle = "width: 235px; top:-" + supressedItens * menuItens.height() + "px";
                var itemsToWrap = "";

                for (var i = maxItens; i < menuItens.size(); i++)
                    itemsToWrap += "#" + menuItens[i].id + ","

                itemsToWrap = itemsToWrap.slice(0, -1);

                $(itemsToWrap).wrapAll('<ul class="dropdown-menu" id="' + moreId + '_moreMenu" style="' + moreMenuStyle + '" />');
                $("#" + moreId + "_moreMenu").wrapAll('<li class="dropdown-submenu " id="' + moreId + '_groupmenu">');
                var moreMenu = '<a href="#" id="' + moreId + '_moreLabel" data-toggle="dropdown" onmouseover="$(\'#' + moreId + '_moreMenu\').attr(\'style\', \'' + moreMenuStyle + '\')" class="dropdown-toggle">Mais</a>';
                $("#" + moreId + "_moreMenu").parent().append(moreMenu);

                fixSubMenuPosition("#" + moreId + "_groupmenu");
            }
        });
    };

    return {
        init: function () {
            initializeObjects();
            loadSubMenus();
            fixSubMenuPosition(".dropdown-submenu");
            addScrollBars();
            suppressOverflownMenus();

            if ($(window).width() > 1024)
                showMenus();

            $(window).resize(function () {
                var currentWindowWidth = $(window).width();

                if (currentWindowWidth <= 992)
                    return;

                if (currentWindowWidth > lastWindowWidth)
                    showMenus();
                else
                    hideMenus();

                lastWindowWidth = currentWindowWidth;
            });
        },

        fixSubMenuPositions : function() {
            fixSubMenuPosition(".dropdown-submenu");
        }
    };

}();

HorizontalMenu.positionSubMenu = function ($command) {
    if ($command.hasClass('already-positioned'))
        return;

    var parentOnTheLeft = $command.parent().hasClass('dropdown-menu-left');

    //não cabe na direita ou o pai já está indo para esquerda
    if ($command.offset().left + $command.outerWidth() * 2 > $(window).width() || parentOnTheLeft) {

        //pai na esquerda mas não tem espaço na esquerda
        if ($command.offset().left - $command.outerWidth() < 0 && parentOnTheLeft) {
            $command.addClass('already-positioned');
            return;
        }

        //continua indo para esquerda
        var subMenu = $command.find('.dropdown-menu')[0];
        $(subMenu).addClass('dropdown-menu-left').addClass('already-positioned');

    } else
        $command.addClass('already-positioned');
};

export default HorizontalMenu;