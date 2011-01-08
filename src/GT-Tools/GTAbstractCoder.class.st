Class {
	#name : #GTAbstractCoder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Coder'
}

{ #category : #reusable }
GTAbstractCoder >> classReferencesIn: a [
	(a list)
		title: 'References';
		useExplicitNotNil;
		when: [ :package :class | class notNil ];
		display: [ :package :class | self systemNavigation allCallsOn: (Smalltalk associationAt: class name) ];
		selectionPopulate: #focusOnMethod
			on: $f
			entitled: 'Jump there'
			with: [ :list | list selection ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]

{ #category : #reusable }
GTAbstractCoder >> classSourceIn: a [
	(a text)
		forSmalltalk;
		title: 'Class';
		useExplicitNotNil;
		when: [ :package :class :method | class notNil and: [ method isNil ] ];
		display: [ :package :class | class definition ]
]

{ #category : #reusable }
GTAbstractCoder >> classesIn: a [ 
	a list
		title: 'Classes';
		display: [ :package | package classes ];
		format: [ :each :package |
			(package extendsClass: each)
				ifTrue: [Text string: each name asString attribute: TextColor gray]
				ifFalse: [each name asString] ];
		selectionAct: [:list | list selection inspect] on: $/ entitled: 'Inspect'
]

{ #category : #reusable }
GTAbstractCoder >> detailsIn: a [
	self methodSourceCodeIn: a.
	self classSourceIn: a.
	self classReferencesIn: a.
	self sendersIn: a.
	self implementorsIn: a
]

{ #category : #reusable }
GTAbstractCoder >> implementorsIn: a [
	(a list)
		title: 'Implementors';
		display: [ :package :class :method | (self systemNavigation allImplementorsOf: method selector) ];
		selectionPopulate: #focusOnMethod
			on: $f
			entitled: 'Jump there'
			with: [ :list | list selection ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]

{ #category : #reusable }
GTAbstractCoder >> methodSourceCodeIn: a [
	a text 
		title: 'Method';
		forSmalltalk: [:package :class | class ];
		display: [:package :class :method |
			method getSource ].

]

{ #category : #reusable }
GTAbstractCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages asSortedCollection: [:x :y | x name < y name ] ];
		format: [:each | each name]
]

{ #category : #reusable }
GTAbstractCoder >> sendersIn: a [
	(a list)
		title: 'Senders';
		display: [ :package :class :method | self systemNavigation allSendersOf: method selector];
		selectionPopulate: #focusOnMethod
			on: $j
			entitled: 'Jump there'
			with: [ :list | list selection ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]
