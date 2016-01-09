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

	fieldList := SortedCollection 
						sortBlock: [:variablePair1 :variablePair2 | 
							variablePair1 key < variablePair2 key].
	context := self.
	fieldList 
		addAll: (context receiver class allSlots collect: [:slot ||value| 
				value := [(slot read: context receiver)] 
					on: Error 
					do: [ value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
			slot name -> value ] ).
	
	context == nil ifTrue: [^fieldList].
		
	(context tempNames notEmpty) ifTrue: [
		fieldList addAll: ((1 to: context tempNames size) collect: [ :index || key value |
			key := context tempNames at: index.
			value := [context debuggerMap namedTempAt: index in: context] 
				on: Error 
				do: [value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
			key -> value ] ) ].
	
	^ fieldList asOrderedCollection 
		addFirst: ('self' ->  context receiver);
		yourself

]

{ #category : #'*GT-Debugger' }
Context >> reservedNames [

	^ #( '_self' '_thisContext' '_stack top')
]
