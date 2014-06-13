Extension { #name : #MethodContext }

{ #category : #'*GT-Debugger' }
MethodContext >> gtConstructDebuggerInspectorIn: composite [
	
	^composite custom: ((GTDebuggerInspector new  
		showFirst: [ :a | a custom: (GTDebuggerVariablesBrowser new startOn: self)];
		yourself) 
			startOn: self)
]

{ #category : #'*GT-Debugger' }
MethodContext >> gtDebuggerRetrieveVariableValuePairs [
	|fieldList context|

	fieldList := OrderedCollection new.
	context := self.
	fieldList 
		add: ('_self' ->  context receiver);
	      addAll: (context receiver class allInstVarNames collect: [:each | each -> (context receiver instVarNamed: each) ]).
	
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
MethodContext >> reservedNames [

	^ #( '_self' '_thisContext' '_stack top')
]
