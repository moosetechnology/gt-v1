Extension { #name : #Context }

{ #category : #'*GT-Debugger' }
Context >> findContextMatchingPredicate: aPredicate [
	^ self findContextSuchThat: [ :ctx |
		aPredicate matches: ctx ]
]

{ #category : #'*GT-Debugger' }
Context >> gtConstructDebuggerInspectorIn: composite for: aDebugger [
	
	^composite custom: ((GTDebuggerInspector new  
		showFirst: [ :a | a custom: (aDebugger class variablesBrowserClass new startOn: self)];
		yourself) 
			startOn: self)
]

{ #category : #'*GT-Debugger' }
Context >> gtDebuggerRetrieveVariableValuePairs [
	| normalFieldList specialFieldList context|

	specialFieldList := OrderedCollection new.
	normalFieldList := OrderedCollection new.
	context := self. 
	context == nil ifTrue: [^ {'_thisContext' -> nil}].
	specialFieldList 
		add: ('_self' -> context receiver);
		add: ('_thisContext' ->  context).
	context stackPtr > (context tempNames size+1)
		ifTrue: [ 
			specialFieldList 
					add: (('[temp ', (context stackPtr - context tempNames size) asString, '] (_stack top)' -> (context top))).
			context stackPtr - context tempNames size - 1 to: 1 by: -1 do: [ :index|
				specialFieldList 
					add: (('[temp', index asString, ']' -> (context at: (index+context tempNames size)))) ] ]
		ifFalse: [
			specialFieldList 
				add: ('_stack top' -> (context stackPtr > 0 ifTrue: [ context top]))].
	
	normalFieldList
	   addAll: (context receiver class allSlots collect: [:slot | slot name -> (slot read: context receiver) ]).
	(context tempNames notEmpty) ifTrue: [
		normalFieldList addAll: ((1 to: context tempNames size) collect: [ :index || key value |
			key := context tempNames at: index.
			value := [context debuggerMap namedTempAt: index in: context] 
				on: Error 
				do: [value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
			key -> value ] ) ].
	
	^ specialFieldList, 
	 (normalFieldList 
		sorted: [:variablePair1 :variablePair2 | variablePair1 key < variablePair2 key])  
]

{ #category : #'*GT-Debugger' }
Context >> isHaltContext [

	^ self method selector = #halt
]

{ #category : #'*GT-Debugger' }
Context >> reservedNames [

	^ #( '_self' '_thisContext' '_stack top')
]
