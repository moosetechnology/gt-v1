Class {
	#name : #GTSpotterCandidateProxy,
	#superclass : #Object,
	#instVars : [
		'candidate'
	],
	#category : #'GT-Spotter-Utils'
}

{ #category : #accessing }
GTSpotterCandidateProxy >> candidate [
	^ candidate
]

{ #category : #accessing }
GTSpotterCandidateProxy >> candidate: anObject [
	candidate := anObject
]

{ #category : #scripting }
GTSpotterCandidateProxy >> gtDisplayString [
	^ self candidate gtDisplayString
]

{ #category : #scripting }
GTSpotterCandidateProxy >> spotterActionsForMetacelloFor: aStep [
	<spotterOrder: 2>
	^ aStep listProcessor
			title: 'Metacello Actions';
			allCandidates: [
				(self candidate class organization listAtCategoryNamed: 'loading') 
					select: [ :each | each beginsWith: 'load' ] 
					thenCollect: [ :each | (self candidate class >> each) ] ];
			itemName: [ :method | method selector ];
			itemIcon: [ Smalltalk ui icons downIcon ];
			actLogic: [ :method | method valueWithReceiver: method methodClass arguments: #() ];
			filterUsing: GTFilterSubstring
]
