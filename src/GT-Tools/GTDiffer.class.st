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
	browser transmit toOutsidePort: #leftClasses; fromOutsidePort: #entity; transformed: [:assoc | assoc key].
	browser transmit toOutsidePort: #rightClasses; fromOutsidePort: #entity; transformed: [:assoc | assoc value].
	browser transmit to: #left; fromOutsidePort: #leftClasses; andShow: [:a | 
		(a custom: GTSimpleClassesMethodsBrowser new browser)
			title: 'Left' ].
	browser transmit to: #right; fromOutsidePort: #rightClasses; andShow: [:a | 
		(a custom: GTSimpleClassesMethodsBrowser new browser)
			title: 'Right' ].
	browser transmit to: #diff; 
		from: #left port: #selectedClass; from: #left port: #selectedMethod;
		from: #right port: #selectedClass; from: #right port: #selectedMethod;
		andShow: [:a | 
		a diff
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
