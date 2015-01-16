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
	|fieldList context|

	fieldList := OrderedCollection new.
	context := self.
	fieldList 
		add: ('_self' ->  context receiver);
	      addAll: (context receiver class allSlots collect: [:slot | slot name -> (slot read: context receiver) ]).
	
	fieldList add: ('_thisContext' ->  context).
	 context == nil ifTrue: [^fieldList].
	fieldList 
		add: ('_stack top' -> ( context stackPtr > 0 ifTrue: [ context top])).
		
	(context tempNames notEmpty) ifTrue: [
		fieldList addAll: ((1 to: context tempNames size) collect: [ :index || key value |
			key := context tempNames at: index.
			value := [context debuggerMap namedTempAt: index in: context] 
				on: Error 
				do: [value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
			key -> value ] ) ].
	
	^ fieldList
]

{ #category : #'*GT-Debugger' }
Context >> isHaltContext [

	^ self method selector = #halt
]

{ #category : #'*GT-Debugger' }
Context >> reservedNames [

	^ #( '_self' '_thisContext' '_stack top')
]
