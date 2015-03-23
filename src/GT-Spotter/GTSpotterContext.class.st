Class {
	#name : #GTSpotterContext,
	#superclass : #Object,
	#instVars : [
		'step',
		'stream',
		'text',
		'textTrimmed',
		'textLowercase',
		'processor',
		'cache'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #public }
GTSpotterContext >> addItem: anObject [
	self stream addObject: anObject inProcessor: self processor
]

{ #category : #public }
GTSpotterContext >> addItems: aCollection [

	self stream addObjects: aCollection inProcessor: self processor
]

{ #category : #accessing }
GTSpotterContext >> cache [
	^ cache ifNil: [ cache := self defaultCache ]
]

{ #category : #accessing }
GTSpotterContext >> cache: anObject [
	cache := anObject
]

{ #category : #public }
GTSpotterContext >> cacheAt: aSymbol [
	^ self cacheAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #public }
GTSpotterContext >> cacheAt: aSymbol ifAbsent: aBlock [
	^ self cache at: aSymbol ifAbsent: aBlock
]

{ #category : #public }
GTSpotterContext >> cacheAt: aSymbol ifAbsentPut: aBlock [
	^ self cache at: aSymbol ifAbsentPut: aBlock
]

{ #category : #public }
GTSpotterContext >> cacheAt: aSymbol put: anObject [
	^ self cache at: aSymbol put: anObject
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultCache [
	^ IdentityDictionary new 
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultText [
	^ ''
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultTextLowercase [
	^ self textTrimmed asLowercase
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultTextTrimmed [
	^ self text trimBoth
]

{ #category : #comparing }
GTSpotterContext >> equals: aContext [
	aContext ifNil: [ ^ false ].
   ^ self matches: aContext text
]

{ #category : #testing }
GTSpotterContext >> isEmpty [
	^ self text isNil
		or: [ self text isEmpty ]
]

{ #category : #public }
GTSpotterContext >> itemsLimit [
	^ self processor itemsLimit
]

{ #category : #testing }
GTSpotterContext >> matches: aString [
	^ self isEmpty not
		and: [ self text = aString ]
]

{ #category : #testing }
GTSpotterContext >> notEmpty [
	^ self isEmpty not
]

{ #category : #accessing }
GTSpotterContext >> processor [
	^ processor
]

{ #category : #accessing }
GTSpotterContext >> processor: anObject [
	processor := anObject
]

{ #category : #public }
GTSpotterContext >> removeCacheAt: aSymbol [
	^ self cache removeKey: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
GTSpotterContext >> step [
	^ step
]

{ #category : #accessing }
GTSpotterContext >> step: anObject [
	step := anObject
]

{ #category : #accessing }
GTSpotterContext >> stream [
	^ stream
]

{ #category : #accessing }
GTSpotterContext >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
GTSpotterContext >> text [
	^ text ifNil: [ text := self defaultText ]
]

{ #category : #accessing }
GTSpotterContext >> text: anObject [
	text := anObject
]

{ #category : #public }
GTSpotterContext >> textLowercase [
	^ textLowercase ifNil: [ textLowercase := self defaultTextLowercase ]
]

{ #category : #public }
GTSpotterContext >> textTrimmed [
	^ textTrimmed ifNil: [ textTrimmed := self defaultTextTrimmed ]
]
