"
self openOn: [10000 timesRepeat: [1.23 printString]]
"
Class {
	#name : #GTMessageTallyFinder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #'as yet unclassified' }
GTMessageTallyFinder >> buildBrowser [
	| finder |
	finder := GLMFinder new.
	finder show: [:a | 
		a list
			title: 'Messages';
			display: [:each | each sonsOver: -1];
			format: [:each | each printString, ' (', each tally printString, ')']].
	browser := GLMTabulator new.
	browser row: #messages; row: #source.
	browser transmit to: #messages; andShow: [:a | a custom: finder].
	browser transmit to: #source; from: #messages; andShow: [ :a | 
		a text
			title: 'Source';
			forSmalltalk: [:each | each method methodClass];			
			display: [:each | each method methodClass sourceCodeAt: each method selector ifAbsent: ['unknown']]
	].
	browser 
		act: [:x |
			(StringHolder new contents: (String streamContents: [:s | x entity report: s; close])) openLabel: 'Spy Results' wrap: false.]
		entitled: 'Print report'.	
	^ browser
]

{ #category : #'as yet unclassified' }
GTMessageTallyFinder >> openOn: aBlock [
	^ super openOn: (MessageTally new spyEvery: 1 on: aBlock; yourself)
]
