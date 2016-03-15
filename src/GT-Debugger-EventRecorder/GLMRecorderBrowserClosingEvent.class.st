Class {
	#name : #GLMRecorderBrowserClosingEvent,
	#superclass : #GLMRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'instance creation' }
GLMRecorderBrowserClosingEvent class >> fromAnnouncement: anAnnouncement [

	^ self new fromAnnouncement: anAnnouncement
]

{ #category : #initialization }
GLMRecorderBrowserClosingEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.

	anAnnouncement presentation window ifNotNil: [ :aWindow |
		self infoAt: #windowHash put: aWindow identityHash ]
	
]