Class {
	#name : #GTUIAnnouncement,
	#superclass : #GTInternalAnnouncement,
	#instVars : [
		'widget'
	],
	#category : #'GT-Chatter-InternalAnnouncements'
}

{ #category : #accessing }
GTUIAnnouncement >> widget [
	^ widget
]

{ #category : #accessing }
GTUIAnnouncement >> widget: anObject [
	widget := anObject
]
