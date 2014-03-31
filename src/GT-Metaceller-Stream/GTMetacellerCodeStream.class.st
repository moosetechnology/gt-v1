Class {
	#name : #GTMetacellerCodeStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'currentTag'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #'instance creation' }
GTMetacellerCodeStream class >> on: aStream [
	^self new
		stream: aStream;
		yourself
]

{ #category : #generating }
GTMetacellerCodeStream >> close [
	self currentTag ifNotNilDo: [ :t | t close ]
]

{ #category : #accessing }
GTMetacellerCodeStream >> currentTag [
	^ currentTag
]

{ #category : #generating }
GTMetacellerCodeStream >> method: aMethodName versionName: aVersionName importedVersions: aCollection [ 
	^self openMethod
		method: aMethodName version: aVersionName importedVersions: aCollection;
		yourself
]

{ #category : #generating }
GTMetacellerCodeStream >> open: aTag [
	self currentTag ifNil: [ ^currentTag := aTag ].
	^self currentTag open: aTag
]

{ #category : #generating }
GTMetacellerCodeStream >> openCascade [
	^self open: (GTCascadeTag on: self)
]

{ #category : #generating }
GTMetacellerCodeStream >> openComment [
	^self open: (GTCommentTag on: self)
]

{ #category : #generating }
GTMetacellerCodeStream >> openMethod [
	^self open: (GTMethodTag on: self)
]

{ #category : #accessing }
GTMetacellerCodeStream >> openTag [
	self currentTag ifNil: [ ^nil ].
	^self currentTag currentOpenTag
]

{ #category : #generating }
GTMetacellerCodeStream >> startCascade: aString [ 
	^self openCascade
		receiver: aString;
		yourself
]

{ #category : #generating }
GTMetacellerCodeStream >> startComment: aString [ 
	^self openComment
		string: aString;
		yourself
]

{ #category : #accessing }
GTMetacellerCodeStream >> stream [
	^ stream
]

{ #category : #accessing }
GTMetacellerCodeStream >> stream: anObject [
	stream := anObject
]

{ #category : #generating }
GTMetacellerCodeStream >> version: aString importedVersions: aCollection [
	^self openMethod
		version: aString importedVersions: aCollection;
		yourself
]
