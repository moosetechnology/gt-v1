"
self openOn: [10000 timesRepeat: [1.23 printString]]
"
Class {
	#name : #GTMessageTallyFinder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTMessageTallyFinder >> buildBrowser [
	| finder |
	finder := GLMFinder new.
	finder list
		title: 'Messages';
		display: [:each | each sonsOver: -1];
		format: [:each | each printString, ' (', each tally printString, ')'].
	browser := GLMTabulator new.
	browser row: #messages; row: #source.
	browser showOn: #messages; using: [browser custom: finder].
	browser showOn: #source; from: #messages; using: [
		browser text
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
