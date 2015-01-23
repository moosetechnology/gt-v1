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
	^ GTCLabeledButtonBrick new
			data: self;
			text: 'Click to debug stack trace';
			action: [ self materialize ];
			enable;
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
