Class {
	#name : #GTPlatformDescription,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'parent'
	],
	#classInstVars : [
		'cached'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTPlatformDescription class >> allSymbols [
	^self cached keys
]

{ #category : #'instance creation' }
GTPlatformDescription class >> buildOnSymbol: aSymbol [
	| symbol |
	symbol := aSymbol asSymbol.
	symbol = #'common' ifTrue: [ ^self on: nil symbol: symbol ].
	(#( #'gemstone' #'squeakCommon' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #common) symbol: symbol ].
	(#( #'pharo' #'squeak' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #squeakCommon) symbol: symbol ].
	(#( #'pharo1.x' #'pharo2.x' #'pharo3.x' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #pharo) symbol: symbol ].
	(#( #'pharo1.0.x' #'pharo1.1.x' #'pharo1.2.x' #'pharo1.3.x' #'pharo1.4.x' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #'pharo1.x') symbol: symbol ].
	(#( #'gs2.x' #'gs3.x' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #'gemstone') symbol: symbol ].
	(#( #'gs2.3.x' #'gs2.4.x' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #'gs2.x') symbol: symbol ].
	(#( #'gs3.0.x' #'gs3.1.x' ) includes: symbol) ifTrue: [ ^self on: (self onSymbol: #'gs3.x') symbol: symbol ].
	" if this is reached, we need to specify more symbols in the hierarchie "
	^self on: nil symbol: aSymbol
]

{ #category : #'instance creation' }
GTPlatformDescription class >> cached [
	^cached ifNil: [ cached := Dictionary new ]
]

{ #category : #'instance creation' }
GTPlatformDescription class >> on: aParent symbol: aSymbol [
	^self basicNew
		initialize: aParent symbol: aSymbol;
		yourself
]

{ #category : #'instance creation' }
GTPlatformDescription class >> onSymbol: aSymbol [
	| symbol |
	symbol := aSymbol asSymbol.
	^self cached at: symbol ifAbsentPut: [ self buildOnSymbol: symbol ]
]

{ #category : #'instance creation' }
GTPlatformDescription class >> resetCache [
	cached := nil
]

{ #category : #accessing }
GTPlatformDescription >> attributes [
	^self attributesWith: OrderedCollection new
]

{ #category : #accessing }
GTPlatformDescription >> attributesWith: aCollection [
	self parent ifNotNil: [ self parent attributesWith: aCollection ].
	^aCollection
		add: self symbol;
		yourself
]

{ #category : #testing }
GTPlatformDescription >> hasSymbol: aSymbol [
	" this is case sensitive! "
	^symbol = aSymbol
]

{ #category : #initialization }
GTPlatformDescription >> initialize: aParent symbol: aSymbol [
	self initialize.
	parent := aParent.
	aSymbol = #squeakcommon ifTrue: [ self halt ].
	symbol := aSymbol
]

{ #category : #testing }
GTPlatformDescription >> isParent: aPlatformDescription [ 
	aPlatformDescription ifNil: [ ^false ].
	aPlatformDescription parent = self ifTrue: [ ^true ].
	^self isParent: aPlatformDescription parent
]

{ #category : #accessing }
GTPlatformDescription >> parent [
	^ parent
]

{ #category : #private }
GTPlatformDescription >> parentOrSelfIn: aCollection [ 
	(aCollection includes: self symbol) ifTrue: [ ^self symbol ].
	self parent ifNil: [ ^nil ].
	^self parent parentOrSelfIn: aCollection
]

{ #category : #accessing }
GTPlatformDescription >> parentSymbolIn: aCollection [ 
	self parent ifNil: [ ^nil ].
	^self parent parentOrSelfIn: aCollection
]

{ #category : #accessing }
GTPlatformDescription >> printOn: aStream [
	self symbol printOn: aStream
]

{ #category : #accessing }
GTPlatformDescription >> symbol [
	^ symbol
]
