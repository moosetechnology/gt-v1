Class {
	#name : #GTSUnitDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-SUnitDebugger'
}

{ #category : #testing }
GTSUnitDebugger class >> availableAutomatically [
	"Should this debugger be taken into account when looking for a debugger to handle an exception."
	
	^ true
]

{ #category : #accessing }
GTSUnitDebugger class >> defaultTitle [

	^ 'SUnit Debugger'
]

{ #category : #testing }
GTSUnitDebugger class >> handlesContext: aContext [
	| activationPredicate |
	activationPredicate := self sessionClass activationPredicate.
	^ (aContext stackOfSize: self lookupStackSize) 
		detect: [ :ctx | activationPredicate matches: ctx ] 
		 ifFound: [ true ]
		 ifNone: [ false ]
]

{ #category : #testing }
GTSUnitDebugger class >> lookupStackSize [
	^ 10
]

{ #category : #'tools registry' }
GTSUnitDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTSUnitDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 70.
]

{ #category : #accessing }
GTSUnitDebugger class >> sessionClass [

	^ GTSUnitDebugSession
]

{ #category : #'accessing context' }
GTSUnitDebugger >> contextToSelectFrom: aSession [
	^ aSession testContext
]

{ #category : #'building presentations' }
GTSUnitDebugger >> diffIn: composite [

	^ composite diff
			when: [ self session isActive ];
			display: [ 
				{self session actualResult gtSUnitPrint. self session expectedResult gtSUnitPrint} ]
]

{ #category : #'building presentations' }
GTSUnitDebugger >> inspectorIn: aComposite [

	(self diffIn: aComposite) title: 'Actual vs. expected'.
	(super inspectorIn: aComposite) title: 'Inspector'
]

{ #category : #updating }
GTSUnitDebugger >> updateBrowser [

	super updateBrowser.
	"The transmission will select the context of the test case. 
	This should only happen the first time.
	Should find another solution so this method doesn;t have to be overridden"
	((self browser paneNamed: #stack) port: #selection) value: self session interruptedContext
]
