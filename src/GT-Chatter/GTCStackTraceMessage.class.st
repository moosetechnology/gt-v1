Class {
	#name : #GTCStackTraceMessage,
	#superclass : #GTCAddressedMessage,
	#instVars : [
		'stack',
		'title'
	],
	#category : #'GT-Chatter-RemoteAnnouncements'
}

{ #category : #converting }
GTCStackTraceMessage >> asMessageMorph [
	^ GTCStackTraceBrick new
			message: self;
			yourself
]

{ #category : #protocol }
GTCStackTraceMessage >> materialize [
	^ FLMaterializer materializeFromByteArray: self stack
]

{ #category : #accessing }
GTCStackTraceMessage >> stack [
	^ stack unzipped
]

{ #category : #accessing }
GTCStackTraceMessage >> stack: aByteArray [ 
	stack := aByteArray zipped
]

{ #category : #accessing }
GTCStackTraceMessage >> title [
	^ title
]

{ #category : #accessing }
GTCStackTraceMessage >> title: aString [ 
	title := aString
]
