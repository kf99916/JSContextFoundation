(function(window) {

    'use strict';
    function MyClass() {
        if (!(this instanceof MyClass)) {
            return new MyClass();
        }

        this.value = 'kf99916';
    }

    window.MyClass = MyClass;

})(window);
