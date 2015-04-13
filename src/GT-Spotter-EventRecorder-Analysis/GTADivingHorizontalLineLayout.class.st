Class {
	#name : #GTADivingHorizontalLineLayout,
	#superclass : #RTHorizontalLineLayout,
	#instVars : [
		'diveInLevel'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #accessing }
GTADivingHorizontalLineLayout >> diveElement: eachElement [
	^ (self diveInLevel cull: eachElement cull: self)
 			* self diveStep
]

{ #category : #accessing }
GTADivingHorizontalLineLayout >> diveInLevel [
	^ diveInLevel ifNil: [ diveInLevel := self newDiveInLevel ]
]

{ #category : #accessing }
GTADivingHorizontalLineLayout >> diveStep [
	^ 10
]

{ #category : #hook }
GTADivingHorizontalLineLayout >> doExecute: elements [
	super doExecute: elements.
	elements do: [ :eachElement |
		eachElement translateBy: 0 @ (self diveElement: eachElement) ].
]

{ #category : #'instance creation' }
GTADivingHorizontalLineLayout >> newDiveInLevel [
	^ [ :element | #diveInLevel cull: element model ]
]
