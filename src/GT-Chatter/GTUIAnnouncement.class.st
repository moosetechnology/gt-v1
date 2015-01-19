Class {
	#name : #GTUIAnnouncement,
	#superclass : #GTAnnouncement,
	#instVars : [
		'widget'
	],
	#category : #'GT-Chatter-Announcements'
}

{ #category : #accessing }
GTUIAnnouncement >> widget [
	^ widget
]

{ #category : #accessing }
GTUIAnnouncement >> widget: anObject [
	widget := anObject
]
