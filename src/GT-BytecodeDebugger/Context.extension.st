Extension { #name : #Context }

{ #category : #'*GT-BytecodeDebugger' }
Context >> gtBytecodeDebuggerRetrieveContextValues [
	|fieldList displayedTemp context|

	fieldList := OrderedCollection new.
	context := self.
	context == nil ifTrue: [^('_thisContext' -> nil) asOrderedCollection].
	fieldList
		add: ('_self' ->  context receiver);
		add: ('_thisContext' ->  context).
	
	displayedTemp := OrderedCollection new.
	context stackPtr to: 1 by: -1 do: [ :index ||key|
		key := (index-1) asString.
		(index <= context tempNames size) ifTrue: [ 
			key := key, ' [', (context tempNames at: index) asString, ']'.
			displayedTemp add: (context tempNames at: index) ].
		fieldList add: (key -> (context at: index)) ].
	(context tempNames copy asOrderedCollection removeAll: displayedTemp; yourself) ifNotEmptyDo: [ :uninitializedTemps |
		uninitializedTemps do: [ :each |
			fieldList add: ('- [', each, ']') -> nil ] ].
	
	fieldList 
		addAll: ((context receiver class allInstVarNames size to: 1 by: -1) collect: [:index ||name| 
			name := context receiver class instVarNameForIndex: index.
			('rcv', (index-1) asString, ' [', name , ']') -> (context receiver instVarNamed: name) ]).
	
	^ fieldList
]
