var Sidebar = function () {
};

Sidebar.init = function () {
    var sidebarItens = $('.sidebar > li > a');
    var sidebar = $('.sidebar');

    $(sidebarItens).on('click', function () {
        // Recupera o id do item clicado
        var id = $(this).attr('id');
        // Adiciona ao localStorage 'closed' para todos os itens exceto o clicado
        // Precisa desta implementação, porque estamos guardado as informações dos menus abertos
        // Mesmo depois de logado a pessoa pode logar novamente e estara la está informação
        for (var i = 0; i < sidebarItens.length; i++) {
            var item = $(sidebarItens[i]).attr('id');
            if (item != null && item != id)
                localStorage.setItem(item, 'closed');
        }
        // Adiciona o estado do menu no momento
        localStorage.setItem(id, ($(this).parent().hasClass('closed') || !$(this).parent().hasClass('open'))  ? 'open' : 'closed');
    });

    $('#sidebar-menu-toggler').on('click', function(e) {
        var closed = $(sidebar).hasClass('page-sidebar-menu-closed');
        //Verifica se o sidebar está aberto ou fechado
        if (closed) {
            localStorage.setItem('sidebar-state', 'open');
        } else {
            localStorage.setItem('sidebar-state', 'closed');
        }
        document.cookie = "sidebar-state=" + (closed ? 'open' : 'closed') + "; expires=Sat, 01 Jan 2050 12:00:00 GMT; path=/";
    });
    
    var currentSlideSpeed = $(sidebar).attr('data-slide-speed');
    $(sidebar).data('slide-speed', '0');

    _.each(sidebarItens, function (item) {
        var itemState = localStorage.getItem($(item).attr('id'));
    });

    var sidebarState = localStorage.getItem('sidebar-state');
    
    $(sidebar).data('slide-speed', currentSlideSpeed);
};

export default Sidebar;