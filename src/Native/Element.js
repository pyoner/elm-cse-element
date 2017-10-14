var _pyoner$elm_cse_element$Native_Element = function() {
    var scheduler = _elm_lang$core$Native_Scheduler;

    function load(cx) {
        return scheduler.nativeBinding(function(callback) {
            // Insert it before the CSE code snippet so that cse.js can take the script
            // parameters, like parsetags, callbacks.
            window.__gcse = {
                parsetags: 'explicit',
                callback: function() {
                    if (document.readyState == 'complete') {
                        // Document is ready when CSE element is initialized.
                        callback(scheduler.succeed(cx))
                    } else {
                        // Document is not ready yet, when CSE element is initialized.
                        google.setOnLoadCallback(function() {
                            callback(scheduler.succeed(cx))
                        }, true);
                    }
                }
            };

            (function() {
                var gcse = document.createElement('script');
                gcse.type = 'text/javascript';
                gcse.async = true;
                gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
                gcse.onerror = function(error) {
                    callback(scheduler.fail("Can't load script for " + cx))
                }
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(gcse, s);
            })();
        })
    }

    function render(componentConfig, opt_componentConfig) {
        return scheduler.nativeBinding(function(callback) {
            var id = componentConfig.div;
            try {
                google.search.cse.element.render(componentConfig, opt_componentConfig);
            } catch (e) {
                callback(scheduler.fail("Render error: " + e));
                return;
            }
            callback(scheduler.succeed(componentConfig.gname));
        });
    }

    function clear(elementId) {
        return function(callback) {
            var el = document.getElementById(elementId);
            if (el) {
                el.innerHTML = "";
                callback(scheduler.succeed(elementId));
            } else {
                callback(scheduler.fail("Can't found DOM element by id " + elementId));
            }
        }
    }

    function execute(gname, query) {
        return function(callback) {
            try {
                var element = google.search.cse.element.getElement(gname);
                element.execute(query);
            } catch (e) {
                callback(scheduler.fail('Execute error: ' + e));
                return;
            }
            callback(scheduler.succeed([gname, query]));
        }
    }

    function prefillQuery(gname, query) {
        return function(callback) {
            try {
                var element = google.search.cse.element.getElement(gname);
                element.prefillQuery(query);
            } catch (e) {
                callback(scheduler.fail('PrefillQuery error: ' + e));
                return;
            }
            callback(scheduler.succeed([gname, query]));
        }
    }

    function getInputQuery(gname) {
        return function(callback) {
            try {
                var element = google.search.cse.element.getElement(gname);
                var query = element.getInputQuery();
            } catch (e) {
                callback(scheduler.fail('getInputQuery error: ' + e));
                return;
            }
            callback(scheduler.succeed([gname, query]));
        }
    }

    function clearAllResults(gname) {
        return function(callback) {
            try {
                var element = google.search.cse.element.getElement(gname);
                element.clearAllResults();
            } catch (e) {
                callback(scheduler.fail('clearAllResults error: ' + e));
                return;
            }
            callback(scheduler.succeed(gname));
        }
    }

    return {
        load: load,
        render: F2(render),
        clear: clear,
        execute: F2(execute),
        prefillQuery: F2(prefillQuery),
        getInputQuery: getInputQuery,
        clearAllResults: clearAllResults,
    }
}();
