"
self openOn: Collection withAllSubclasses andOn: MooseGroup withAllSubclasses
"
Class {
	#name : #GTDiffer,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTDiffer class >> openOn: aCollectionOfClasses andOn: anotherCollectionOfClasses [
	^ self new openOn: aCollectionOfClasses andOn: anotherCollectionOfClasses
]

{ #category : #building }
GTDiffer >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Glamorous Diff Browser'.
	browser
		row: [:r | r column: #left; column: #right ];
		row: #diff.
	browser sendTo: #outer->#leftClasses from: #outer->#entity with: [:assoc | assoc key].
	browser sendTo: #outer->#rightClasses from: #outer->#entity with: [:assoc | assoc value].
	browser showOn: #left; from: #outer->#leftClasses; using: [browser custom: GTSimpleClassesBrowser new browser ].
	browser showOn: #right; from: #outer->#rightClasses; using: [browser custom: GTSimpleClassesBrowser new browser ].
	browser showOn: #diff; 
		from: #left->#selectedClass; from: #left->#selectedMethod;
		from: #right->#selectedClass; from: #right->#selectedMethod;
		using: [
		browser diff
			display: [:leftClass :leftMethod :rightClass :rightMethod | 
				Array with: (leftClass sourceCodeAt: leftMethod) with: (rightClass sourceCodeAt: rightMethod)
			]
		].
	^ browser
]

{ #category : #opening }
GTDiffer >> openOn: aCollectionOfClasses [
	self browser openOn: aCollectionOfClasses andOn: aCollectionOfClasses
]

{ #category : #opening }
GTDiffer >> openOn: aCollectionOfClasses andOn: anotherCollectionOfClasses [
	self browser openOn: aCollectionOfClasses -> anotherCollectionOfClasses
]
