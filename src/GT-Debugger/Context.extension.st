Extension { #name : #Context }

{ #category : #'*GT-Debugger' }
Context >> findContextMatchingPredicate: aPredicate [
	^ self findContextSuchThat: [ :ctx |
		aPredicate matches: ctx ]
]

{ #category : #'*GT-Debugger' }
Context >> gtConstructDebuggerInspectorIn: composite for: aDebugger [
	
	^ composite custom: ((GTDebuggerInspector new  
		debugger: aDebugger;
		notifyPaneRemoved: true;
		showFirst: [ :a | a custom: (aDebugger class variablesBrowserClass new 
			debugger: aDebugger;
			startOn: self;
			restoreSettings).];
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
	
	
	context isNil ifTrue: [
		^ fieldList asOrderedCollection 
			addLast: ('thisContext' -> context);
			yourself].
		
	fieldList addAll: context gtDebuggerTempsValuePairs.
	
	^ fieldList asOrderedCollection 
		addFirst: ('self' ->  context receiver);
		addLast: ('thisContext' -> context);
		addLast: ('stack top' -> ( context stackPtr > 0 ifTrue: [ context top]));
		yourself

]

{ #category : #'*GT-Debugger' }
Context >> gtDebuggerTempsValuePairs [
	| values |
	values := OrderedCollection new.
	(self tempNames notEmpty) ifTrue: [
		values addAll: ((1 to: self tempNames size) collect: [ :index || key value |
			key := self tempNames at: index.
			value := [self debuggerMap namedTempAt: index in: self] 
				on: Error 
				do: [value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
			key -> value ] ) ].
	^ values
]

{ #category : #'*GT-Debugger' }
Context >> reservedNames [

	^ #( 'self' 'thisContext' 'stack top')
]
