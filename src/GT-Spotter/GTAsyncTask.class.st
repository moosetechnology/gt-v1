"
This is a utility that: 
- executes a job asynchroniously
- it remembers the process so that it can terminate the job, if needed
- triggers a callback when it's done
"
Class {
	#name : #GTAsyncTask,
	#superclass : #Object,
	#instVars : [
		'process',
		'callback'
	],
	#category : #'GT-Spotter-Async'
}

{ #category : #'as yet unclassified' }
GTAsyncTask >> complete: anObject callback: aBlock [
	
	process ifNil: [ ^ self terminate ].
	process isTerminated ifFalse: [ "for some cases when we try to return result of wrong process" ^ self ].
	
	callback = aBlock ifFalse: [ ^ self terminate ].
	
	callback ifNotNil: [ callback cull: anObject ].
	process := nil.
]

{ #category : #'as yet unclassified' }
GTAsyncTask >> execute: aBlock withArguments: aCollection callback: callbackBlock [
	"execution happens with UI process priority so that comunication with UI can be done in real time"
	
	self terminate.
	
	callback := callbackBlock.
	process := [ |result|
		result := aBlock valueWithArguments: aCollection.
		"we use it to pass result from background thread and execute callback block in UI thread"
		UIManager default defer: [ self complete: result callback: callbackBlock ]
	]	newProcess
		resume.
		
	^ self
]

{ #category : #'as yet unclassified' }
GTAsyncTask >> terminate [

	process ifNotNil: [ process terminate. process := nil ].
	callback := nil.
]
