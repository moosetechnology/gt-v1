"
This is a simple browser showing a list of methods on top and the source code below. It is meant to be used inside other browsers.
"
Class {
	#name : #GTSimpleMethodsSourceBrowser,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'title'
	],
	#category : #'GT-Tools-Utils'
}

{ #category : #building }
GTSimpleMethodsSourceBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser row: #methods; row: #source.
	browser transmit to: #methods; andShow: [ :a | 
		a tree
			title: self title;
			display: [ :each | 
				self systemNavigation allSendersOf: ((each isKindOf: MethodReference) ifTrue: [each selector ] ifFalse: [ each ]) ];
			format: [:each | 
				(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]]";
			children: [ :each | 
				(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]]" ].
	browser transmit from: #methods; to: #source; andShow: [:a |
		a text
			forSmalltalk: [:reference | reference actualClass ];
			display: [:reference | reference sourceCode ];
			whenKindOf: MethodReference ].
	browser transmit from: #methods; toOutsidePort: #selection.
	^ browser
]

{ #category : #accessing }
GTSimpleMethodsSourceBrowser >> title [
	^ title
]

{ #category : #accessing }
GTSimpleMethodsSourceBrowser >> title: anObject [
	title := anObject
]
