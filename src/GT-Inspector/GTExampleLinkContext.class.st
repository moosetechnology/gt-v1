Class {
	#name : #GTExampleLinkContext,
	#superclass : #Dictionary,
	#instVars : [
		'example',
		'links'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #public }
GTExampleLinkContext >> arguments [
	^ self example afterArguments collect: [ :each | 
		self at: each ifAbsent: [ nil ] ]
]

{ #category : #public }
GTExampleLinkContext >> do: aBlock [
	self hasLinks ifFalse: [ ^ aBlock value ].
	^ self withLinksDo: aBlock
]

{ #category : #accessing }
GTExampleLinkContext >> example [
	^ example
]

{ #category : #accessing }
GTExampleLinkContext >> example: anObject [
	example := anObject
]

{ #category : #testing }
GTExampleLinkContext >> hasLinks [
	^ self example afterArguments notEmpty
		and: [ Smalltalk hasClassNamed: #MetaLink ]
]

{ #category : #private }
GTExampleLinkContext >> install [
	| ast link |
	links := OrderedCollection new.
	ast := self example method ast.
	link := MetaLink new 
		metaObject: self; 
		selector: #onLinkNode:arguments:;
		arguments: #( node arguments );
		yourself.
	links add: link.
	ast link: link.
	ast variableWriteNodes do: [ :node | 
		(self example afterArguments includes: node name) ifTrue: [ 
			link := MetaLink new 
				metaObject: self; 
				selector: #onLinkNode:at:put:;
				control: #after;
				arguments: #( node name newValue );
				yourself.
			links add: link.
			node link: link ] ]
]

{ #category : #private }
GTExampleLinkContext >> onLinkNode: aNode arguments: arguments [
	aNode arguments with: arguments do: [ :key :value | 
		self at: key name put: value ]
]

{ #category : #private }
GTExampleLinkContext >> onLinkNode: aNode at: key put: value [
	self at: key put: value
]

{ #category : #private }
GTExampleLinkContext >> uninstall [
	links do: [ :link | link uninstall ].
	links := nil.
]

{ #category : #private }
GTExampleLinkContext >> withLinksDo: aBlock [
	| returnValue |
	[ self install. returnValue := aBlock value ] 
		ensure: [ self uninstall ].
	^ returnValue
]
