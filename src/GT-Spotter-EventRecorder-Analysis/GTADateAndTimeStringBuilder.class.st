Class {
	#name : #GTADateAndTimeStringBuilder,
	#superclass : #Object,
	#instVars : [
		'dateAndTime',
		'duration',
		'numberOfLabels'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTADateAndTimeStringBuilder >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
GTADateAndTimeStringBuilder >> dateAndTime: anObject [
	dateAndTime := anObject
]

{ #category : #accessing }
GTADateAndTimeStringBuilder >> duration [
	^ duration
]

{ #category : #accessing }
GTADateAndTimeStringBuilder >> duration: anObject [
	duration := anObject
]

{ #category : #'as yet unclassified' }
GTADateAndTimeStringBuilder >> humanReadablePrintString [
	self duration days > self numberOfLabels ifTrue: [ ^ self dateAndTime asDate printString ].
	self duration days > 1 ifTrue: [ ^ String streamContents: [ :aStream | 
			self dateAndTime printSeparateDateAndTimeOn: aStream ] ]. 
	self duration minutes > self numberOfLabels ifTrue: [ ^ self dateAndTime asTime print24 ].
	self duration minutes > 1 ifTrue: [ ^ String streamContents: [ :aStream | 
			self dateAndTime printMSOn: aStream ] ].
	^ self dateAndTime asSeconds printString
]

{ #category : #accessing }
GTADateAndTimeStringBuilder >> numberOfLabels [
	^ numberOfLabels
]

{ #category : #accessing }
GTADateAndTimeStringBuilder >> numberOfLabels: anObject [
	numberOfLabels := anObject
]
