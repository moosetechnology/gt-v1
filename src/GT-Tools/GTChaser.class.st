"
The Chaser unifies the navigation of both senders and implementors. Each pane represents either a method reference or a symbol, and it reveals its implementors and the senders in two different tabs.

self openOn: #methodsBrowser
"
Class {
	#name : #GTChaser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTChaser >> buildBrowser [
	"self openOn: #browser"
	browser := GLMFinder new.
	browser title: [:each | 'Chasing Browser of #', each].
	browser show: [:a |
		a title: [ :each | self titleOf: each ].
		a custom: (self 
					methodsBrowserFor: #allSendersOf:
					title: 'Senders').
		a custom: (self 
					methodsBrowserFor: #allImplementorsOf:
					title: 'Implementors') ].
	^ browser
]

{ #category : #private }
GTChaser >> childrenOf: each [
	^ (each isKindOf: MethodReference)
		ifTrue: [ each compiledMethod messages ]
		ifFalse: [ OrderedCollection new ] 
]

{ #category : #private }
GTChaser >> methodActionsFor: aListPresentation [
	
	| actions |
	actions := OrderedCollection new.
	(aListPresentation selection isKindOf: MethodReference) ifTrue: [
		actions add: (GLMMorphicAction new 
						action: [:list | list selection browse]; 
						icon: GLMUIThemeExtraIcons glamorousBrowse;
						title: 'Browse';
						yourself) ].
	^ actions
]

{ #category : #private }
GTChaser >> methodsBrowserFor: aSymbol title: aString [
	"this defines a simple browser that can displayed both senders and implementors.
	aSymbol is either #allSendersOf: or #allImplementorsOf:"
	| methodsBrowser |
	methodsBrowser := GLMTabulator new.
	methodsBrowser row: #methods; row: #source.
	methodsBrowser title: aString.
	methodsBrowser transmit to: #methods; andShow: [ :a | 
		a tree
			showOnly: 20;
			display: "[ :each | aBlock value: each ]"
					[:each | self systemNavigation perform: aSymbol with: ((each isKindOf: MethodReference) ifTrue: [each selector ] ifFalse: [ each ])];
			format: [:method | self titleOf: method ];
			children: [:each | self childrenOf: each];
			dynamicActionsOnSelection: [ :list | self methodActionsFor: list ] ].
	methodsBrowser transmit from: #methods; to: #source; andShow: [:some |
		some text
			forSmalltalk: [:reference | reference actualClass ];
			display: [:reference | reference sourceCode ];
			whenKindOf: MethodReference ].
	methodsBrowser transmit from: #methods; toOutsidePort: #selection.
	^ methodsBrowser
]

{ #category : #private }
GTChaser >> titleOf: aSymbolOrReference [
	^ (aSymbolOrReference isKindOf: MethodReference)
		ifTrue: [ aSymbolOrReference classSymbol , '>>' , aSymbolOrReference selector ]
		ifFalse: [ aSymbolOrReference ]
]
