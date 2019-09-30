(function ($) {
    $.fn.focusOnNextField = function () {
        // inspirado neste post: http://jqueryminute.com/set-focus-to-the-next-input-field-with-jquery/
        return this.each(function () {

            // pesquisar apenas dentro do mesmo widget
            var widget = $(this).closest('.portlet').closest("[id][id!='']");

            // por todos, mesmo que estejam 'hidden'
            var fields = $(widget).find('input,textarea,select');
            var index = fields.index(this);

            while (index > -1 && (index + 1) < fields.length) {

                var controlToFocus = fields.eq(index + 1);
                if ($(controlToFocus).is(':hidden,[readonly]')) {
                    ++index;
                } else {
                    $(controlToFocus).focus();
                    $(controlToFocus).select();
                    return true;
                }
            }
            return false;
        });
    };

    $.fn.focusOnFirstField = function () {
        return this.each(function () {

            var allowFocus = $(this).find('.allow-focus');

            if (allowFocus) {
                
                var elementFocus = $(allowFocus).find('input,textarea,select')
					.not('.searcher-criteria')
					.not('.ignore-focus')
					.not('[type=hidden]')
					.not('[type=button]')
					.not('[type=submit]')
					.not('[type=radio]')
					.not('[readonly]')
					.not('[disabled]')
					.first();
				
                $(elementFocus).focus();
                $(elementFocus).select();

                return true;
            }

            return false;
        });
    };

}(jQuery));

String.prototype.removeAccents = function () {
    return this
        .replace(/[áàãâä]/gi, "a")
        .replace(/[éè¨ê]/gi, "e")
        .replace(/[íìïî]/gi, "i")
        .replace(/[óòöôõ]/gi, "o")
        .replace(/[úùüû]/gi, "u")
        .replace(/[ç]/gi, "c")
        .replace(/[ñ]/gi, "n")
        .replace(/[^a-zA-Z0-9]/g, " ");
};

String.prototype.hashCode = function () {
    var hash = 5381;
    for (i = 0; i < this.length; i++) {
        var char = this.charCodeAt(i);
        hash = ((hash << 5) + hash) + char;
    }
    return hash;
};

String.prototype.replaceAll = function (search, replacement) {
    return this.split(search).join(replacement);
};

Object.extend = function extend(obj, src) {
    for (var key in src) {
        if (src.hasOwnProperty(key)) obj[key] = src[key];
    }
    return obj;
}