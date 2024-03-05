(function (global) {
    if ("app" in global) {
        var soldOutMessage = 'This offer is SOLD OUT for the season. Please visit <a href="https://www.snowjoe.com/collections/snow-blowers-shovels-cordless" id="toast-snow-joe-shop-link">SnowJoe.com</a> for additional cordless snow blower options.';
        if (window.innerWidth <= 1200) {
            makeToast("form-response", soldOutMessage);
        }
    }
} (window));