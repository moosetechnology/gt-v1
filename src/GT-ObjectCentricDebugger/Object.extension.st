Extension { #name : #Object }

{ #category : #'*gt-objectcentricdebugger' }
Object >> haltAtNextMessageAndNotify: anObject [
	| aMetaObject |
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject 
		when: (BFMessageReceiveEvent new) 
		do: [:receiver :selector :arguments |  
			self metaObject unbindFrom: self. 
			GTTransparentBreakpoint signalAndNotify: anObject.
			
			"WorldState
				addDeferredUIMessage: [ 
					aNotifier doSomething: thisContext contextTag].
			Processor activeProcess suspend " ].
	aMetaObject bindTo: self 
]

{ #category : #'*gt-objectcentricdebugger' }
Object >> haltAtStateChangeAndNotify: anObject [
	| aMetaObject |
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject
		when: (BFVariableWriteEvent new) 
		do: [ 
			self metaObject unbindFrom: self. 
			GTTransparentBreakpoint signalAndNotify: anObject].
	aMetaObject bindTo: self 
]
