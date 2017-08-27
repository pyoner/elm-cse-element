export function init(app) {
    const lib = google.search.cse.element;

    app.ports.init.subscribe(function(cx) {
        function ready(flag) {
            app.ports.ready.send(flag);
        }
        // Insert it before the CSE code snippet so that cse.js can take the script
        // parameters, like parsetags, callbacks.
        window.__gcse = {
            parsetags: 'explicit',
            callback: function() {
                if (document.readyState == 'complete') {
                    // Document is ready when CSE element is initialized.
                    ready(true);
                } else {
                    // Document is not ready yet, when CSE element is initialized.
                    google.setOnLoadCallback(function() {
                        ready(true);
                    }, true);
                }
            }
        };

        (function() {
            const gcse = document.createElement('script');
            gcse.type = 'text/javascript';
            gcse.async = true;
            gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
            const s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(gcse, s);
        })();
    });

    app.ports.render.subscribe(function([componentConfig, opt_componentConfig]) {
        lib.render(componentConfig, opt_componentConfig);
    });

    app.ports.go.subscribe(function(opt_container) {
        lib.go(opt_container);
    });

    app.ports.getElement.subscribe(function(gname) {
        const element = lib.getElement(gname);
        app.ports.aboutElement.send(element);
    });

    app.ports.execute.subscribe(function([gname, query]) {
        const element = lib.getElement(gname);
        element.execute(query);
    });

    app.ports.prefillQuery.subscribe(function([gname, query]) {
        const element = lib.getElement(gname);
        element.prefillQuery(query);
    });

    app.ports.getInputQuery.subscribe(function(gname) {
        const element = lib.getElement(gname);
        const query = element.getInputQuery();
        app.ports.inputQuery.send({ gname: gname, query: query });
    });

    app.ports.clearAllResults.subscribe(function(gname) {
        const element = lib.getElement(gname);
        element.clearAllResults();
    });

}
