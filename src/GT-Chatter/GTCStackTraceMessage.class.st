Class {
	#name : #GTCStackTraceMessage,
	#superclass : #GTCAddressedMessage,
	#instVars : [
		'stack'
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
