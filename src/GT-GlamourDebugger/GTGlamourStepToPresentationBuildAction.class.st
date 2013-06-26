Class {
	#name : #GTGlamourStepToPresentationBuildAction,
	#superclass : #DebugAction,
	#category : #'GT-GlamourDebugger'
}

{ #category : #actions }
GTGlamourStepToPresentationBuildAction >> executeAction [
	| presentationCreation presentationCode |
	presentationCreation := self presentationCreationPredicate.
	presentationCode := self presentationCodePredicate.
	self flag: 'This should go in the session'.

	self session process stepUntil: presentationCreation.
	self session 
		updateWithContext: self session process suspendedContext 
		fromProcess: self session process.
	
	presentationCreation hasMatched ifTrue: [ 
		
		self session process stepUntil: presentationCode.
		self session 
			updateWithContext: self session process suspendedContext 
			fromProcess: self session process ].
	
	presentationCode hasMatched ifTrue: [ self session stepInto. ]
		
	
]

{ #category : #'initialize-release' }
GTGlamourStepToPresentationBuildAction >> initialize [

	self label: 'Next presentation build'.
	self icon: GLMUIThemeExtraIcons play.
]

{ #category : #predicates }
GTGlamourStepToPresentationBuildAction >> presentationCodePredicate [
	
	^ ContextPredicate new 
			baseContext: self debugger rootBrowserContext;
			action: [ :aContext |
				aContext selector = #glamourValueWithArgs: and: [ 
					aContext peekInstruction arguments size > 0 and: [ 
					 	#( #value #valueWithArguments:) includes: aContext peekInstruction argument ] ] ]

]

{ #category : #predicates }
GTGlamourStepToPresentationBuildAction >> presentationCreationPredicate [

	^ ContextPredicate new 
			baseContext: self debugger rootBrowserContext;
			action: [ :aContext |
				aContext methodClass = GLMPresentStrategy and: [ 
					aContext selector = #presentations and: [ 
						self flag: 'Ugly hack based on bytecode'.
						aContext pc = aContext method initialPC ] ] ]


]
