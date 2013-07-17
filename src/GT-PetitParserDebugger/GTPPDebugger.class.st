Class {
	#name : #GTPPDebugger,
	#superclass : #GTDebugger,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPDebugger class >> contextLocator [

	^ GTPPContextLocator new
]

{ #category : #accessing }
GTPPDebugger class >> defaultTitle [

	^ 'PetitParser Debugger'
]

{ #category : #testing }
GTPPDebugger class >> handlesContext: aContext [

	^ (self locateRootParserContextFor: aContext) notNil 
]

{ #category : #'as yet unclassified' }
GTPPDebugger class >> locateRootParserContextFor: aContext [

	^ self contextLocator locateRootParserContextFor: aContext
]

{ #category : #'tools registry' }
GTPPDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 55.
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> createPredicatForBlock: aBlock [ 

	^ StepContextPredicate new 
			"baseContext: self debugger rootBrowserContext;"
			predicate: aBlock
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> debuggingActionsPragmas [

	^ super debuggingActionsPragmas, { #PPDebuggingAction }
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> parseMethodEntryPredicate [

	^ self createPredicatForBlock: [ :aContext |
			(aContext methodClass inheritsFrom: PPParser) and: [ 
				aContext selector = #parseOn: and: [ 
					aContext isInitialnstruction ] ] ]
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> stepToNextParser [

	(self parseMethodEntryPredicate verify: self interruptedContext; hasMatched )  ifTrue: [ 
		self session stepInto ].

	self session stepUntil: self parseMethodEntryPredicate
]
