//Logging
var logCount = 0;
var l = function(msg) {
	msg = typeof msg !== 'undefined' ? msg: "";
	logCount++;
	S.log(logCount.toString()+": "+ msg);

};
var windowHintDimension = 64;
S.cfga({
	"defaultToCurrentScreen":         true,
	"nudgePercentOf":                 "screenSize",
	"resizePercentOf":                "screenSize",
	"checkDefaultsOnLoad":            true,
	"gridCellRoundedCornerSize":      0,
	"gridRoundedCornerSize":          0,
	"windowHintsShowIcons":           true,
	"windowHintsIgnoreHiddenWindows": false,
	"windowHintsSpread":              true,
	"windowHintsSpreadSearchWidth":   windowHintDimension,
	"windowHintsSpreadSearchHeight":  windowHintDimension,
	"windowHintsSpreadPadding":       windowHintDimension,
	"windowHintsOrder":               "leftToRight",
	"windowHintsBackgroundColor":     [50, 53, 58, 0.9],
	"windowHintsHeight":              windowHintDimension,
	"windowHintsWidth":               windowHintDimension

});

var sCinema = "2560x1440";
var sLaptop = "1440x900";
var sDell     = "1680x1050";
var fullscreen = S.op("move", {
	"x" : "screenOriginX",
	"y" : "screenOriginY",
	"width" : "screenSizeX",
	"height" : "screenSizeY"

});

var screenResizeRightHalf = S.op("push", {
	"direction" : "right",
	"style" : "bar-resize:screenSizeX/2"

});

var screenResizeLeftHalf = screenResizeRightHalf.dup({"direction": "left"});

var screenResizeTopHalf = S.op("push", {
	"direction" : "up",
	"style" : "bar-resize:screenSizeY/2"

});

var screenResizeBottomHalf = screenResizeTopHalf.dup({"direction": "down"});

var theGrid = S.op("grid", {
	"grids": {
		"1440x900":  { "width": 12, "height": 8  },
		"1680x1050": {"width": 12, "height": 8 }
	},
	"padding": 2
});

var hyperKey = function(argument) { return argument+":ctrl;alt;cmd"; };
var halfHyper = function(argument) { return argument+":alt;cmd"; };
S.bnda({
	// Push Bindings
	"d:ctrl;alt" : screenResizeRightHalf,
	"a:ctrl;alt" : screenResizeLeftHalf,
	"w:ctrl;alt" : screenResizeTopHalf,
	"s:ctrl;alt" : screenResizeBottomHalf,

	// Postions
	"q:ctrl;alt": fullscreen,
	"esc:cmd": S.op("hint"),
	"esc:ctrl": theGrid
});

function appIsOpen(name) {
	  var isOpen = false;
		slate.eachApp(function(app) {
			    if (app.name == name) isOpen = true;
		});
		  return isOpen;
}

var focus_apps = {
	1: 'iTerm',
	2: function() {
		if (appIsOpen("Google Chrome Canary")) {
			return "Google Chrome Canary";
		}
		return "Google Chrome";
	},
	3: 'Rdio',
	4: 'OmniFocus',
	5: '1Password',
	6: 'Dash',
	7: 'Tweetbot',
	8: 'Messages',
	9: 'Textual'
}

_(focus_apps).forEach(function(app, key) {
	  S.bind(halfHyper(key), S.op("focus", {app: app}));
});


l("Finished loading");
