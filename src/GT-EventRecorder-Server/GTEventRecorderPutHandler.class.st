Class {
	#name : #GTEventRecorderPutHandler,
	#superclass : #Object,
	#instVars : [
		'storage'
	],
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #accessing }
GTEventRecorderPutHandler >> directory: aFileReference [ 
	self storage directory: aFileReference
]

{ #category : #testing }
GTEventRecorderPutHandler >> hasCategoryAndDataParts: aCollection [
	aCollection pairsDo: [ :aCategoryPart :aDataPart |
		aCategoryPart fieldName = 'category' ifFalse: [ ^ false ].
		aDataPart fieldName = 'data' ifFalse: [ ^ false ].
		(aCategoryPart contentType matches: ZnMimeType textPlain) ifFalse: [ ^ false ].
		(aDataPart contentType matches: ZnMimeType applicationOctetStream) ifFalse: [ ^ false ].
	 ].
	^ true
]

{ #category : #testing }
GTEventRecorderPutHandler >> isApplicationOctetStream: aZnRequest [
	^ aZnRequest hasEntity and: [ aZnRequest contentType matches: ZnMimeType applicationOctetStream ]
]

{ #category : #testing }
GTEventRecorderPutHandler >> isMultiPartFormData: aZnRequest [
	^ aZnRequest hasEntity 
		and: [ (aZnRequest contentType matches: ZnMimeType multiPartFormData)
		and: [ (aZnRequest entity isEmpty not)
		and: [ aZnRequest entity parts size even
		and: [ self hasCategoryAndDataParts: aZnRequest entity parts ] ] ] ]
]

{ #category : #private }
GTEventRecorderPutHandler >> saveByteArray: aByteArray [
	"storage is responsible for storing aByteArray.
	It returns location."
	^ self storage put: aByteArray.
]

{ #category : #private }
GTEventRecorderPutHandler >> saveByteArray: aByteArray category: aString [ 
	"storage is responsible for storing aByteArray.
	It returns location."
	^ self storage atCategory: aString put: aByteArray.
]

{ #category : #private }
GTEventRecorderPutHandler >> saveMultiPartFormData: anEntity [
	"storage is responsible for storing aByteArray.
	It returns location."
	| keys |
	keys := OrderedCollection new.
	anEntity parts pairsDo: [ :category :data | | key |
		key := self saveByteArray: data fieldValue category: category fieldValue.
		keys addLast: key.
	 ].
	^ keys size printString
]

{ #category : #accessing }
GTEventRecorderPutHandler >> storage [
	^ storage
]

{ #category : #accessing }
GTEventRecorderPutHandler >> storage: anObject [
	storage := anObject
]

{ #category : #evaluating }
GTEventRecorderPutHandler >> value: aZnRequest value: aZnResponse [
	| badRequest key |
	badRequest := [ ^ ZnResponse badRequest: aZnRequest ].
	aZnRequest method = #GET	ifTrue: [ ^ ZnResponse ok: (ZnEntity text: 'OK') ].
	aZnRequest method = #PUT ifFalse: [ badRequest value ].
	(self isApplicationOctetStream: aZnRequest) ifTrue: [ 
			[ key := self saveByteArray: aZnRequest entity bytes ] on: Error do: badRequest.
			^ ZnResponse created: key ].
	(self isMultiPartFormData: aZnRequest) ifTrue: [ 
			[ key := self saveMultiPartFormData: aZnRequest entity ] on: Error do: badRequest.
			^ ZnResponse created: key ].
	badRequest value.
]
