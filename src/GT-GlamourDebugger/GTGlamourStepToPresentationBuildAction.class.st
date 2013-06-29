Class {
	#name : #GTGlamourStepToPresentationBuildAction,
	#superclass : #DebugAction,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStepToPresentationBuildAction class >> gtActionType [
	<gtContextGlamourDebuggingAction>
]

{ #category : #testing }
GTGlamourStepToPresentationBuildAction >> appliesToContext: aContext [

	^ (GTGlamourStackFilter locateBrowserContextFor: aContext) notNil
]

{ #category : #actions }
GTGlamourStepToPresentationBuildAction >> executeAction [
	| presentationCreation presentationCode |
	presentationCreation := self presentationCreationPredicate.
	presentationCode := self presentationCodePredicate.

	self session stepUntil: presentationCreation.
	presentationCreation hasMatched ifTrue: [ 
		self session stepUntil: presentationCode ].
	presentationCode hasMatched ifTrue: [ 
		self session stepInto. ]
		
	
]

{ #category : #'initialize-release' }
GTGlamourStepToPresentationBuildAction >> initialize [

	self label: 'Next presentation build'.
	self icon: GLMUIThemeExtraIcons glamorousPlay.
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
						aContext pc = aContext method initialPC ] ] ]


]
