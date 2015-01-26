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

{ #category : #async }
GTAsyncTask >> complete: anObject callback: aBlock [
	
	process ifNil: [ ^ self terminate ].
	process isTerminated ifFalse: [ "for some cases when we try to return result of wrong process" ^ self ].
	
	callback = aBlock ifFalse: [ ^ self terminate ].
	
	callback ifNotNil: [ callback cull: anObject ].
	process := nil.
]

{ #category : #async }
GTAsyncTask >> execute: aBlock withArguments: aCollection callback: callbackBlock [
	"execution happens with UI process priority so that communication with UI can be done in real time"
	
	self terminate.
	
	callback := callbackBlock.
	process := [ |result|
		result := aBlock valueWithArguments: aCollection.
		"we use it to pass result from background thread and execute callback block in UI thread"
		UIManager default defer: [ self complete: result callback: callbackBlock ]
	]	newProcess.
	
	process priority: Processor userSchedulingPriority.
	process resume.
		
	^ self
]

{ #category : #async }
GTAsyncTask >> terminate [

	process ifNotNil: [ process terminate. process := nil ].
	callback := nil.
]
