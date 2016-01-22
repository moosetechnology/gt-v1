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
		'filter',
		'cache',
		'continuing'
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
	^ cache
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

{ #category : #private }
GTSpotterContext >> continueFilter [
	| processors nonEmptyProcessors |
	processors := self cache at: #processors ifAbsent: [ ^ self ].
	nonEmptyProcessors := processors associations select: [ :assoc | assoc key hasFilteredCandidates ].
	nonEmptyProcessors size = 1 ifFalse: [ ^ self ].
	self withContinue: true do: [ 
		nonEmptyProcessors do: [ :assoc | 
			assoc key continueFilterInContext: self ] ]
]

{ #category : #accessing }
GTSpotterContext >> continuing [
	^ continuing
]

{ #category : #accessing }
GTSpotterContext >> continuing: anObject [
	continuing := anObject
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultCache [
	^ IdentityDictionary new 
		at: #processors put: IdentityDictionary new;
		yourself
]

{ #category : #'accessing-defaults' }
GTSpotterContext >> defaultContinuing [
	^ false
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

{ #category : #private }
GTSpotterContext >> doContinueFilterForProcessor: aGTProcessor [
	self processor: aGTProcessor.
	self filter: ((self cache at: #processors) at: aGTProcessor).
	" any limit above 100 is just insane ! Spotter needs a different kind of visualization canvas ... something like like lazy loading "
	^ aGTProcessor withItemsLimit: 95 " = 100 - 5 " do: [ filter value: self ]
]

{ #category : #private }
GTSpotterContext >> doFilter: aGTFilter forProcessor: aGTProcessor [
	self processor: aGTProcessor.
	self filter: aGTFilter.
	(self cache at: #processors) at: aGTProcessor put: aGTFilter.
	^ aGTFilter value: self
]

{ #category : #comparing }
GTSpotterContext >> equals: aContext [
	aContext ifNil: [ ^ false ].
   ^ self matches: aContext text
]

{ #category : #public }
GTSpotterContext >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GTCurrentSpotterExceptionHandler value ifNil: [ self step exceptionHandler ]
]

{ #category : #accessing }
GTSpotterContext >> filter [
	^ filter
]

{ #category : #accessing }
GTSpotterContext >> filter: anObject [
	filter := anObject
]

{ #category : #initializing }
GTSpotterContext >> initialize [
	super initialize.
	
	cache := self defaultCache.
	text := self defaultText.
	continuing := self defaultContinuing.
]

{ #category : #testing }
GTSpotterContext >> isEmpty [
	^ self text isNil
		or: [ self textTrimmed isEmpty ]
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

{ #category : #'accessing-dynamic' }
GTSpotterContext >> spotter [
	^ self step spotter
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
	^ text
]

{ #category : #accessing }
GTSpotterContext >> text: anObject [
	text := anObject ifNil: [ self defaultText ]
]

{ #category : #public }
GTSpotterContext >> textLowercase [
	^ textLowercase ifNil: [ textLowercase := self defaultTextLowercase ]
]

{ #category : #public }
GTSpotterContext >> textTrimmed [
	^ textTrimmed ifNil: [ textTrimmed := self defaultTextTrimmed ]
]

{ #category : #private }
GTSpotterContext >> withContinue: aBoolean do: aBlock [
	| previousContinuing |
	previousContinuing := continuing.
	^ [ continuing := aBoolean. aBlock value ]
		ensure: [ continuing := previousContinuing ]
]
