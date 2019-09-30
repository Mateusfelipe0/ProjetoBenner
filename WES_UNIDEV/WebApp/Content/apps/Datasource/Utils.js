export default {
    moveArrayElement: function (array, oldIndex, newIndex) {
        if (newIndex >= array.length) {
            var i = newIndex - this.length;
            while ((i--) + 1) {
                array.push(undefinied);
            }
        }

        array.splice(newIndex, 0, array.splice(oldIndex, 1)[0]);
    },

    getTextFromSelect: function (targetSelect) {
        return $('option:selected', targetSelect).text();
    },

    getPropertyFromOption: function (propertyName, targetOption) {
        return $(targetOption).select2('data')[0][propertyName];
    }
};