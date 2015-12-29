Extension { #name : #SpecDebugger }

{ #category : #'*GT-Debugger' }
SpecDebugger classSide >> availableAutomatically [

	^ true
]

{ #category : #'*GT-Debugger' }
SpecDebugger classSide >> handlesContext: aContext [

	^ true
]

{ #category : #'*GT-Debugger' }
SpecDebugger classSide >> spanNewSessionFrom: anotherSession [

	^ self sessionClass 
		named: anotherSession name 
		on: anotherSession interruptedProcess 
		startedAt: anotherSession interruptedContext
]
