Class {
	#name : #GTExampleMethodIcon,
	#superclass : #GTAbstractExampleMethod,
	#instVars : [
		'converter'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #'as yet unclassified' }
GTExampleMethodIcon class >> fromBase64String: aString [
	^ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: aString readStream)
]

{ #category : #converters }
GTExampleMethodIcon class >> fromByteArray: aByteArray [
	^ self fromByteArray: aByteArray extent: 16@16 depth: 32 offset: 0@0
]

{ #category : #converters }
GTExampleMethodIcon class >> fromByteArray: aByteArray extent: anExtent depth: aDepth offset: anOffset [
	^ Form
		extent: anExtent
		depth: aDepth
		fromArray: aByteArray 
		offset: anOffset
]

{ #category : #private }
GTExampleMethodIcon >> basicForm [
	^ self class 
		perform: self converter 
		withArguments: { self provider perform: self selector }
]

{ #category : #'accessing-dynamic' }
GTExampleMethodIcon >> form [
	^ self exists
		ifTrue: [ self basicForm ]
		ifFalse: [ nil ]
]
