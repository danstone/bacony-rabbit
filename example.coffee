rabbit = require 'rabbit.js'
bacon = require 'baconjs'
bacon.rabbit = require './bacony-rabbit.js'
_ = require 'lodash'

context = rabbit
	.createContext()

createSub = (name) ->
	res = context.socket 'PULL'
	res.setEncoding 'utf8'
	res.connect name
	bacon.rabbit.fromData res

mapValues = (map, f) -> 
		_ map
			.map (v, k) -> [k, f v]
			.object()
			.value()

context.on 'ready', ->
	streams = 
		bacon: 'bacon'
		sausages: 'sausage'
		eggs: 'eggs'
		hashbrowns: 'hash-browns'
		beans: 'beans'
	streams = mapValues streams, createSub

	stream = bacon.when(
			[streams.eggs], -> 'needs more meat'
			[streams.beans, streams.hashbrowns], -> 'yum'
			[streams.bacon, streams.sausages], -> 'thats a pretty good breakfast')

	stream.log()
