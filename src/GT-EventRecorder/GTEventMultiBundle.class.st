Class {
	#name : #GTEventMultiBundle,
	#superclass : #Object,
	#instVars : [
		'url',
		'bundles'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #adding }
GTEventMultiBundle >> add: aGTEventBundle [ 
	^ self bundles addLast: aGTEventBundle
]

{ #category : #accessing }
GTEventMultiBundle >> bundles [
	^ bundles ifNil: [ bundles := OrderedCollection new ]
]

{ #category : #accessing }
GTEventMultiBundle >> bundles: anObject [
	bundles := anObject
]

{ #category : #'as yet unclassified' }
GTEventMultiBundle >> entity [
	| entity |
	entity := ZnMultiPartFormDataEntity new.
	self updateEntity: entity.
	^ entity
]

{ #category : #private }
GTEventMultiBundle >> updateEntity: aZnMultiPartFormDataEntity [ 
	bundles ifNil: [ ^ self ].
	self bundles do: [ :eachBundle |
		aZnMultiPartFormDataEntity 
			addPart: (ZnMimePart fieldName: 'category' value: eachBundle category);
			addPart: (ZnMimePart fieldName: 'data' value: eachBundle data) ]
]

{ #category : #accessing }
GTEventMultiBundle >> url [
	^ url
]

{ #category : #accessing }
GTEventMultiBundle >> url: anObject [
	url := anObject
]
