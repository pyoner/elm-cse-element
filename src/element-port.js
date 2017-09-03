export function init(app) {
    let event = app.ports.event;
    app.ports.load.subscribe(function(cx) {
        // Insert it before the CSE code snippet so that cse.js can take the script
        // parameters, like parsetags, callbacks.
        window.__gcse = {
            parsetags: 'explicit',
            callback: function() {
                if (document.readyState == 'complete') {
                    // Document is ready when CSE element is initialized.
                    event.send(["Load", 1, cx]);
                } else {
                    // Document is not ready yet, when CSE element is initialized.
                    google.setOnLoadCallback(function() {
                        event.send(["Load", 1, cx]);
                    }, true);
                }
            }
        };

        (function() {
            const gcse = document.createElement('script');
            gcse.type = 'text/javascript';
            gcse.async = true;
            gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
            gcse.onerror = function(error) {
                event.send(["Load", 0, "Can't load Script"]);
            }
            const s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(gcse, s);
        })();
    });

    app.ports.render.subscribe(function([componentConfig, opt_componentConfig]) {
        const id = componentConfig.div;
        document.getElementById(id).innerHTML = '';
        google.search.cse.element.render(componentConfig, opt_componentConfig);
    });

    app.ports.go.subscribe(function(opt_container) {
        google.search.cse.element.go(opt_container);
    });

    app.ports.getElement.subscribe(function(gname) {
        const element = google.search.cse.element.getElement(gname);
        app.ports.aboutElement.send(element);
    });

    app.ports.execute.subscribe(function([gname, query]) {
        const element = google.search.cse.element.getElement(gname);
        element.execute(query);
    });

    app.ports.prefillQuery.subscribe(function([gname, query]) {
        const element = google.search.cse.element.getElement(gname);
        element.prefillQuery(query);
    });

    app.ports.getInputQuery.subscribe(function(gname) {
        const element = google.search.cse.element.getElement(gname);
        const query = element.getInputQuery();
        app.ports.inputQuery.send([gname, query]);
    });

    app.ports.clearAllResults.subscribe(function(gname) {
        const element = google.search.cse.element.getElement(gname);
        element.clearAllResults();
    });

}
