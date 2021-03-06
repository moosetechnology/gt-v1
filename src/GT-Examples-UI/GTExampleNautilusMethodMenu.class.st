Class {
	#name : #GTExampleNautilusMethodMenu,
	#superclass : #GTAbstractExampleMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExampleNautilusMethodMenu class >> menuFor: aBuilder [
	<contextMenu>
	<nautilusGlobalMethodMenu>
	^ self new
		menuFor: aBuilder
		yourself
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseAfter: aCollection builder: aBuilder [
	aCollection do: [ :after | 
		after forNautilus: [ :title :action | 
			(lastItem := aBuilder item: title)
				parent: #gte;
				action: [ action value ] ] ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseAllDependencies: aCollection builder: aBuilder [
	(lastItem := aBuilder item: #'Browse all dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependenciesOf: aCollection ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseAllDependents: aCollection builder: aBuilder [
	(lastItem := aBuilder item: #'Browse all dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependentsOf: aCollection ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseDependencies: aCollection builder: aBuilder [ 
	(lastItem := aBuilder item: #'Browse dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseDependenciesOf: aCollection ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseDependents: aCollection builder: aBuilder [
	(lastItem := aBuilder item: #'Browse dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseDependentsOf: aCollection ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseExampleSubjects: aCollection builder: aBuilder [
	" this is yet too complicated - SIMPLIFY term and behavior for the user
	
	(lastItem := aBuilder item: #'Browse subjects')
		parent: #gte;
		action: [ GTExampleNavigation browseAllExampleSubjects: aCollection ];
		icon: Smalltalk ui icons glamorousDiveRight
	"
]

{ #category : #private }
GTExampleNautilusMethodMenu >> browseSubjects: aCollection builder: aBuilder [
	" this is yet too complicated - SIMPLIFY term and behavior for the user
	
	aCollection do: [ :subject | 
		subject forNautilus: [ :title :action | 			
			(lastItem := aBuilder item: title)
				parent: #gte;
				action: [ action value ] ] ]
	"
]

{ #category : #public }
GTExampleNautilusMethodMenu >> menuFor: aBuilder [
	| model method examples |
	(model := aBuilder model) ifNil: [ ^ self ].
	(method := model selectedMethod) ifNil: [ ^ self ].
	examples := method gtExamples reject: [ :each | each isNil ].
	
	self buildSubmenu: aBuilder.
	examples ifNotEmpty: [ 
		| problems arguments subjects afters |
		problems := (examples gather: [ :each | each problems ]) reject: [ :each | each isNil ].
		arguments := (examples gather: [ :each | each arguments ]) reject: [ :each | each isNil ].
		afters := (examples collect: [ :each | each after ]) reject: [ :each | each isNil ].
		subjects := (examples gather: [ :each | each subjects ]) reject: [ :each | each isNil ].
		self inspectExamples: [ examples ] builder: aBuilder.
		self inspectReturnValue: [ examples ] builder: aBuilder.
		problems ifNotEmpty: [
			self inspectProblems: [ examples ] builder: aBuilder.
			self buildSeparator ].
		self buildSeparator.
		self runExamples: [ examples ] builder: aBuilder.
		self debugExamples: [ examples ] builder: aBuilder ]
]

{ #category : #private }
GTExampleNautilusMethodMenu >> submenuOrder [
	^ 1450
]
