"
self openOn: #browse
"
Class {
	#name : #GTClassicChaser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTClassicChaser >> buildBrowser [
	"self openOn: #buildBrowser"

	| finder |
	finder := self finder.
	browser := GLMTabulator new.
	browser title: [ :each | 'Chasing ' , each asString ].
	browser
		row: #finder;
		row: #details.
	browser transmit 
		to: #finder;
		andShow: [:a | a custom: finder ].
	browser
		transmit to: #details;
		from: #finder;
		andShow: [:a | 
					(a text)
						forSmalltalk: [ :reference | reference actualClass ];
						display: [ :reference | [ reference compiledMethod getSource ] on: Error do: [ 'source not found' ] ];
						whenKindOf: MethodReference ].
	^ browser
]

{ #category : #building }
GTClassicChaser >> finder [
	| finder |
	finder := GLMFinder new.
	finder
		show: [ :a | 
			a title: [ :each | self titleOf: each ].
			self implementorsIn: a.
			self sendersIn: a ].
	^ finder
]

{ #category : #building }
GTClassicChaser >> implementorsIn: a [
	^ (a tree)
		title: 'Implementors';
		showOnly: 20;
		display: [ :each | 
					self systemNavigation
						allImplementorsOf:
							((each isKindOf: MethodReference)
								ifTrue: [ each selector ]
								ifFalse: [ each ]) ];
		format: [ :each | self titleOf: each ];
		selectionAct: [:each | each selection inspect ] on: $i entitled: 'Inspect';
		children: [ :each | 
					(each isKindOf: MethodReference)
						ifTrue: [ each compiledMethod messages ]
						ifFalse: [ OrderedCollection new ] ]
]

{ #category : #building }
GTClassicChaser >> sendersIn: a [
	^ (a tree)
		title: 'Senders';
		showOnly: 20;
		display: [ :each | 
					self systemNavigation
						allSendersOf:
							((each isKindOf: MethodReference)
								ifTrue: [ each selector ]
								ifFalse: [ each ]) ];
		format: [ :each | self titleOf: each ];
		selectionAct: [:each | each selection inspect ] on: $i entitled: 'Inspect';
		children: [ :each | 
					(each isKindOf: MethodReference)
						ifTrue: [ each compiledMethod messages ]
						ifFalse: [ OrderedCollection new ] ]
]

{ #category : #building }
GTClassicChaser >> titleOf: aSymbolOrReference [
	^ (aSymbolOrReference isKindOf: MethodReference)
		ifTrue: [ aSymbolOrReference classSymbol , '>>' , aSymbolOrReference selector ]
		ifFalse: [ aSymbolOrReference ]
]
