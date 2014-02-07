bacon = require 'baconjs'

errorCtor = (x) -> new bacon.Error x
fromData = (sub) ->
	good = bacon.fromEventTarget sub, 'data'
	bad = bacon.fromEventTarget sub, 'error'
	good.merge bad.flatMap errorCtor
	
	
exports.fromData = fromData