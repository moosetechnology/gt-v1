Extension { #name : #Object }

{ #category : #'*gt-debugger-objectcentric' }
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
